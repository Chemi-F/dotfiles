if !1 | finish | endif

"encoding
set encoding=utf-8
scriptencoding utf-8

if &compatible
  set nocompatible
endif

"autocmdreset
augroup myvimrc
  autocmd!
augroup END


"bell
set vb t_vb=
set noerrorbells

"options
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
set title
set titlestring=Vim:\ %f\ %h%r%m
set viminfo='50,<500,s100,h
set list
set listchars=tab:^-
set formatoptions-=ro
set nobackup
set directory=~/.vim/swap
set tags=./tags;
set clipboard=unnamed
set cursorline

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

"autocmd
autocmd myvimrc QuickFixCmdPost *grep*,make cwindow
autocmd myvimrc FileType help,qf, nnoremap <silent> <buffer> q :<C-u>q<CR>
autocmd myvimrc ColorScheme * highlight clear Cursorline 

"key-mapping
"leader
let mapleader = "\<Space>"
"normal mode
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
noremap <silent> <C-n> :<C-u>cnext<CR>
noremap <silent> <C-p> :<C-u>cprevious<CR>
"insert mode
inoremap jj <Esc>
inoremap <C-c> <Esc>
"command mode
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
cnoremap <C-f> <Right>
cnoremap <C-b> <Left>
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-d> <Del>

"package
if has('syntax') && has('eval') && v:version >= 800
  packadd! matchit
endif

"plugin
"vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd myvimrc VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'junegunn/vim-plug'
if has('timers') && has('python3')
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
  Plug 'Shougo/neosnippet' | Plug 'Shougo/neosnippet-snippets'
endif
Plug 'vim-jp/vimdoc-ja'
Plug 'lervag/vimtex'
Plug 'plasticboy/vim-markdown'
Plug 'kana/vim-submode'
Plug 'tpope/vim-repeat'
Plug 'sjl/badwolf'
call plug#end()

let s:plug = {
      \"plugs": get(g:, 'plugs', {})
      \ }
function! s:plug.is_installed(name)
  return has_key(self.plugs, a:name) ? isdirectory(self.plugs[a:name].dir) : 0
endfunction

"deoplete

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
  let g:deoplete#enable_at_startup = 1
  call deoplete#custom#var('omni', 'input_patterns', {
        \ 'tex': g:vimtex#re#deoplete
        \})
endif

"vim-submode
call submode#enter_with('winsize', 'n', '', '<C-w>>', '<C-w>>')
call submode#enter_with('winsize', 'n', '', '<C-w><', '<C-w><')
call submode#enter_with('winsize', 'n', '', '<C-w>+', '<C-w>+')
call submode#enter_with('winsize', 'n', '', '<C-w>-', '<C-w>-')
call submode#map('winsize', 'n', '', '>', '<C-w>>')
call submode#map('winsize', 'n', '', '<', '<C-w><')
call submode#map('winsize', 'n', '', '+', '<C-w>+')
call submode#map('winsize', 'n', '', '-', '<C-w>-')

"colorsheme
set t_Co=256
colorscheme badwolf
set background=dark
