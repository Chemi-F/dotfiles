"エンコーディング
set encoding=utf-8
scriptencoding utf-8

"ベル
set vb t_vb=
set noerrorbells

set hidden
set scrolloff=3
set wildmenu
set backspace=indent,eol,start
set cmdheight=2
set keywordprg=:help
set helplang=en,ja

"表示
set showcmd
set ruler
set title
set number
set showmatch
set matchtime=1
set display=lastline
set cursorline

"ステータスライン
set laststatus=2
set statusline=%<%f%m%r%h%w
set statusline+=%=[%{strlen(&fenc)?&fenc:'none'}/%{&ff}/%Y][%p%%][%l:%c]

"タブとインデント
set expandtab
set tabstop=2
set shiftwidth=2
set autoindent
set smartindent

"検索
set wrapscan
set hlsearch
set incsearch
set ignorecase
set smartcase

"キーマッピング
"リーダー
noremap s <Nop>
let mapleader = "\<Space>"
let maplocalleader = "s"
"ノーマルモード
nnoremap <silent> <Esc><Esc> :nohlsearch<CR>
nnoremap <Leader>w :<C-u>w<CR>
nnoremap <Leader>q :<C-u>q<CR>
nnoremap <Leader>wq :<C-u>wq<CR>
nnoremap <Leader>th :<C-u>tab help<Space>
nnoremap <Leader>gs :<C-u>s///g<Left><Left><Left>
nnoremap <Leader>gps :<C-u>%s///g<Left><Left><Left>
nnoremap <Leader>s. :<C-u>source $HOME/.vimrc<CR>
nnoremap <Leader>. :<C-u>tabedit $HOME/.vimrc<CR>
nnoremap <silent> <Leader>o  :<C-u>for i in range(v:count1) \| call append(line('.'), '') \| endfor<CR>
nnoremap <silent> <Leader>O  :<C-u>for i in range(v:count1) \| call append(line('.')-1, '') \| endfor<CR>
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap : ;
nnoremap ; :
nnoremap Y y$
noremap <Leader>h ^
noremap <Leader>l $
noremap j gj
noremap k gk
noremap gj j
noremap gk k
noremap x "_x
noremap X "_X
noremap * *N
"インサートモード
inoremap <silent> <Esc> <Esc>:set iminsert=0<CR>
"コマンドモード
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
cnoremap <C-f> <Right>
cnoremap <C-b> <Left>
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-d> <Del>

"package
if v:version >= 800
  packadd matchit
else
  runtime macros/matchit.vim
endif

"plugin
call plug#begin('~/.vim/plugged')

Plug 'vim-jp/vimdoc-ja'
Plug 'sjl/badwolf'
Plug 'lervag/vimtex'

call plug#end()

"vimtex
let g:vimtex_compiler_latexmk_engines = { '_' : '-pdfdvi' }

"見た目系
set t_Co=256
colorscheme badwolf
set background=dark
