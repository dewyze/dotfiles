" ========= Setup ========
set nocompatible

" ========= Options ========
set cursorline
set confirm
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

let s:has_nvim = has('nvim')

if !s:has_nvim
  set background=dark
  set backspace=indent,eol,start
  set dir=/tmp//
  set hlsearch
  set incsearch
  set undodir=~/.vim/undodir
endif
  set termguicolors

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
autocmd BufNewFile,BufReadPost *.go set filetype=go
autocmd BufNewFile,BufRead *.jsx set filetype=javascript.jsx
autocmd BufNewFile,BufRead *.rb.tt,*.erb.tt set filetype=eruby
autocmd BufNewFile,BufRead Gemfile.* set filetype=ruby
autocmd BufNewFile,BufRead *.md,*.markdown setlocal filetype=markdown textwidth=80
autocmd BufNewFile,BufRead *.slim setlocal filetype=slim
autocmd FileType html,css,eruby EmmetInstall
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
autocmd FileType scss setlocal tabstop=2 shiftwidth=2 softtabstop=2
autocmd FileType yml setlocal filetype=yaml expandtab

" Autoremove trailing spaces when saving the buffer
autocmd FileType ruby,elm,yml,javscript,json,go,md,python,slim,css,scss,js autocmd BufWritePre <buffer> %s/\s\+$//e
" autocmd BufWritePre *.html Prettier

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


" ========= Plugins ========
if s:has_nvim
  call plug#begin('~/.config/nvim/plugged')
else
  call plug#begin('~/.vim/plugged')
endif

Plug '~/.config/nvim/local-plugins/color-schemes'
" Plug 'arthurxavierx/vim-caser'
Plug 'benmills/vimux', {'commit': '37f41195e6369ac602a08ec61364906600b771f1'}
Plug 'bling/vim-airline', {'commit': '4e2546a2098954b74cbc612f573826f13d6fb88e'}
Plug 'dense-analysis/ale', {'commit': 'bbe5153fcb36dec9860ced33ae8ff0b5d76ac02a'}
Plug 'dewyze/vim-endwise'
Plug 'dewyze/vim-ruby-block-helpers'
" Plug 'edkolev/tmuxline.vim', {'commit': '30012a964e8bd06e9b7612e2a838ef51a1993b0d'}
Plug 'ekalinin/Dockerfile.vim', {'commit': 'bf29af1c79df21aefd3f68660cc8c57a78f14021'}
Plug 'elixir-editors/vim-elixir', {'commit': '088cfc407460dea7b81c10b29db23843f85e7919'} | Plug 'slashmili/alchemist.vim', {'tag': '3.4.0'}
Plug 'elmcast/elm-vim', {'commit': 'ae5315396cd0f3958750f10a5f3ad9d34d33f40d'} " TODO: Update with elm-tooling
Plug 'gabrielelana/vim-markdown'
Plug 'gcmt/taboo.vim', {'commit': 'caf948187694d3f1374913d36f947b3f9fa1c22f'}
Plug 'henrik/vim-indexed-search', {'commit': '5af020bba084b699d0453f242d7d76711d64b1e3'}
Plug 'janko-m/vim-test', {'commit': 'e11fa044b312f87843313edbdfa0d7bb8db0d040'}
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'KeitaNakamura/neodark.vim'
Plug 'leafgarland/typescript-vim'
Plug 'mattn/emmet-vim', {'commit': 'c7643e5b616430f766528b225528a5228adb43df'} " TODO: Remember to use
Plug 'MaxMEllon/vim-jsx-pretty', { 'commit': '838cfce82df8cf99df5e3a200ad23f6c0f027550' }
" Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Plug 'mhinz/vim-mix-format', {'commit': '4c9256e28a34c3bba64f645293d05e9457d6927b'}
Plug 'pangloss/vim-javascript', {'commit': 'db595656304959dcc3805cf63ea9a430e3f01e8f'}
Plug 'preservim/nerdtree', {'commit': 'e67324fdea7a192c7ce1b4c6b3c3b9f82f11eee7'}
Plug 'prettier/vim-prettier', { 'do': 'yarn install', 'for': ['typescript', 'typescriptreact', 'javascript', 'json', 'css', 'scss', 'graphql', 'markdown', 'yaml', 'html', 'ruby'] }
Plug 'rhysd/vim-gfm-syntax', {'commit': 'c0ff9e4994d4e79c8d5edf963094518dceea2623'}
Plug 'slim-template/vim-slim', {'commit': '6673e404370e6f3d44be342cf03ea8c26ab02c66'}
Plug 'tomtom/tcomment_vim', {'commit': '20e85e8c2346bd1f60f1ef55c5e32bb54a7a22fc'}
Plug 'tpope/vim-abolish', {'commit': '7e4da6e78002344d499af9b6d8d5d6fcd7c92125'} " TODO: Check it out
Plug 'tpope/vim-fugitive', {'commit': '9a4d730270882f9d39a411eb126143eda4d46963'}
Plug 'tpope/vim-projectionist', {'commit': '17a8b2078a9ca1410d2080419e1cb9c9bb2e4492'}
Plug 'tpope/vim-ragtag', {'commit': '5d3ce9c1ae2232170a3f232c1e20fa832d15d440'}
Plug 'tpope/vim-rails', {'commit': '64befc6187678893082bebb8be79c1d17fdd07ba'} " TODO: Shortcuts for jumping to related model/controller, extraction
Plug 'tpope/vim-repeat', {'commit': 'c947ad2b6a16983724a0153bdf7f66d7a80a32ca'}
Plug 'tpope/vim-surround', {'commit': 'f51a26d3710629d031806305b6c8727189cd1935'}
Plug 'vim-airline/vim-airline-themes', {'commit': '9772475fcc24bee50c884aba20161465211520c8'}
Plug 'vim-ruby/vim-ruby', {'commit': 'fbf85d106a2c3979ed43d6332b8c26a72542754d'}
" Plug '~/dev/vim-ignore'
" Plug '~/dev/vim-ruby-block-helpers'
call plug#end()

