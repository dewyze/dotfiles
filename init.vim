" ========= Setup ========
set nocompatible

" ========= Options ========
set cursorline
set guicursor=
set hidden
set ignorecase
set number
set scrolloff=5
set showmatch
set smartcase
set tags+=gems.tags
set undofile
set undolevels=1000 "maximum number of changes that can be undone
set undoreload=10000 "maximum number lines to save for undo on a buffer reload

if !has('nvim')
  set background=dark
  set backspace=indent,eol,start
  set dir=/tmp//
  set hlsearch
  set incsearch
  set undodir=~/.vim/undodir
endif

set tabstop=2 shiftwidth=2 softtabstop=2 expandtab
set wildignore+=*.pyc,*.o,*.class,*.lo,.git,vendor/*,node_modules/**,bower_components/**,elm-stuff/**,elm.js
set wildignore+=*/tmp/*,*.so,*.swp,*.zip

let g:rubycomplete_buffer_loading = 1

runtime macros/matchit.vim

" ==== Syntax Highlight Reveal ====
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
autocmd BufNewFile,BufRead *.md,*.markdown setlocal filetype=ghmarkdown
autocmd BufNewFile,BufReadPost *.go set filetype=go
autocmd BufNewFile,BufRead *.slim setlocal filetype=slim
autocmd FileType elixir setlocal tabstop=2 shiftwidth=2 softtabstop=2
autocmd FileType elm setlocal expandtab
autocmd FileType gitcommit set tw=72
autocmd FileType go setlocal tabstop=2 shiftwidth=2 softtabstop=2
autocmd FileType html setlocal tabstop=2 shiftwidth=2 softtabstop=2
autocmd FileType java setlocal tabstop=4 shiftwidth=4 softtabstop=4
autocmd FileType javascript setlocal tabstop=2 shiftwidth=2 softtabstop=2
autocmd FileType json setlocal tabstop=2 shiftwidth=2 softtabstop=2 nospell
autocmd FileType md setlocal tabstop=2 shiftwidth=2 softtabstop=2
autocmd FileType php setlocal tabstop=4 shiftwidth=4 softtabstop=4
autocmd FileType python setlocal tabstop=4 shiftwidth=4 softtabstop=4
autocmd FileType ruby runtime ruby_mappings.vim
autocmd FileType yml setlocal filetype=yaml expandtab
autocmd FileType html,slim IndentLinesEnable

" Autoremove trailing spaces when saving the buffer
autocmd FileType ruby,elm,yml,javscript,json,go,md,slim,css,scss,js autocmd BufWritePre <buffer> %s/\s\+$//e

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
call plug#begin('~/.config/nvim/plugged')

Plug '~/.config/nvim/local-plugins/color-schemes'

" Plug 'jlanzarotta/bufexplorer', {'tag': 'v7.4.6'}
Plug 'benmills/vimux', {'commit': '2285cefee9dfb2139ebc8299d11a6c8c0f21309e'} | Plug 'janko-m/vim-test', {'tag': 'v2.1.0'}
Plug 'edkolev/tmuxline.vim', {'commit': '05c687014272abca548d72cfd5d8a7b7c3fb7e5e'}
Plug 'ekalinin/Dockerfile.vim', {'commit': 'c3e2568c0f09ffb5b84b3c16e1e366285afed31b'}
Plug 'elixir-editors/vim-elixir', {'commit': '5a32e60ac5e55c18702e0d6aed25aa8e37873cb2'} | Plug 'slashmili/alchemist.vim', {'tag': '3.0.0'}
Plug 'godlygeek/tabular', {'tag': '1.0.0'}
Plug 'henrik/vim-indexed-search', {'commit': '1bae237136610b9dc5dd131588c752f9476d4fb4'}
Plug 'jtratner/vim-flavored-markdown', {'commit': '4a70aa2e0b98d20940a65ac38b6e9acc69c6b7a0'}
Plug 'pangloss/vim-javascript', {'tag': '1.2.5.1'}
Plug 'slim-template/vim-slim', {'commit': 'df26386b46b455f0c837c3ba30d1771204f209ca'}
Plug 'tpope/vim-abolish', {'commit': 'b6a8b49e2173ba5a1b34d00e68e0ed8addac3ebd'}
Plug 'tpope/vim-endwise', {'commit': '0067ceda37725d01b7bd5bf249d63b1b5d4e2ab4'}
Plug 'tpope/vim-fugitive', {'commit': '008b9570860f552534109b4f618cf2ddd145eeb4'}
Plug 'tpope/vim-projectionist', {'commit': '45ee461393045bace391e8f196cc87141754b196'}
Plug 'tpope/vim-ragtag', {'commit': '5762a937f39d165b9773376960539f8c32788325'}
Plug 'tpope/vim-rails', {'commit': 'abf87ba2ebe07e1a4112a7921c06842070ef2f81'}
Plug 'tpope/vim-repeat', {'commit': '070ee903245999b2b79f7386631ffd29ce9b8e9f'}
Plug 'tpope/vim-surround', {'commit': 'e49d6c2459e0f5569ff2d533b4df995dd7f98313'}
Plug 'vim-ruby/vim-ruby', {'commit': '5bac0d81e96edf33ffbf4b01653dfbdf68b77240'}

" Plugin 'elzr/vim-json'
" let g:vim_json_syntax_conceal = 0
Plug 'gcmt/taboo.vim', {'commit': '1367baf547ff931b63ea6a389e551f4ed280eadf'}
map <silent> <LocalLeader>to :TabooOpen
map <silent> <LocalLeader>t, :TabooRename
map <silent> <LocalLeader>tc :tabclose<CR>

Plug 'tomtom/tcomment_vim', {'tag': '3.08'}

Plug 'scrooloose/nerdtree', {'tag': '5.0.0'}

Plug 'junegunn/fzf', { 'tag': '0.16.7', 'dir': '~/.fzf', 'do': './install --bin' } | Plug 'junegunn/fzf.vim', {'commit': '990834ab6cb86961e61c55a8e012eb542ceff10e'}
Plug 'elmcast/elm-vim', {'commit': 'ae5315396cd0f3958750f10a5f3ad9d34d33f40d'}

Plug 'bling/vim-airline', {'commit': '466198adc015a9d81e975374d8e206dcf3efd173'}
Plug 'vim-airline/vim-airline-themes'
Plug 'Yggdroot/indentLine'
let g:indentLine_char = '⎸'
let g:indentLine_enabled = 0
let g:indentLine_color_term = 236
let g:indentLine_bgcolor_term = 235
" let g:indentLine_color_gui = '#FF00FF'

Plug '~/dev/vim-rspec-block-helpers'
Plug 'mhinz/vim-mix-format'
let g:mix_format_on_save = 1
call plug#end()


" Plugin Settings

let g:projectionist_heuristics = {
      \ "mix.exs": {
      \   "lib/*.ex": {"alternate": "test/{}_test.exs"},
      \   "test/*_test.exs": {"alternate": "lib/{}.ex"}
      \   }
      \ }

" Tmuxline
let g:tmuxline_powerline_separators = 0

" TComment
map <silent> <LocalLeader>cc :TComment<CR>

" NERDTree
let NERDTreeIgnore=['\.pyc', '\.o', '\.class', '\.lo',"elm-stuff","elm.js"]
map <silent> <LocalLeader>nt :NERDTreeToggle<CR>
map <silent> <LocalLeader>nr :NERDTree<CR>
map <silent> <LocalLeader>nf :NERDTreeFind<CR>

" Vimux
let g:VimuxUseNearestPane = 1
" let g:VimuxOrientation = "h"
" let g:VimuxHeight = "40"

" fzf
let $FZF_DEFAULT_OPTS = '--reverse'
let g:fzf_layout = {'up': '~20%'}
let g:fzf_tags_command = 'ctags -R --exclude=".git" --exclude="node_modules" --exclude="vendor" --exclude="log" --exclude="tmp" --exclude="db" --exclude="pkg" --exclude="deps" --exclude="_build" --extra=+f .'
map <silent> <leader>ff :Files<CR>
map <silent> <leader>be :Buffers<CR>
map <silent> <leader>ft :Tags<CR>

let $FZF_DEFAULT_COMMAND = 'find * -type f 2>/dev/null | grep -v -E "deps\/|_build\/|node_modules\/|vendor\/|elm-stuff\/"'
if executable('rg')
  let $FZF_DEFAULT_COMMAND = 'rg --files'
endif

" alchemist
let g:alchemist#elixir_erlang_src = "~/dev/docs/sources/alchemist"

" elm-vim
let g:elm_format_autosave = 1

" vim-test
let test#strategy = "vimux"
function! ClearTransform(cmd) abort
  return 'clear; ' . a:cmd
endfunction
let g:test#custom_transformations = {'clear': function('ClearTransform')}
let g:test#transformation = 'clear'
nnoremap <silent> <leader>rf :wa<CR>:TestNearest<CR>
nnoremap <silent> <leader>rb :wa<CR>:TestFile<CR>
nnoremap <silent> <leader>ra :wa<CR>:TestSuite<CR>
nnoremap <silent> <leader>rl :wa<CR>:TestLast<CR>

" Color
colorscheme Tomorrow-Night
au FileType diff colorscheme desert
au FileType git colorscheme desert


" ========= Shortcuts ========

map <silent> <LocalLeader>nh :nohls<CR>
" imap </ </<C-X><C-O>
nmap <CR><CR> i<CR><esc>w
nmap <C-W>m <C-W>\| <C-W>_
nnoremap <LocalLeader>p :set paste!<CR>

" ========= Insert Shortcuts ========

imap <C-L> <SPACE>=><SPACE>
imap jj <C-C>

" ========= Functions ========

command! SudoW w !sudo tee %

function! GitGrepWord()
  cgetexpr system("git grep -n '" . expand("<cword>") . "'")
  cwin
  echo 'Number of matches: ' . len(getqflist())
endfunction
command! -nargs=0 GitGrepWord :call GitGrepWord()
nnoremap <silent> <Leader>gw :GitGrepWord<CR>

if has('nvim') && filereadable(glob("~/.config/nvim/init.vim.local"))
  source ~/.config/nvim/init.vim.local
elseif !has('nvim') && filereadable(glob("~/.vimrc.local"))
  source ~/.vimrc.local
endif

let g:airline_powerline_fonts = 1
let g:tmuxline_powerline_separators = 1

" Cursorline coloring for bright environments
" autocmd BufEnter * highlight CursorLine ctermbg=Yellow ctermfg=Black cterm=bold
" autocmd BufLeave * highlight CursorLine ctermbg=Yellow ctermfg=None cterm=bold
