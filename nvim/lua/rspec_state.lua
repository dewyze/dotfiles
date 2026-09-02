-- Resolve the effective RSpec state (let/subject definitions) for the
-- example group enclosing a position, honoring let threading.
local M = {}

local function method_name(call, bufnr)
	local method = call:field("method")[1]
	if method and method:type() == "identifier" then
		return vim.treesitter.get_node_text(method, bufnr)
	end
end

local GROUP_METHODS = { describe = true, context = true, it = true }
local DEF_METHODS = { let = true, ["let!"] = true, subject = true, ["subject!"] = true }

-- A let-style definition call -> entry, or nil.
local function def_entry(call, bufnr)
	local kind = method_name(call, bufnr)
	if not (kind and DEF_METHODS[kind]) then
		return nil
	end
	local name
	local args = call:field("arguments")[1]
	local sym = args and args:named_child(0)
	if sym and sym:type() == "simple_symbol" then
		name = vim.treesitter.get_node_text(sym, bufnr):sub(2)
	elseif kind == "subject" or kind == "subject!" then
		name = "subject"
	else
		return nil
	end
	local row = call:range()
	return { name = name, kind = kind, lnum = row + 1 }
end

-- Direct statements of a group's block, skipping the body wrapper node.
local function block_statements(group)
	local block = group:field("block")[1]
	if not block then
		return {}
	end
	local statements = {}
	for child in block:iter_children() do
		if child:type() == "body_statement" or child:type() == "block_body" then
			for statement in child:iter_children() do
				if statement:named() then
					table.insert(statements, statement)
				end
			end
		end
	end
	return statements
end

function M.resolve(bufnr, lnum, col)
	local parser = vim.treesitter.get_parser(bufnr, "ruby")
	local root = parser:parse()[1]:root()
	local node = root:named_descendant_for_range(lnum - 1, col, lnum - 1, col)

	-- Enclosing it/context/describe calls, innermost first.
	local chain = {}
	while node do
		if node:type() == "call" and GROUP_METHODS[method_name(node, bufnr)] then
			table.insert(chain, node)
		end
		node = node:parent()
	end

	local anchor
	if chain[1] then
		local row = chain[1]:range()
		anchor = { lnum = row + 1, kind = method_name(chain[1], bufnr) }
	end

	-- Merge outer -> inner: one winner per name, first-appearance order,
	-- with the shadowed definitions threaded onto the winner (nearest first).
	local entries = {}
	local index_of = {}
	for i = #chain, 1, -1 do
		for _, statement in ipairs(block_statements(chain[i])) do
			if statement:type() == "call" then
				local entry = def_entry(statement, bufnr)
				if entry then
					local existing = index_of[entry.name]
					if existing then
						local shadowed = entries[existing]
						entry.overridden = { { kind = shadowed.kind, lnum = shadowed.lnum } }
						vim.list_extend(entry.overridden, shadowed.overridden)
						entries[existing] = entry
					else
						entry.overridden = {}
						table.insert(entries, entry)
						index_of[entry.name] = #entries
					end
				end
			end
		end
	end

	return { anchor = anchor, entries = entries }
end

-- Aligned "kind name :lnum" rows, override chains trailing.
local function render(entries)
	local kind_width, name_width = 0, 0
	for _, entry in ipairs(entries) do
		kind_width = math.max(kind_width, #entry.kind)
		name_width = math.max(name_width, #entry.name)
	end
	local lines = {}
	for _, entry in ipairs(entries) do
		local line = string.format(
			"%-" .. kind_width .. "s  %-" .. name_width .. "s  :%d",
			entry.kind,
			entry.name,
			entry.lnum
		)
		if #entry.overridden > 0 then
			local refs = {}
			for _, shadowed in ipairs(entry.overridden) do
				table.insert(refs, ":" .. shadowed.lnum)
			end
			line = line .. "  (overrides " .. table.concat(refs, ", ") .. ")"
		end
		table.insert(lines, line)
	end
	return lines
end

function M.show()
	local bufnr = vim.api.nvim_get_current_buf()
	local source_win = vim.api.nvim_get_current_win()
	local pos = vim.api.nvim_win_get_cursor(source_win)
	local result = M.resolve(bufnr, pos[1], pos[2])
	if not result.anchor then
		vim.notify("rspec_state: no enclosing it/context/describe", vim.log.levels.INFO)
		return
	end

	local lines = render(result.entries)
	if #lines == 0 then
		lines = { "(no let/subject state)" }
	end
	local width = 0
	for _, line in ipairs(lines) do
		width = math.max(width, vim.fn.strdisplaywidth(line))
	end

	-- Above the anchor line so the state reads as belonging to what's below;
	-- flip below when the window has no room above (border needs 2 rows).
	local rows_above = result.anchor.lnum - vim.fn.line("w0", source_win)
	local placement = { anchor = "SW", bufpos = { result.anchor.lnum - 1, 0 } }
	if rows_above < #lines + 2 then
		placement = { anchor = "NW", bufpos = { result.anchor.lnum, 0 } }
	end

	local float_buf = vim.api.nvim_create_buf(false, true)
	vim.api.nvim_buf_set_lines(float_buf, 0, -1, false, lines)
	vim.bo[float_buf].modifiable = false
	local float_win = vim.api.nvim_open_win(float_buf, true, {
		relative = "win",
		win = source_win,
		bufpos = placement.bufpos,
		anchor = placement.anchor,
		width = width,
		height = #lines,
		style = "minimal",
		border = "rounded",
	})

	vim.keymap.set("n", "<CR>", function()
		local entry = result.entries[vim.api.nvim_win_get_cursor(float_win)[1]]
		vim.api.nvim_win_close(float_win, true)
		if entry then
			vim.api.nvim_win_set_cursor(source_win, { entry.lnum, 0 })
		end
	end, { buffer = float_buf })
	for _, key in ipairs({ "q", "<Esc>" }) do
		vim.keymap.set("n", key, function()
			vim.api.nvim_win_close(float_win, true)
		end, { buffer = float_buf })
	end
end

return M
