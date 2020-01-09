if !1 | finish | endif

"encoding
set encoding=utf-8
scriptencoding utf-8

if &compatible
    set nocompatible
endif

"autocmd reset
augroup myvimrc
    autocmd!
augroup END

let s:is_neovim = has('nvim')
let s:is_windows = has('win32')

if s:is_windows
    set shellslash
    let s:vimfiles_dir = expand('~/vimfiles')
else
    if s:is_neovim
        let s:vimfiles_dir = expand('~/.local/share/nvim')
    else
        let s:vimfiles_dir = expand('~/.vim')
    endif
endif

let s:plug_dir = s:vimfiles_dir . '/plugged'
let s:swap_dir = s:vimfiles_dir . '/swap'

function! s:make_dir(dir) abort
    if !isdirectory(a:dir)
        call mkdir(a:dir, 'p')
    endif
endfunction
call s:make_dir(s:swap_dir)

if s:is_windows
endif

"options
"moving around, searching and patterns
set wrapscan
set incsearch
set ignorecase
set smartcase

"tags
set tags+=tags;

"displaying text
set scrolloff=5
if v:version > 800
    set breakindent
endif
set showbreak=>\
set display=lastline
set cmdheight=2
set list
set listchars=tab:^-
set number

"syntax, highlighting and spelling
set hlsearch
set cursorline

"multiple windows
set hidden

"terminal
set title
if s:is_neovim
    set titlestring=NeoVim:\ %f\ %h%r%m
else
    set titlestring=Vim:\ %f\ %h%r%m
endif

"messages and info
set showcmd
set noerrorbells
set visualbell t_vb=
set helplang=en,ja

"selecting text
set clipboard+=unnamed

"editing text
set backspace=indent,eol,start
set formatoptions-=ro
set pumheight=10
set showmatch
set matchtime=1

"tabs and indenting
set tabstop=4
set shiftwidth=4
set expandtab
set autoindent
set smartindent

"reading and writing files
set nobackup

"the swap file
execute 'set directory=' . s:swap_dir
set swapfile

"command line editing
set wildmenu

"various
set viminfo='50,<500,s100,h

"autocmd
autocmd myvimrc QuickFixCmdPost *grep*,make cwindow
autocmd myvimrc ColorScheme * highlight clear Cursorline
autocmd myvimrc InsertLeave * set nopaste
autocmd myvimrc FileType help,qf nnoremap <silent> <buffer> q :<C-u>q<CR>
autocmd myvimrc FileType help set keywordprg=:help
autocmd myvimrc FileType qf call s:FtQuickfix()
if has('nvim')
    autocmd myvimrc WinEnter * if &buftype ==# 'terminal' | startinsert | endif
else
    autocmd myvimrc WinEnter * if &buftype ==# 'terminal' | normal i | endif
endif

function! s:FtQuickfix() abort
  setlocal statusline=%t%{exists('w:quickfix_title')?\ '\ '.w:quickfix_title\ :\ ''}\ %=%l/%L
  setlocal nowrap
endfunction

"command
command! -nargs=1 VimGrepF execute 'vimgrep /<args>/j %'

"function! s:VimHelpVertical2Lang
"endfunction