" ========= Plugin Settings ========
" 'bling/vim-airline'
let g:airline_powerline_fonts = 1
let g:tmuxline_powerline_separators = 1
let g:airline#extensions#branch#vcs_checks = []

" 'benmills/vimux'
let g:VimuxUseNearestPane = 1
" let g:VimuxOrientation = "h"
" let g:VimuxHeight = "40"

" 'edkolev/tmuxline.vim'
let g:tmuxline_powerline_separators = 0

" 'prettier/vim-prettier'
nmap <Leader>pr <Plug>(Prettier)

let g:prettier#autoformat = 0
let g:prettier#config#prose_wrap = 'preserve'
let g:prettier#config#print_width = 100

" 'elmcast/elm-vim'
let g:elm_format_autosave = 1

" 'gcmt/taboo.vim'
function TabWithName(Func)
  call inputsave()
  let l:NewTabName = input("tab name: ")
  call inputrestore()
  execute a:Func . l:NewTabName . " "
endfunction

function NewTabWithName()
  call TabWithName("TabooOpen ")
endfunction
command! NewTabWithName :call NewTabWithName()

function RenameTab()
  call TabWithName("TabooRename ")
endfunction
command! RenameTab :call RenameTab()

function NewTabWithNoName()
  execute "TabooOpen " . "new_tab"
endfunction
command! NewTabWithNoName :call NewTabWithNoName()

function SetupTabs()
  execute "TabooRename controller "
  execute "TabooOpen action "
  execute "TabooOpen service "
  execute "TabooOpen repo "
  execute "TabooOpen view "
endfunction
map <silent> <C-T>s :call SetupTabs()<CR>

map <silent> <C-T>n :NewTabWithName<CR>
map <silent> <C-T>t :NewTabWithNoName<CR>
map <silent> <C-T>, :RenameTab<CR>
map <silent> <C-T>q :tabclose<CR>

let g:taboo_tab_format = "%N - %f"
let g:taboo_renamed_tab_format = "[%N%m] %l"

" 'janko-m/vim-test'
let test#strategy = "vimux"
function! ClearTransform(cmd) abort
  return 'clear; ' . a:cmd
endfunction
let g:test#custom_transformations = {'clear': function('ClearTransform')}
let g:test#transformation = 'clear'
let test#ruby#rspec#executable = 'bundle exec rspec'

function! TestContext()
  wall
  let [_, lnum, cnum, _] = getpos('.')
  RubyBlockSpecParentContext
  TestNearest
  call cursor(lnum, cnum)
endfunction

command! TestContext :call TestContext()

autocmd FileType ruby,erb nnoremap <silent> <LocalLeader>rc :TestContext<CR>
nnoremap <silent> <leader>rf :wa<CR>:TestNearest<CR>
nnoremap <silent> <leader>rb :wa<CR>:TestFile<CR>
nnoremap <silent> <leader>ra :wa<CR>:TestSuite<CR>
nnoremap <silent> <leader>rl :wa<CR>:TestLast<CR>

if filereadable(glob("dev.yml"))
  let test#ruby#rspec#executable = 'dev test'
  let test#ruby#minitest = 'dev test'
end

