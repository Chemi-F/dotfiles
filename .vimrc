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
set breakindent
set showbreak=>\
set display=lastline
set cmdheight=2
set list
set listchars=tab:^-
set number

"syntax, highlighting and spelling
set hlsearch
nohlsearch
set cursorline

"multiple windows
set laststatus=2
set statusline=%<%f%m%r%h%w
set statusline+=%=
set statusline+=\|\ %{&fileencoding},%{&fileformat}
set statusline+=\ \|\ %Y
set statusline+=\ \|\ %l/%L,%c
set hidden

"terminal
set title
if has('nvim')
    set titlestring=NeoVim:\ %f\ %h%r%m
else
    set titlestring=Vim:\ %f\ %h%r%m
endif

"messages and info
set showcmd
set noerrorbells
set visualbell t_vb=
set helplang=ja,en

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
set directory=~/.vim/swap

"command line editing
set wildmenu

"executing external commands
set keywordprg=:help

"various
set viminfo='50,<500,s100,h

"autocmd
autocmd myvimrc QuickFixCmdPost *grep*,make cwindow
autocmd myvimrc FileType help,qf nnoremap <silent> <buffer> q :<C-u>q<CR>
autocmd myvimrc ColorScheme * highlight clear Cursorline 

"キーマッピング
let g:mapleader = "\<Space>"
"ノーマルモード
nnoremap <silent> <Esc><Esc> :<C-u>nohlsearch<CR>
nnoremap <Leader>w :<C-u>w<CR>
nnoremap <Leader>q :<C-u>q<CR>
nnoremap <Leader>wq :<C-u>wq<CR>
nnoremap <Leader>th :<C-u>tab help<Space>
nnoremap <Leader>gs :<C-u>s///g<Left><Left><Left>
nnoremap <Leader>gps :<C-u>%s///g<Left><Left><Left>
nnoremap <Leader>s. :<C-u>source $MYVIMRC<CR>
nnoremap <Leader>. :<C-u>tabedit $MYVIMRC<CR>
nnoremap <silent> <Leader>o :<C-u>for i in range(1, v:count1) \| call append(line('.'),   '') \| endfor \| silent! call repeat#set("<Leader>o", v:count1)<CR>
nnoremap <silent> <Leader>O :<C-u>for i in range(1, v:count1) \| call append(line('.')-1, '') \| endfor \| silent! call repeat#set("<Leader>o", v:count1)<CR>
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <silent> <Leader><C-l> <C-l>
nnoremap Y y$
nnoremap <silent> <Down> <C-w>-
nnoremap <silent> <Up> <C-w>+
nnoremap <silent> <Left> <C-w><
nnoremap <silent> <Right> <C-w>>
nnoremap <silent> <C-n> :<C-u>cnext<CR>
nnoremap <silent> <C-p> :<C-u>cprevious<CR>
nnoremap <silent> <C-c> :<C-u>cclose<CR>
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
"インサートモード
inoremap jj <Esc>
inoremap <C-c> <Esc>
"コマンドモード
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
cnoremap <C-f> <Right>
cnoremap <C-b> <Left>
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-d> <Del>

"package
if !has('nvim') && has('eval')
    packadd! matchit
endif

"plugin
"vim-plug
if has('nvim')
    call plug#begin('~/.local/share/nvim/plugged')
else
    call plug#begin('~/.vim/plugged')
endif
Plug 'junegunn/vim-plug'
if has('timers') && has('python3')
    if has('nvim')
        Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
    else
        Plug 'Shougo/deoplete.nvim'
        Plug 'roxma/nvim-yarp'
        Plug 'roxma/vim-hug-neovim-rpc'
    endif
    Plug 'Shougo/neosnippet' | Plug 'Shougo/neosnippet-snippets'
endif
Plug 'vim-jp/vimdoc-ja'
Plug 'lervag/vimtex', { 'for': 'tex'}
Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }
Plug 'kana/vim-submode'
Plug 'tpope/vim-repeat'
Plug 'cocopon/iceberg.vim'
call plug#end()

let s:plug = {
            \"plugs": get(g:, 'plugs', {})
            \ }
function! s:plug.is_installed(name)
    return has_key(self.plugs, a:name) ? isdirectory(self.plugs[a:name].dir) : 0
endfunction

"deoplete
let g:deoplete#enable_at_startup = 1

"neosnippet
if s:plug.is_installed("neosnippet")
    imap <C-k> <Plug>(neosnippet_expand_or_jump)
    smap <C-k> <Plug>(neosnippet_expand_or_jump)
    xmap <C-k> <Plug>(neosnippet_expand_target)
    smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
                \ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
endif

"vimtex
let g:tex_flavor = 'latax'
let g:vimtex_compiler_latexmk_engines = { '_' : '-pdfdvi' }
if s:plug.is_installed("deoplete.nvim")
    call deoplete#custom#var('omni', 'input_patterns', {
                \ 'tex': g:vimtex#re#deoplete
                \})
endif

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

"colorsheme
set t_Co=256
colorscheme iceberg
