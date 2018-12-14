"encoding
set encoding=utf-8
scriptencoding utf-8

"bell
set vb t_vb=
set noerrorbells

set hidden
set scrolloff=3
set wildmenu
set backspace=indent,eol,start
set cmdheight=2
set keywordprg=:help
set helplang=en,ja
set showcmd
set ruler
set title
set number
set showmatch
set matchtime=1
set display=lastline
set cursorline
set title
set titlestring=Vim:\ %f\ %h%r%m

"status line
set laststatus=2
set statusline=%<%f%m%r%h%w
set statusline+=%=[%{strlen(&fenc)?&fenc:'none'}/%{&ff}/%Y][%p%%][%l:%c]

"tab indent
set expandtab
set tabstop=2
set shiftwidth=2
set autoindent
set smartindent

"search
set wrapscan
set hlsearch
set incsearch
set ignorecase
set smartcase

"key-mapping
"leader
noremap s <Nop>
let mapleader = "\<Space>"
let maplocalleader = "s"
"normal mode
nnoremap <silent> <Esc><Esc> :nohlsearch<CR>
nnoremap <Leader>w :<C-u>w<CR>
nnoremap <Leader>q :<C-u>q<CR>
nnoremap <Leader>wq :<C-u>wq<CR>
nnoremap <Leader>th :<C-u>tab help<Space>
nnoremap <Leader>gs :<C-u>s///g<Left><Left><Left>
nnoremap <Leader>gps :<C-u>%s///g<Left><Left><Left>
nnoremap <Leader>s. :<C-u>source $HOME/.config/nvim/init.vim<CR>
nnoremap <Leader>. :<C-u>tabedit $HOME/.config/nvim/init.vim<CR>
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
"insert mode
inoremap <silent> <Esc> <Esc>:set iminsert=0<CR>
inoremap jj <Esc>
"command mode
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
cnoremap <C-f> <Right>
cnoremap <C-b> <Left>
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-d> <Del>

"plugin
call plug#begin()

Plug 'vim-jp/vimdoc-ja'
Plug 'sjl/badwolf'
Plug 'lervag/vimtex'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'

call plug#end()

"deoplete
let g:deoplete#enable_at_startup = 1

"vimtex
let g:vimtex_compiler_latexmk_engines = { '_' : '-pdfdvi' }

"neosnippet
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
"imap <expr><TAB>
" \ pumvisible() ? "\<C-n>" :
" \ neosnippet#expandable_or_jumpable() ?
" \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

colorscheme badwolf
set background=dark