" 'junegunn/fzf'
let $FZF_DEFAULT_OPTS = '--reverse'
let g:fzf_layout = {'up': '~20%'}
let g:fzf_tags_command = 'ctags -R --exclude=".git" --exclude="node_modules" --exclude="vendor" --exclude="log" --exclude="tmp" --exclude="db" --exclude="pkg" --exclude="deps" --exclude="_build" --extra=+f .'
map <silent> <C-p> :Files<CR>
let $FZF_DEFAULT_COMMAND = 'find . -name "*" -type f 2>/dev/null
                            \ | grep -v -E "_site\/|tmp\/|.gitmodules|.git\/|deps\/|_build\/|node_modules\/|vendor\/|elm-stuff\/"
                            \ | sed "s|^\./||"'
function! SmartFuzzy()
  let root = split(system('git rev-parse --show-toplevel'), '\n')
  " let root = split(system('git rev-parse'), '\n')
  if len(root) == 0 || v:shell_error
    Files
  else
    GFiles -co --exclude-standard -- . ':!:vendor/*'
  endif
endfunction

command! -nargs=* SmartFuzzy :call SmartFuzzy()
map <silent> <leader>ff :SmartFuzzy<CR>
command! -bang -nargs=* GGrep
  \ call fzf#vim#grep(
  \   'git grep --line-number '.shellescape(<q-args>), 0,
  \   { 'dir': systemlist('git rev-parse --show-toplevel')[0] }, <bang>0)
let g:fzf_preview_window = ['right:50%', 'ctrl-/']
map <silent> <leader>gg :GGrep<CR>
map <silent> <leader>be :Buffers<CR>
map <silent> <leader>ft :Tags<CR>
let g:fzf_colors =
            \ { 'fg':      ['fg', 'Normal'],
            \ 'bg':      ['bg', 'Normal'],
            \ 'hl':      ['fg', 'Comment'],
            \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
            \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
            \ 'hl+':     ['fg', 'Statement'],
            \ 'info':    ['fg', 'PreProc'],
            \ 'border':  ['fg', 'Ignore'],
            \ 'prompt':  ['fg', 'Conditional'],
            \ 'pointer': ['fg', 'Exception'],
            \ 'marker':  ['fg', 'Keyword'],
            \ 'spinner': ['fg', 'Label'],
            \ 'header':  ['fg', 'Comment'] }

" 'mattn/emmet-vim'
let g:user_emmet_install_global = 0
let g:user_emmet_leader_key='<C-H>'


" 'mhinz/vim-mix-format'
" let g:mix_format_on_save = 1
" let g:mix_format_silent_errors = 1

" 'tpope/vim-projectionist'
let g:projectionist_heuristics = {
      \ "mix.exs": {
      \   "lib/*.ex": {"alternate": "test/{}_test.exs"},
      \   "test/*_test.exs": {"alternate": "lib/{}.ex"}
      \   }
      \ }

" 'tpope/vim-projectionist'
" # TODO: Add shorcuts/smart interpolation
" nnoremap <silent> <C-S>c :Econtroller<CR>
" nnoremap <silent> <C-S>m :Emodel<CR>
" nnoremap <silent> <C-S>v :Eview<CR>
" nnoremap <silent> <C-S>h :Ehelper<CR>
" nnoremap <silent> <C-S>i :Eintegrationtest<CR>
" nnoremap <silent> <C-S>s :A<CR>
" nnoremap <silent> <C-S>f :Efeature<CR>
" nnoremap <silent> <C-S>d :Eschema<CR>

" 'scrooloose/nerdtree'
let NERDTreeIgnore=['_site', 'tmp[[dir]]', '\.pyc', '\.class', "elm-stuff", "vendor[[dir]]"]
" let s:nerdtree_ignored_list = ['tmp', '\.pyc', '\.o', '\.class', '\.lo$',"elm-stuff","elm.js$","_site", "vendor" ]
" if filereadable(glob(".nerdtreeignore"))
"   let s:nt_ignore_lines = readfile('.nerdtreeignore')
"   for s:nt_line in s:nt_ignore_lines
"     let s:nerdtree_ignored_list = s:nerdtree_ignored_list + [s:nt_line]
"   endfor
" endif

" let NERDTreeIgnore = s:nerdtree_ignored_list
" let NERDTreeIgnore = ['test[[dir]]/bar[[dir]]']

" augroup vimignore_nerdtree
"     autocmd!
"     autocmd VimEnter * call NERDTreeAddPathFilter('MyFilter')
" augroup END
"
" function! MyFilter(params)
"   let pwd=expand('%:p:h')
"   let fullPath=join([''] + a:params['path']['pathSegments'], '/')
"
"     "params is a dict containing keys: 'nerdtree' and 'path' which are
"     "g:NERDTree and g:NERDTreePath objects
"
"     "return 1 to ignore params['path'] or 0 otherwise
" endfunction

map <silent> <LocalLeader>nt :NERDTreeToggle<CR>
map <silent> <LocalLeader>nr :NERDTree<CR>
map <silent> <LocalLeader>nf :NERDTreeFind<CR>

" 'slashmili/alchemist.vim'
" let g:alchemist#elixir_erlang_src = "~/dev/docs/sources/alchemist"

