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

return M
