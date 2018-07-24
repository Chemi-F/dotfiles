set encoding=utf-8

scriptencoding utf-8

"ベル
set vb t_vb=
set noerrorbells

set hidden
set scrolloff=3
set wildmenu
set backspace=indent,eol,start
set number
set title
set cmdheight=2
set ruler
set showmatch
set matchtime=1
set showcmd
set display=lastline
set cursorline
set keywordprg=:help
set helplang=en,ja

"ステータスライン
set laststatus=2
set statusline=%<%f%m%r%h%w[%{strlen(&fenc)?&fenc:'none'}/%{&ff}/%Y]
set statusline+=%=%l\ of\ %L\ [%p%%]\ -\ col:\ %c%V

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
"ノーマルモード
nnoremap <silent> <Esc><Esc> :nohlsearch<CR>
nnoremap <Space>w :<C-u>w<CR>
nnoremap <Space>q :<C-u>q<CR>
nnoremap <Space>wq :<C-u>wq<CR>
nnoremap gs :<C-u>s///g<Left><Left><Left>
nnoremap g%s :<C-u>%s///g<Left><Left><Left>
nnoremap <silent> <Space>o  :<C-u>for i in range(v:count1) \| call append(line('.'), '') \| endfor<CR>
nnoremap <silent> <Space>O  :<C-u>for i in range(v:count1) \| call append(line('.')-1, '') \| endfor<CR>
nnoremap <Space>t :<C-u>tab help<Space>
nnoremap <Space>s. :<C-u>source $HOME/.vimrc<CR>
nnoremap <Space>. :<C-u>tabedit $HOME/.vimrc<CR>
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap : ;
nnoremap ; :
nnoremap Y y$
noremap <Space>h ^
noremap <Space>l $
noremap j gj
noremap k gk
noremap gj j
noremap gk k
"インサートモード
inoremap <silent> <Esc> <Esc>:set iminsert=0<CR>
"コマンドモード
cnoremap <C-f> <Right>
cnoremap <C-b> <Left>
"その他
nnoremap <silent> tm :<C-u>call <SID>MoveToNewTab()<CR>
function! s:MoveToNewTab()
  tab split
  tabprevious
  if winnr('$') > 1
    close
  elseif bufnr('$') > 1
    buffer #
  endif
  tabnext
endfunction

"プラグイン
call plug#begin('~/.vim/plugged')

Plug 'vim-jp/vimdoc-ja'
Plug 'w0ng/vim-hybrid'
Plug 'lervag/vimtex'

call plug#end()

"vimtex
let g:vimtex_compiler_latexmk_engines = { '_' : '-pdfdvi' }

"見た目系
colorscheme hybrid
set background=dark
set t_Co=256
syntax on
