require("config.lazy")
require("config.lsp")

vim.cmd("set tabstop=2 shiftwidth=2 softtabstop=2 expandtab")
vim.o.confirm = true
vim.o.cursorline = true
vim.o.ignorecase = true
vim.o.mouse = ""
vim.o.number = true
vim.o.smartcase = true
vim.o.scrolloff = 5
vim.o.showmatch = true
vim.o.undofile = true
vim.o.foldenable = false
vim.o.wildignore =
	"*.pyc,*.o,*.class,*.lo,.git,vendor/*,node_modules/**,bower_components/**,elm-stuff/**,elm.js,*/tmp/*,*.so,*.swp,*zip"
vim.cmd([[
  autocmd FileType * autocmd BufWritePre <buffer> %s/\s\+$//e
]])

-- ========= Normal Shortcuts ========
vim.keymap.set("n", "<CR><CR>", "i<CR><esc>w")
vim.keymap.set("n", "<C-w>m", "<C-w>|<C-w>_")

-- Toggle comments via built-in gcc/gc. <C-_> is the terminal fallback for <C-/>.
vim.keymap.set("n", "<C-/>", "gcc", { remap = true, silent = true })
vim.keymap.set("n", "<C-_>", "gcc", { remap = true, silent = true })
vim.keymap.set("x", "<C-/>", "gc", { remap = true, silent = true })
vim.keymap.set("x", "<C-_>", "gc", { remap = true, silent = true })

-- ========= Show namespace (C-s: panels, drawers) — see KEYBINDINGS.md ========
vim.keymap.set("n", "<C-s><C-q>", function()
	local qf_open = vim.fn.getqflist({ winid = 0 }).winid ~= 0
	vim.cmd(qf_open and "cclose" or "copen")
end, { desc = "show: quickfix" })
vim.keymap.set("n", "<C-s><C-t>", ":belowright split | terminal<CR>", { silent = true, desc = "show: terminal" })
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "exit terminal mode" })

-- " ========= Insert Shortcuts ========
vim.keymap.set("i", "<C-L>", "<SPACE>=><SPACE>")
vim.cmd("autocmd FileType elixir,elm imap <buffer> <C-L> <SPACE>-><SPACE>")

-- " ========= Visual Shortcuts ========
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- " ========= Commands ========
vim.cmd('command! Yankfname let @* = expand("%")')
vim.keymap.set("n", "<C-G>", ":Yankfname<CR> <C-G>")

vim.cmd([[
  if (has("termguicolors"))
    set termguicolors
  endif
]])

vim.cmd('let g:markdown_recommended_style = 0')

function UnwrapBlock()
  vim.fn.search("do\\($\\| |\\)\\| {\\($\\|\\s*|\\)", "W", vim.fn.line("."))
  vim.cmd("normal V%<gv")
  vim.cmd("'>d|'<d")
end
vim.keymap.set("n", "<leader>ru", UnwrapBlock, { silent = true, desc = "refactor: unwrap ruby block" })

function WrapBlock()
  vim.cmd("normal j")
  vim.fn.search("do\\($\\| |\\)\\| {\\($\\|\\s*|\\)", "W", vim.fn.line("."))
  vim.cmd("normal %oend")
  vim.cmd("normal V%=")
end
vim.keymap.set("n", "<leader>rw", WrapBlock, { silent = true, desc = "refactor: wrap ruby block" })