"key-mapping
let g:mapleader = "\<Space>"
"normal
nnoremap <Leader>w :<C-u>w<CR>
nnoremap <Leader>q :<C-u>q<CR>
nnoremap <Leader>wq :<C-u>wq<CR>
nnoremap <Leader>gs :<C-u>s///g<Left><Left><Left>
nnoremap <Leader>gps :<C-u>%s///g<Left><Left><Left>
nnoremap <Leader>s. :<C-u>source $MYVIMRC<CR>
nnoremap <Leader>r :<C-u>registers<CR>
nnoremap <silent><Leader>. :<C-u>e $MYVIMRC<CR>
nnoremap <silent> <Leader>o :<C-u>for i in range(1, v:count1) \| call append(line('.'),   '') \| endfor \| silent! call repeat#set("<Leader>o", v:count1)<CR>
nnoremap <silent> <Leader>O :<C-u>for i in range(1, v:count1) \| call append(line('.')-1, '') \| endfor \| silent! call repeat#set("<Leader>o", v:count1)<CR>
nnoremap <silent> <Leader><C-l> <C-l>
nnoremap <silent> <Leader>jh :<C-u>call <SID>HelplangToJa()<CR>
nnoremap <silent> <Leader>tm :<C-u>call <SID>MoveToNewTab()<CR>
nnoremap <silent> <Leader>f :<C-u>call <SID>ToggleQuickfix()<CR>
nnoremap <silent> <Esc><Esc> :<C-u>nohlsearch<CR>
nnoremap <silent> <C-n> :<C-u>cnext<CR>
nnoremap <silent> <C-p> :<C-u>cprevious<CR>
nnoremap <silent> <C-c> :<C-u>cclose<CR>
nnoremap <silent> <Down> <C-w>-
nnoremap <silent> <Up> <C-w>+
nnoremap <silent> <Left> <C-w><
nnoremap <silent> <Right> <C-w>>
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap Y y$
noremap <Leader>h ^
noremap <Leader>l $
noremap j gj
noremap k gk
noremap gj j
noremap gk k
noremap : ;
noremap ; :
noremap x "_x
noremap X "_X
noremap * *N
"insert
inoremap jj <Esc>
inoremap ｊｊ <Esc>
inoremap <C-c> <Esc>
inoremap <C-@> <C-[>
"command
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
cnoremap <C-f> <Right>
cnoremap <C-b> <Left>
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-d> <Del>
"terimnal
tnoremap <A-w> <C-\><C-n><C-w>w
tnoremap <A-j> <C-\><C-n>
"function for map
let s:helplang_is_ja = 0
function! s:HelplangToJa() abort "To use K in Japanese
    if s:helplang_is_ja
        set helplang=en,ja
        let s:helplang_is_ja = 0
        echo "Help language is English"
    else
        set helplang=ja,en
        let s:helplang_is_ja = 1
        echo "Help language is Japanese"
    endif
endfunction

function! s:ToggleQuickfix() abort "quickfix window open
    let l:nr = winnr('$')
    cwindow
    let l:nr2 = winnr('$')
    if l:nr == l:nr2
        cclose
    endif
endfunction

function! s:MoveToNewTab() abort
    tab split
    tabprevious
    if winnr('$') > 1
        close
    elseif bufnr('$') > 1
        buffer #
    endif
    tabnext
endfunction

"package
if !s:is_neovim && has('eval') && v:version > 800
    packadd! matchit
endif

"plugin
"vim-plug
call plug#begin(s:plug_dir)
Plug 'junegunn/vim-plug'
Plug 'vim-jp/vimdoc-ja'
if has('timers') && has('python3')
    if s:is_neovim
        Plug 'neoclide/coc.nvim', { 'branch': 'release' }
    endif
endif
Plug 'dense-analysis/ale'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'kassio/neoterm'
Plug 'lervag/vimtex'
Plug 'plasticboy/vim-markdown'
Plug 'kana/vim-submode'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'jiangmiao/auto-pairs'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
"Plug 'Yggdroot/indentline'
Plug 'cocopon/iceberg.vim'
call plug#end()

let s:plug = { "plugs": get(g:, 'plugs', {}) }
function! s:plug.is_installed(name) abort
    return has_key(self.plugs, a:name) ? isdirectory(self.plugs[a:name].dir) : 0
endfunction

"coc.nvim
if s:plug.is_installed("coc.nvim")
    autocmd FileType json syntax match Comment +\/\/.\+$+
    function! s:check_back_space() abort
        let col = col('.') - 1
        return !col || getline('.')[col - 1]  =~ '\s'
    endfunction
    inoremap <silent><expr> <TAB>
                \ pumvisible() ? "\<C-n>" :
                \ <SID>check_back_space() ? "\<TAB>" :
                \ coc#refresh()
    nmap <silent> gd <Plug>(coc-definition)
    nmap <silent> gy <Plug>(coc-type-definition)
    nmap <silent> gi <Plug>(coc-implementation)
    nmap <silent> gr <Plug>(coc-references)
    nmap <leader>cr <Plug>(coc-rename)
    nmap <leader>cf  <Plug>(coc-fix-current)
endif

"NERDTree
if s:plug.is_installed("nerdtree")
    nnoremap <Leader>n :<C-u>NERDTreeToggle<CR>
endif

"neoterm
if s:plug.is_installed("neoterm")
    let g:neoterm_default_mod='belowright'
    let g:neoterm_size=10
    nnoremap <silent> <Leader>to :<C-u>Ttoggle<CR>
    tnoremap <A-t> <C-\><C-n>:Ttoggle<CR>
endif

"ale
if s:plug.is_installed("ale")
    let g:ale_sign_column_always = 1
endif

"vimtex
let g:tex_flavor = 'latax'
let g:vimtex_quickfix_open_on_warning = 0
let g:vimtex_compiler_latexmk_engines = { '_' : '-pdfdvi' }
let g:vimtex_compiler_progname = 'nvr'

"vim-submode
if s:plug.is_installed("vim-submode")
    call submode#enter_with('winsize', 'n', '', '<C-w>>', '<C-w>>')
    call submode#enter_with('winsize', 'n', '', '<C-w><', '<C-w><')
    call submode#enter_with('winsize', 'n', '', '<C-w>+', '<C-w>+')
    call submode#enter_with('winsize', 'n', '', '<C-w>-', '<C-w>-')
    call submode#map('winsize', 'n', '', '>', '<C-w>>')
    call submode#map('winsize', 'n', '', '<', '<C-w><')
    call submode#map('winsize', 'n', '', '+', '<C-w>+')
    call submode#map('winsize', 'n', '', '-', '<C-w>-')
endif

"vim-airline
set laststatus=2
if s:plug.is_installed("vim-airline")
    let g:airline_section_y = '%{&fileencoding},%{&fileformat}'
    let g:airline_section_z = '%l/%L,%c'
    "let g:airline#extensions#whitespace#enabled = 0
    let g:airline_theme='distinguished'
else
    set statusline=%<%f%m%r%h%w
    set statusline+=%=
    set statusline+=\|\ %{&fileencoding},%{&fileformat}
    set statusline+=\ \|\ %Y
    set statusline+=\ \|\ %l/%L,%c\ \|
endif

"colorsheme
set termguicolors
set t_Co=256
colorscheme iceberg
