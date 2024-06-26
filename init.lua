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

vim.keymap.set("n", "<leader>nh", ":nohls<CR>", { silent = true })

-- let g:rubycomplete_buffer_loading = 1
--
-- Plug '~/.config/nvim/local-plugins/color-schemes'
-- Plug 'bling/vim-airline', {'commit': '4e2546a2098954b74cbc612f573826f13d6fb88e'}
-- " Plug 'edkolev/tmuxline.vim', {'commit': '30012a964e8bd06e9b7612e2a838ef51a1993b0d'}
-- Plug 'ekalinin/Dockerfile.vim', {'commit': 'bf29af1c79df21aefd3f68660cc8c57a78f14021'}
-- Plug 'elixir-editors/vim-elixir', {'commit': '088cfc407460dea7b81c10b29db23843f85e7919'} | Plug 'slashmili/alchemist.vim', {'tag': '3.4.0'}
-- Plug 'elmcast/elm-vim', {'commit': 'ae5315396cd0f3958750f10a5f3ad9d34d33f40d'} " TODO: Update with elm-tooling
-- Plug 'preservim/vim-markdown'
-- Plug 'junegunn/vim-easy-align'
-- Plug 'kana/vim-textobj-user'
-- Plug 'KeitaNakamura/neodark.vim'
-- Plug 'leafgarland/typescript-vim'
-- Plug 'mattn/emmet-vim', {'commit': 'c7643e5b616430f766528b225528a5228adb43df'} " TODO: Remember to use
-- Plug 'MaxMEllon/vim-jsx-pretty', { 'commit': '838cfce82df8cf99df5e3a200ad23f6c0f027550' }
-- Plug 'nelstrom/vim-textobj-rubyblock'
-- Plug 'pangloss/vim-javascript', {'commit': 'db595656304959dcc3805cf63ea9a430e3f01e8f'}
-- Plug 'rhysd/vim-gfm-syntax', {'commit': 'c0ff9e4994d4e79c8d5edf963094518dceea2623'}
-- Plug 'slim-template/vim-slim', {'commit': '6673e404370e6f3d44be342cf03ea8c26ab02c66'}
-- Plug 'tpope/vim-speeddating'
-- Plug 'tpope/vim-abolish', {'commit': '7e4da6e78002344d499af9b6d8d5d6fcd7c92125'} " TODO: Check it out
-- Plug 'tpope/vim-fugitive', {'commit': '5a24c2527584e4e61a706ad7ecb3514ac7031307'}
-- Plug 'tpope/vim-projectionist', {'commit': '17a8b2078a9ca1410d2080419e1cb9c9bb2e4492'}
-- Plug 'tpope/vim-ragtag', {'commit': '5d3ce9c1ae2232170a3f232c1e20fa832d15d440'}
-- Plug 'tpope/vim-rails', {'commit': '64befc6187678893082bebb8be79c1d17fdd07ba'} " TODO: Shortcuts for jumping to related model/controller, extraction
-- Plug 'tpope/vim-repeat', {'commit': 'c947ad2b6a16983724a0153bdf7f66d7a80a32ca'}
-- Plug 'vim-airline/vim-airline-themes', {'commit': '9772475fcc24bee50c884aba20161465211520c8'}
-- Plug 'vim-ruby/vim-ruby', {'commit': 'fbf85d106a2c3979ed43d6332b8c26a72542754d'}
--
-- Plug 'dewyze/vim-endwise'
--
-- " Plug '~/dev/vim-ignore'
--
-- if s:use_lua
--   Plug 'neovim/nvim-lspconfig'
-- else
--   Plug 'autozimu/LanguageClient-neovim', { 'branch': 'next', 'do': 'bash install.sh' }
--
-- "   Plug '~/dev/neoprism.vim'
-- "   Plug 'windwp/nvim-autopairs'
-- "   Plug 'windwp/nvim-ts-autotag', {'branch': 'main'}
-- "   Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
-- "   Plug 'RRethy/nvim-treesitter-endwise'
-- "   Plug 'nvim-treesitter/playground'
-- "   Plug 'tjdevries/colorbuddy.vim'
-- endif
--
-- call plug#end()
--
--
-- if s:use_lua
--   luafile ~/dotfiles/initlua.lua
-- endif
--
--
-- " ========= Plugin Settings ========
--
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
-- " 'mattn/emmet-vim'
-- let g:user_emmet_install_global = 0
-- let g:user_emmet_leader_key='<C-H>'
--
-- " ========= Color Schemes ========
-- if s:neoprism
--   colorscheme neoprism
-- else
--   try
--     let g:neodark#background = '#282828'
--     colorscheme neodark
--     au FileType ruby,eruby colorscheme Tomorrow-Night
--     hi def link CopilotSuggestion Comment
--   catch
--     colorscheme Tomorrow-Night
--   endtry
-- endif
-- " au FileType diff colorscheme desert
-- " au FileType git colorscheme desert
--
--
-- " ========= Shortcuts ========
--
-- map <silent> <LocalLeader>nh :nohls<CR>
-- " imap </ </<C-X><C-O>
-- " nmap <CR><CR> i<CR><esc>w
-- nmap <C-W>m <C-W>_<C-W>\|
--
-- nnoremap <LocalLeader>p :set paste!<CR>
--
-- " ========= Terminal Shortcuts ========
-- nnoremap <LocalLeader>tty :terminal<CR>i
-- nnoremap <LocalLeader>tts :split<CR> :wincmd j<CR> :terminal<CR>i
-- nnoremap <LocalLeader>ttv :vsplit<CR> :wincmd l<CR> :terminal<CR>i
-- tnoremap <C-q> <C-\><C-n>:bd!<CR>
-- tnoremap qq <C-\><C-n>
--
-- " ========= Insert Shortcuts ========
--
-- autocmd FileType elixir,elm imap <buffer> <C-L> <SPACE>-><SPACE>
-- autocmd FileType ruby,eelixir,eruby,erb,javascript imap <buffer> <C-L> <SPACE>=><SPACE>
-- " imap <C-L> <SPACE>=><SPACE>
-- imap <C-X>l {%<SPACE><SPACE>%}<esc>hhi
-- imap <C-X>v {{<SPACE><SPACE>}}<esc>hhi
--
-- " ========= Visual Shortcuts ========
-- " Move visual block
-- vnoremap J :m '>+1<CR>gv=gv
-- vnoremap K :m '<-2<CR>gv=gv
--
-- " ========= Functions ========
--
-- command! SudoW w !sudo tee %
--
-- function! GitGrepWord()
--   cgetexpr system("git grep -n '" . expand("<cword>") . "'")
--   cwin
--   echo 'Number of matches: ' . len(getqflist())
-- endfunction
-- command! -nargs=0 GitGrepWord :call GitGrepWord()
-- nnoremap <silent> <Leader>gw :GitGrepWord<CR>
--
-- command! Yankfname let @* = expand("%")
-- nnoremap <C-G> :Yankfname<CR> <C-G>
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
