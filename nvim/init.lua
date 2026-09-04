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
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.undofile = true
vim.o.foldenable = false
vim.o.wildignore =
	"*.pyc,*.o,*.class,*.lo,.git,vendor/*,node_modules/**,bower_components/**,elm-stuff/**,elm.js,*/tmp/*,*.so,*.swp,*zip"
vim.cmd([[
  autocmd FileType * autocmd BufWritePre <buffer> %s/\s\+$//e
]])

-- ========= Normal Shortcuts ========
vim.keymap.set("n", "<C-c>", ":nohlsearch<CR>", { silent = true, desc = "clear search highlight" })
vim.keymap.set("n", "<CR><CR>", "i<CR><esc>w")
vim.keymap.set("n", "<C-w>m", "<C-w>|<C-w>_")

-- Toggle comments via built-in gcc/gc. <C-_> is the terminal fallback for <C-/>.
vim.keymap.set("n", "<C-/>", "gcc", { remap = true, silent = true })
vim.keymap.set("n", "<C-_>", "gcc", { remap = true, silent = true })
vim.keymap.set("x", "<C-/>", "gc", { remap = true, silent = true })
vim.keymap.set("x", "<C-_>", "gc", { remap = true, silent = true })

-- ========= Step layer ([ ]) — see KEYBINDINGS.md ========
-- Shadow core's ]t/[t tag-stepping (dead weight under LSP); tabs are the
-- ordered list worth stepping. gt/gT remain native.
vim.keymap.set("n", "]t", ":tabnext<CR>", { silent = true, desc = "step: next tab" })
vim.keymap.set("n", "[t", ":tabprevious<CR>", { silent = true, desc = "step: previous tab" })
vim.keymap.set("n", "]g", ":TourNext<CR>", { silent = true, desc = "step: next tour stop" })
vim.keymap.set("n", "[g", ":TourPrev<CR>", { silent = true, desc = "step: previous tour stop" })

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
-- " ========= Yank domain (\y) ========
-- 'clipboard' is unset on purpose, so @0 and @+ stay separate and nothing
-- reaches the system clipboard by accident. These ferry it across on request.
-- Paths are cwd-relative, which is the project root in practice.
vim.cmd('command! Clip let @+ = @0')

local function clip(text)
  vim.fn.setreg("+", text)
  vim.notify(text)
end

-- Visual range as start[-end]; line("v") is the other end of the selection.
local function selected_lines()
  local a, b = vim.fn.line("v"), vim.fn.line(".")
  if a > b then
    a, b = b, a
  end
  return a == b and tostring(a) or (a .. "-" .. b)
end

vim.keymap.set("n", "<leader>yy", ":Clip<CR>", { silent = true, desc = "yank: last yank to clipboard" })
vim.keymap.set("x", "<leader>yy", '"+y', { desc = "yank: selection to clipboard" })
vim.keymap.set("n", "<leader>yf", ":%y+<CR>", { silent = true, desc = "yank: whole file to clipboard" })
vim.keymap.set("n", "<leader>yn", function() clip(vim.fn.expand("%:p:.")) end, { desc = "yank: path (relative)" })
vim.keymap.set("n", "<leader>yN", function() clip(vim.fn.expand("%:p")) end, { desc = "yank: path (absolute)" })
vim.keymap.set("n", "<leader>yl", function()
  clip(vim.fn.expand("%:p:.") .. ":" .. vim.fn.line("."))
end, { desc = "yank: path:line" })
vim.keymap.set("x", "<leader>yl", function()
  clip(vim.fn.expand("%:p:.") .. ":" .. selected_lines())
end, { desc = "yank: path:lines" })
-- GBrowse! copies the forge URL instead of opening it; rhubarb resolves GitHub.
-- The '.' range matters: bare GBrowse! yields a branch URL with no line anchor,
-- which moves under you. Given a range, fugitive pins the SHA and the lines.
vim.keymap.set("n", "<leader>yg", ":.GBrowse!<CR>", { silent = true, desc = "yank: git permalink" })
vim.keymap.set("x", "<leader>yg", ":GBrowse!<CR>", { silent = true, desc = "yank: git permalink (lines)" })

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
