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
"set clipboard+=unnamed

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
command! Cd execute 'lcd %:h'

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
nnoremap <silent> <Leader>jh :<C-u>call <SID>HelplangToJa()<CR>

function! s:ToggleQuickfix() abort "quickfix window open
    let l:nr = winnr('$')
    cwindow
    let l:nr2 = winnr('$')
    if l:nr == l:nr2
        cclose
    endif
endfunction
nnoremap <silent> <Leader>f :<C-u>call <SID>ToggleQuickfix()<CR>

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
nnoremap <silent> <Leader>tm :<C-u>call <SID>MoveToNewTab()<CR>

if $HOME != $USERPROFILE && $GIT_EXEC_PATH != ''
    finish
end

"package
if !s:is_neovim && has('eval') && v:version > 800
    packadd! matchit
endif

"plugin
"vim-plug
if s:is_neovim
    call plug#begin(s:plug_dir)
    "manual
    Plug 'junegunn/vim-plug'
    Plug 'vim-jp/vimdoc-ja'
    "fzf
    Plug 'junegunn/fzf', { 'do': { -> fzf#install()  }  }
    Plug 'junegunn/fzf.vim'
    "vim-lsp, auto-completion
    Plug 'prabirshrestha/vim-lsp'
    Plug 'mattn/vim-lsp-settings'
    Plug 'prabirshrestha/asyncomplete.vim'
    Plug 'prabirshrestha/asyncomplete-lsp.vim'
    "NERD Tree
    Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
    "Terminal
    Plug 'kassio/neoterm'
    "Theme
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'cocopon/iceberg.vim'

    Plug 'lervag/vimtex'
    Plug 'plasticboy/vim-markdown'
    Plug 'kana/vim-submode'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-repeat'
    Plug 'jiangmiao/auto-pairs'
    call plug#end()

    let s:plug = { "plugs": get(g:, 'plugs', {}) }
    function! s:plug.is_installed(name) abort
        return has_key(self.plugs, a:name) ? isdirectory(self.plugs[a:name].dir) : 0
    endfunction

    "fzf
    if s:plug.is_installed("fzf.vim")
        if executable('Ag')
            command! -bang -nargs=* Ag
                        \ call fzf#vim#ag(<q-args>,
                        \         <bang>0 ? fzf#vim#with_preview('up:60%')
                        \                 : fzf#vim#with_preview('right:50%:hidden', '?'),
                        \         <bang>0)
        endif
    endif

    "vim-lsp
    if s:plug.is_installed("vim-lsp")
        nnoremap <silent> <Leader>d :<C-u>LspDefinition<CR>
        nnoremap <silent> <Leader>rn :<C-u>LspRename<CR>
        nnoremap <silent> <Leader>td :<C-u>LspTypeDefinition<CR>
        nnoremap <silent> <Leader>rf :<C-u>LspReferences<CR>
        let g:lsp_diagnostics_enabled = 1
        let g:lsp_diagnostics_echo_cursor = 1
        let g:asyncomplete_popup_delay = 200
    endif

    "asyncomplete.vim
    if s:plug.is_installed("asyncomplete")
        inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
        inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
        inoremap <expr> <cr>    pumvisible() ? "\<C-y>" : "\<cr>"
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
        let g:airline_powerline_fonts = 1
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

"vim-plug don't install
else
    "statusline for vim
    set statusline=%<%f%m%r%h%w
    set statusline+=%=
    set statusline+=\|\ %{&fileencoding},%{&fileformat}
    set statusline+=\ \|\ %Y
    set statusline+=\ \|\ %l/%L,%c\ \|
endif
