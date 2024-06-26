require("config.lazy")

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
vim.keymap.set("n", "<leader>sv", ":source %<CR>")

vim.cmd([[
  autocmd FileType * autocmd BufWritePre <buffer> %s/\s\+$//e
]])

vim.cmd([[
  nmap <Leader>sI :call SynStack()<CR>
  " function! <SID>SynStack()
  "   if !exists("*synstack")
  "     return
  "   endif
  "   echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
  " endfunc
  function! SynStack()
    echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
  \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
  \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"
  endfunction
]])

-- ========= Normal Shortcuts ========
vim.keymap.set("n", "<leader>nh", ":nohls<CR>", { silent = true })
vim.keymap.set("i", "</", "</<C-X><C-O>")
vim.keymap.set("n", "<CR><CR>", "i<CR><esc>w")
vim.keymap.set("n", "<C-W>m", "<C-W>_<C-W>\\|")
vim.keymap.set("n", "<leader>p", ":set paste!<CR>")

-- " ========= Insert Shortcuts ========
vim.keymap.set("i", "<C-L>", "<SPACE>=><SPACE>")
vim.cmd("autocmd FileType elixir,elm imap <buffer> <C-L> <SPACE>-><SPACE>")
vim.keymap.set("i", "<C-X>l", "{%<SPACE><SPACE>%}<esc>hhi")
vim.keymap.set("i", "<C-X>v", "{{<SPACE><SPACE>}}<esc>hhi")

-- " ========= Visual Shortcuts ========
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- " ========= Commands ========
vim.cmd('command! Yankfname let @* = expand("%")')
vim.keymap.set("n", "<C-G>", ":Yankfname<CR> <C-G>")

if vim.fn.filereadable("~/.config/nvim/init.vim.local") then
  vim.cmd("source ~/.config/nvim/init.vim.local")
end

-- let g:rubycomplete_buffer_loading = 1
--
-- Plug '~/.config/nvim/local-plugins/color-schemes'
-- Plug 'bling/vim-airline', {'commit': '4e2546a2098954b74cbc612f573826f13d6fb88e'}
-- " Plug 'edkolev/tmuxline.vim', {'commit': '30012a964e8bd06e9b7612e2a838ef51a1993b0d'}
-- Plug 'KeitaNakamura/neodark.vim'
-- Plug 'rhysd/vim-gfm-syntax', {'commit': 'c0ff9e4994d4e79c8d5edf963094518dceea2623'}
-- Plug 'vim-airline/vim-airline-themes', {'commit': '9772475fcc24bee50c884aba20161465211520c8'}
--
-- "   Plug '~/dev/neoprism.vim'
-- "   Plug 'windwp/nvim-autopairs'
-- "   Plug 'windwp/nvim-ts-autotag', {'branch': 'main'}
-- "   Plug 'tjdevries/colorbuddy.vim'
--
-- " ========= Plugin Settings ========
--
-- " 'bling/vim-airline'
-- let g:airline_powerline_fonts = 1
-- let g:tmuxline_powerline_separators = 1
-- let g:airline#extensions#branch#vcs_checks = []
--
-- " 'edkolev/tmuxline.vim'
-- let g:tmuxline_powerline_separators = 0
--
-- " 'elmcast/elm-vim'
-- let g:elm_format_autosave = 1
--
--
-- " ========= Functions ========
--
-- command! SudoW w !sudo tee %
--
--
-- if s:has_nvim && filereadable(glob("~/.config/nvim/init.vim.local"))
--   source ~/.config/nvim/init.vim.local
-- elseif !s:has_nvim && filereadable(glob("~/.vimrc.local"))
--   source ~/.vimrc.local
-- endif
--
-- let g:airline_powerline_fonts = 1
-- let g:airline_theme='tomorrow'
-- " let g:lightline.colorscheme = 'neodark'
-- let g:tmuxline_powerline_separators = 1
--
-- " Cursorline coloring for bright environments
-- " autocmd BufEnter * highlight CursorLine ctermbg=Yellow ctermfg=Black cterm=bold
-- " autocmd BufLeave * highlight CursorLine ctermbg=Yellow ctermfg=None cterm=bold
