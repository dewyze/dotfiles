-- Rewrite one-line `let(:name) { body }` definitions as `name = body`.
local M = {}

local LET = [[\v^(\s*)let!?\(:(\w+)\)\s*\{\s*(.{-})\s*\}\s*$]]

function M.to_assignment(bufnr, first, last)
	vim.api.nvim_buf_call(bufnr, function()
		vim.cmd(string.format([[keeppatterns silent! %d,%ds/%s/\1\2 = \3/]], first, last, LET))
	end)
end

return M