" 'tomtom/tcomment_vim'
map <silent> <LocalLeader>cc :TComment<CR>

" 'w0rp/ale'
let g:ale_linters_explicit = 1
let g:ale_fix_on_save = 1
let g:ale_sign_column_always = 1
let g:ale_lint_on_text_changed = 'never'
" let g:ale_completion_enabled = 1
let g:ale_elixir_elixir_ls_release = $HOME . '/dev/lsp/elixir-ls/rel'
let g:ale_ruby_rubocop_executable = 'bundle'
let g:airline#extensions#ale#enabled = 1
" let g:ale_sign_error = '>>'
" let g:ale_set_highlights = 0
" let g:airline#extensions#ale#enabled = 1
" let g:ale_fix_on_save = 1
" let ls_langs = 'elixir'
" execute 'autocmd Filetype ' . ls_langs . ' imap <C-X><C-O> <Plug>(ale_complete)'
" execute 'autocmd Filetype ' . ls_langs . ' nmap <C-]> <Plug>(ale_go_to_definition)'

" 'ruby': ['ruby'], FOR BELOW
" \ 'typescript': ['tsserver'],

let g:ale_linters = {
\ 'elixir': ['elixir-ls'],
\ 'javascript': ['eslint'],
\ 'typescript': ['eslint'],
\ 'typescriptreact': ['eslint'],
\ 'ruby': ['rubocop'],
\ }
let g:ale_fixers = {
\ '*': ['remove_trailing_lines', 'trim_whitespace'],
\ 'css': ['prettier'],
\ 'scss': ['prettier'],
\ 'javascript': ['prettier'],
\ 'typescript': ['prettier'],
\ 'typescriptreact': ['prettier'],
\ 'json': ['prettier'],
\ 'elixir': ['mix_format'],
\ 'html': ['prettier'],
\ }

" 'ruby': ['prettier'],

" ========= Color Schemes ========
colorscheme neodark
let g:neodark#background = '#1D1F21'
au FileType ruby,eruby colorscheme Tomorrow-Night
" au FileType diff colorscheme desert
" au FileType git colorscheme desert


" ========= Shortcuts ========

map <silent> <LocalLeader>nh :nohls<CR>
" imap </ </<C-X><C-O>
nmap <CR><CR> i<CR><esc>w
nmap <C-W>m <C-W>\| <C-W>_

nnoremap <LocalLeader>ad :ALEDetail<CR>
nnoremap <LocalLeader>p :set paste!<CR>

" ========= Terminal Shortcuts ========
nnoremap <LocalLeader>tty :terminal<CR>i
nnoremap <LocalLeader>tts :split<CR> :wincmd j<CR> :terminal<CR>i
nnoremap <LocalLeader>ttv :vsplit<CR> :wincmd l<CR> :terminal<CR>i
tnoremap <C-q> <C-\><C-n>:bd!<CR>
tnoremap qq <C-\><C-n>

" ========= Insert Shortcuts ========

autocmd FileType elixir,elm imap <buffer> <C-L> <SPACE>-><SPACE>
autocmd FileType ruby,eelixir,eruby,erb,javascript imap <buffer> <C-L> <SPACE>=><SPACE>
" imap <C-L> <SPACE>=><SPACE>
imap <C-X>l {%<SPACE><SPACE>%}<esc>hhi
imap <C-X>v {{<SPACE><SPACE>}}<esc>hhi

" ========= Functions ========

command! SudoW w !sudo tee %

function! GitGrepWord()
  cgetexpr system("git grep -n '" . expand("<cword>") . "'")
  cwin
  echo 'Number of matches: ' . len(getqflist())
endfunction
command! -nargs=0 GitGrepWord :call GitGrepWord()
nnoremap <silent> <Leader>gw :GitGrepWord<CR>

if s:has_nvim && filereadable(glob("~/.config/nvim/init.vim.local"))
  source ~/.config/nvim/init.vim.local
elseif !s:has_nvim && filereadable(glob("~/.vimrc.local"))
  source ~/.vimrc.local
endif

if s:has_nvim && filereadable(glob("~/.config/nvim/coc_config.vim"))
  source ~/.config/nvim/coc_config.vim
elseif !s:has_nvim && filereadable(glob("~/.vimrc.coc_config"))
  source ~/.vimrc.coc_config
endif

let g:airline_powerline_fonts = 1
let g:airline_theme='tomorrow'
" let g:lightline.colorscheme = 'neodark'
let g:tmuxline_powerline_separators = 1

" Cursorline coloring for bright environments
" autocmd BufEnter * highlight CursorLine ctermbg=Yellow ctermfg=Black cterm=bold
" autocmd BufLeave * highlight CursorLine ctermbg=Yellow ctermfg=None cterm=bold
