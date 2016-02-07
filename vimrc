" ========= Setup ========
set nocompatible

if &shell == "/usr/bin/sudosh"
  set shell=/bin/zsh
endif

filetype off
compiler ruby

" ========= Options ========
set background=dark
set foldlevel=99
set backspace=indent,eol,start
set cursorline
set dir=/tmp//
set hidden
set hlsearch
set ignorecase
set incsearch
set number
set ruler
set scrolloff=5
set showmatch
set smartcase
set tags+=gems.tags
set wrap

set textwidth=0 nosmartindent tabstop=2 shiftwidth=2 softtabstop=2 expandtab
set wildignore+=*.pyc,*.o,*.class,*.lo,.git,vendor/*,node_modules/**,bower_components/**
set wildignore+=*/tmp/*,*.so,*.swp,*.zip 

let g:rubycomplete_buffer_loading = 1

runtime macros/matchit.vim

if version >= 703
  set undodir=~/.vim/undodir
  set undofile
  set undoreload=10000 "maximum number lines to save for undo on a buffer reload
endif
set undolevels=1000 "maximum number of changes that can be undone

" Color
colorscheme Tomorrow-Night
au FileType diff colorscheme desert
au FileType git colorscheme desert
au BufWinLeave * colorscheme Tomorrow-Night

" ==== Syntax Highlight Reveal ====
set laststatus=2
" set statusline+=%{synIDattr(synID(line('.'),col('.'),1),'name')}

nmap <Leader>sI :call <SID>SynStack()<CR>
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc
" ====

" File Types
" autocmd! bufwritepost .vimrc source $MYVIMRC
autocmd BufNewFile,BufReadPost *.go set filetype=go
autocmd FileType php setlocal tabstop=4 shiftwidth=4 softtabstop=4
autocmd FileType python setlocal tabstop=4 shiftwidth=4 softtabstop=4
autocmd FileType java setlocal tabstop=4 shiftwidth=4 softtabstop=4
autocmd FileType javascript setlocal tabstop=4 shiftwidth=4 softtabstop=4
autocmd FileType html setlocal tabstop=2 shiftwidth=2 softtabstop=2
autocmd FileType less setlocal tabstop=2 shiftwidth=2 softtabstop=2
autocmd FileType cs setlocal tabstop=4 shiftwidth=4 softtabstop=4
autocmd FileType go setlocal tabstop=2 shiftwidth=2 softtabstop=2
autocmd FileType elixir setlocal tabstop=2 shiftwidth=2 softtabstop=2
autocmd FileType tex setlocal textwidth=78
autocmd FileType ruby runtime ruby_mappings.vim
autocmd BufNewFile,BufRead *.txt setlocal textwidth=78
autocmd BufNewFile,BufRead *.md,*.markdown setlocal filetype=ghmarkdown
autocmd FileType md setlocal tabstop=2 shiftwidth=2 softtabstop=2
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Autoremove trailing spaces when saving the buffer
autocmd FileType c,cpp,elixir,eruby,html,ghmarkdown,go,java,javascript,less,md,php,ruby autocmd BufWritePre <buffer> :%s/\s\+$//e


" Fix indenting for html files
let g:html_indent_inctags = "html,head,body"
let g:html_indent_script1 = "inc" 
let g:html_indent_style1 = "inc"

" Status
set laststatus=2
set statusline=
set statusline+=%<\                       " cut at start
set statusline+=%2*[%n%H%M%R%W]%*\        " buffer number, and flags
set statusline+=%-40f\                    " relative path
set statusline+=%=                        " seperate between right- and left-aligned
set statusline+=%1*%y%*%*\                " file type
set statusline+=%10(L(%l/%L)%)\           " line
set statusline+=%2(C(%v/125)%)\           " column

" ========= Plugin Options ========
set rtp+=$GOROOT/misc/vim
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'

Plugin 'godlygeek/tabular'
Plugin 'henrik/vim-indexed-search'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'vim-ruby/vim-ruby'
Plugin 'pangloss/vim-javascript'
Plugin 'elixir-lang/vim-elixir'
Plugin 'tpope/vim-rails'
Plugin 'crookedneighbor/bufexplorer'
Plugin 'pgr0ss/vimux-ruby-test'
Plugin 'plasticboy/vim-markdown'
Plugin 'tpope/vim-endwise'
Plugin 'jtratner/vim-flavored-markdown'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
Plugin 'jgdavey/vim-turbux'
Plugin 'epmatsw/ag.vim'
Plugin 'groenewege/vim-less'
Plugin 'ekalinin/Dockerfile.vim'
Plugin 'mattn/emmet-vim'
Plugin 'edkolev/tmuxline.vim'
let g:tmuxline_powerline_separators = 0
Plugin 'fatih/vim-go'
let g:go_highlight_operators = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_fmt_command = "goimports"

Plugin 'tpope/vim-commentary'
map <silent> <LocalLeader>cc :Commentary<CR>

Plugin 'scrooloose/nerdtree'
let NERDTreeIgnore=['\.pyc', '\.o', '\.class', '\.lo']
let NERDTreeHijackNetrw = 0
map <silent> <LocalLeader>nt :NERDTreeToggle<CR>
map <silent> <LocalLeader>nr :NERDTree<CR>
map <silent> <LocalLeader>nf :NERDTreeFind<CR>

Plugin 'benmills/vimux'
Plugin 'benmills/vimux-golang'
let g:VimuxUseNearestPane = 1
map <silent> <LocalLeader>rl :wa<CR> :VimuxRunLastCommand<CR>
map <silent> <LocalLeader>vi :wa<CR> :VimuxInspectRunner<CR>
map <silent> <LocalLeader>vk :wa<CR> :VimuxInterruptRunner<CR>
map <silent> <LocalLeader>vx :wa<CR> :VimuxClosePanes<CR>
map <silent> <LocalLeader>vp :VimuxPromptCommand<CR>
vmap <silent> <LocalLeader>vs "vy :call VimuxRunCommand(@v)<CR>
nmap <silent> <LocalLeader>vs vip<LocalLeader>vs<CR>

Plugin 'kien/ctrlp.vim'
let g:ctrlp_show_hidden = 1
let g:ctrlp_match_window_bottom = 0
let g:ctrlp_match_window_reversed = 0
map <silent> <LocalLeader>mr :CtrlPMRU<CR>
map <silent> <C-p><C-b> :CtrlPBuffer<CR>
map <silent> <leader>ff :CtrlP<CR>

Plugin 'mileszs/ack.vim'
let g:AckAllFiles = 0
let g:AckCmd = 'ack --type-add ruby=.feature --ignore-dir=tmp 2> /dev/null'
map <LocalLeader>aw :Ack '<C-R><C-W>'

Plugin 'scrooloose/syntastic'
let g:syntastic_python_python_exec = '/usr/local/bin/python3'
let g:syntastic_ruby_checkers = ['mri', 'rubocop']
let g:syntastic_mode_map = { "mode": "passive" }

" ========= Shortcuts ========

map <silent> <LocalLeader>rt :!ctags -R --exclude=".git\|.svn\|log\|tmp\|db\|pkg" --extra=+f --langmap=Lisp:+.clj<CR>
map <silent> <LocalLeader>nh :nohls<CR>
map <silent> <LocalLeader>bd :bufdo :bd<CR>
" imap </ </<C-X><C-O>
cnoremap <Tab> <C-L><C-D>
nmap <CR><CR> i<CR><esc>w            

" ========= Insert Shortcuts ========

imap <C-L> <SPACE>=><SPACE>
imap <C-E>= <lt>%=  %><esc>hhi
imap <C-E>- <lt>%  %><esc>hhi
imap jj <ESC>                        

" ========= Functions ========

command! SudoW w !sudo tee %

function! GitGrepWord()
  cgetexpr system("git grep -n '" . expand("<cword>") . "'")
  cwin
  echo 'Number of matches: ' . len(getqflist())
endfunction
command! -nargs=0 GitGrepWord :call GitGrepWord()
nnoremap <silent> <Leader>gw :GitGrepWord<CR>
"
" Cursorline coloring for bright environments
" autocmd BufEnter * highlight CursorLine ctermbg=Yellow ctermfg=Black cterm=bold
" autocmd BufLeave * highlight CursorLine ctermbg=Yellow ctermfg=None cterm=bold 

if filereadable(glob("~/.vimrc.local"))
  source ~/.vimrc.local
endif

call vundle#end()            " required
syntax on
filetype plugin indent on    " required
