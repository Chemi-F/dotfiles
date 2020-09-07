if !1 | finish | endif

"encoding
set fileencodings=utf-8,sjis
set encoding=utf-8

scriptencoding utf-8

if &compatible
    set nocompatible
endif

"version settings
let s:is_neovim = has('nvim')
let s:is_windows = has('win32') || has('win64')

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

if exists('s:vimfiles_dir')
    let s:plug_dir = s:vimfiles_dir . '/plugged'
    let s:swap_dir = s:vimfiles_dir . '/swap'

    function! s:make_dir(dir) abort
        if !isdirectory(a:dir)
            call mkdir(a:dir, 'p')
        endif
    endfunction
    call s:make_dir(s:swap_dir)

    "swap file
    execute 'set directory=' . s:swap_dir
    set swapfile
endif

"options (:options)
"2 moving around, searching and patterns
set wrapscan
set incsearch
set ignorecase
set smartcase
"3 tags
set tags+=tags;
"4 displaying text
set scrolloff=5
if v:version >= 800
    set breakindent
endif
set showbreak=>\
set display=lastline
set cmdheight=2
set list
set listchars=tab:^-
set number
"5 syntax, highlighting and spelling
set hlsearch
set cursorline
"6 multiple windows
set laststatus=2
set statusline=%<%f%m%r%h%w
set statusline+=%=
set statusline+=\|\ %{&fileencoding},%{&fileformat}
set statusline+=\ \|\ %Y
set statusline+=\ \|\ %l/%L,%c\ \|
set hidden
"8 terminal
set title
if s:is_neovim
    set titlestring=NeoVim:\ %f\ %h%r%m
else
    set titlestring=Vim:\ %f\ %h%r%m
endif
"11 messages and info
set showcmd
set noerrorbells
set visualbell t_vb=
set belloff=all
set helplang=en,ja
"12 selecting text
"set clipboard+=unnamed
"13 editing text
set backspace=indent,eol,start
set formatoptions-=ro
set pumheight=10
set showmatch
set matchtime=1
"14 tabs and indenting
set tabstop=4
set shiftwidth=4
set expandtab
set autoindent
set smartindent
"18 reading and writing files
set nobackup
"20 command line editing
set wildmenu
"21 executing external commands
if !s:is_windows
    set shell=/bin/bash
endif
"25 various
set viminfo='50,<500,s100,h

"key-mapping
let g:mapleader = "\<Space>"
nnoremap <Space> <Nop>
"normal
"Leader mapping
nnoremap <Leader>w :<C-u>write<CR>
nnoremap <Leader>q :<C-u>quit<CR>
nnoremap <Leader>wq :<C-u>wq<CR>
nnoremap <Leader>gs :<C-u>s///g<Left><Left><Left>
nnoremap <Leader>gps :<C-u>%s///g<Left><Left><Left>
nnoremap <Leader>s. :<C-u>source $MYVIMRC<CR>
"nnoremap <Leader>r :<C-u>registers<CR>
nnoremap <silent><Leader>. :<C-u>e $MYVIMRC<CR>
"insert line break
nnoremap <silent> <Leader>o :<C-u>for i in range(1, v:count1) \| call append(line('.'),   '') \| endfor \| silent! call repeat#set("<Leader>o", v:count1)<CR>
nnoremap <silent> <Leader>O :<C-u>for i in range(1, v:count1) \| call append(line('.')-1, '') \| endfor \| silent! call repeat#set("<Leader>o", v:count1)<CR>
nnoremap <silent> <Leader><C-l> <C-l>
if !s:is_neovim
    nnoremap <silent> <Leader>to :<C-u>botright terminal ++rows=5<CR><C-\><C-n><C-w>w
endif
"others
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
nnoremap <Tab>h <C-w>H
nnoremap <Tab>j <C-w>J
nnoremap <Tab>k <C-w>K
nnoremap <Tab>l <C-w>L
nnoremap Y y$
"normal, visual
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
inoremap <C-c> <Esc>
inoremap <C-@> <C-[>
"terimnal
tnoremap <A-w> <C-\><C-n><C-w>w
tnoremap jj <C-\><C-n>

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

"autocmd
augroup myvimrc
    autocmd!
    autocmd ColorScheme * highlight clear Cursorline
    autocmd InsertLeave * set nopaste
    "help autocmd
    autocmd FileType help,qf nnoremap <silent> <buffer> q :<C-u>q<CR>
    autocmd FileType help,vim setlocal keywordprg=:help

    "quickfix autocmd
    autocmd QuickFixCmdPost *grep*,make cwindow
    autocmd FileType qf call s:quickfix_settings()

    "terminal-mode autocmd
    autocmd BufEnter * if (winnr("$") == 1 && &buftype ==# 'terminal') | q! | endif
    if !s:is_neovim
        autocmd TerminalOpen * if &buftype ==# 'terminal' | call s:terminalmode_settings() | endif
    endif
augroup END

"function for autocmd
function! s:quickfix_settings() abort
    setlocal statusline=%t%{exists('w:quickfix_title')?\ '\ '.w:quickfix_title\ :\ ''}\ %=%l/%L
    setlocal nowrap
endfunction

function! s:terminalmode_settings() abort
    setlocal bufhidden=wipe
    nnoremap <silent> <buffer> q :<C-u>quit!<CR>
endfunction

"command
command! -nargs=1 VimGrepF execute 'vimgrep /<args>/j %'
command! Cd execute 'lcd %:h'

"finish when use git commit
if $HOME != $USERPROFILE && $GIT_EXEC_PATH != ''
    finish
end

"package
if !s:is_neovim && has('eval') && v:version >= 800
    packadd! matchit
endif

"plugin
"vim-plug
if empty(globpath(&rtp, 'autoload/plug.vim'))
    "finish when vim-plug isn't installed
    colorscheme ron
    finish
endif

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
    "Git
    Plug 'tpope/vim-fugitive'
    "Filer
    Plug 'preservim/nerdtree'
    Plug 'cocopon/vaffle.vim'
    "Terminal
    if s:is_neovim
        Plug 'kassio/neoterm'
    endif
    "Theme
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'cocopon/iceberg.vim'

    Plug 'lervag/vimtex'
    Plug 'kana/vim-submode'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-repeat'
    Plug 'jiangmiao/auto-pairs' "<M-p> Toggle
call plug#end()

let s:plug = { "plugs": get(g:, 'plugs', {}) }
function! s:plug.is_installed(name) abort
    return has_key(self.plugs, a:name) ? isdirectory(self.plugs[a:name].dir) : 0
endfunction

"fzf.vim
if s:plug.is_installed("fzf.vim")
    augroup fzf
        au!
        autocmd FileType fzf set laststatus=0 noshowmode noruler
                    \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
    augroup END

    "push '?' to preview
    command! -bang -nargs=* Rg
                \ call fzf#vim#grep(
                \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
                \   <bang>0 ? fzf#vim#with_preview('up:60%')
                \           : fzf#vim#with_preview('right:50%:hidden', '?'),
                \   <bang>0)
endif

"vim-lsp
if s:plug.is_installed("vim-lsp")
    function! s:on_lsp_buffer_enabled() abort
        setlocal omnifunc=lsp#complete
        setlocal signcolumn=yes
        nmap <buffer> gd <plug>(lsp-definition)
        nmap <buffer> <Leader>rn <plug>(lsp-rename)
        inoremap <expr> <cr> pumvisible() ? "\<c-y>\<cr>" : "\<cr>"
    endfunction

    augroup lsp_install
        au!
        autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
    augroup END
    command! LspDebug let lsp_log_verbose=1 | let lsp_log_file = expand('~/lsp.log')

    let g:lsp_diagnostics_enabled = 1
    let g:lsp_diagnostics_echo_cursor = 1
    let g:asyncomplete_popup_delay = 200
endif

"asyncomplete.vim
if s:plug.is_installed("asyncomplete.vim")
    inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
    inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
    inoremap <expr> <cr>    pumvisible() ? "\<C-y>" : "\<cr>"
endif

"NERDTree
if s:plug.is_installed("nerdtree")
    let NERDTreeHijackNetrw = 0
    let NERDTreeMinimalUI=1
    augroup nerdtree_autocmd
        au!
        autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
    augroup END
    let g:NERDTreeWinSize=22

    let s:nerdtreeToggle=0
    function! s:NotWindowMoveWhenNERDTreeOpen() abort
        if s:nerdtreeToggle
            NERDTreeClose
            let s:nerdtreeToggle = 0
        else
            NERDTreeFind | wincmd p
            let s:nerdtreeToggle = 1
        endif
    endfunction
    nnoremap <silent> <Leader>n :<C-u>call <SID>NotWindowMoveWhenNERDTreeOpen()<CR>
endif

"vaffle
if s:plug.is_installed("vaffle.vim")
    function! s:customize_vaffle_mappings() abort
        nmap <buffer> <Bslash> <Plug>(vaffle-open-root)
        nmap <buffer> c <Plug>(vaffle-chdir-here)
        map <buffer> s <Plug>(vaffle-toggle-current)
    endfunction
    augroup vaffle
        au!
        autocmd FileType vaffle call s:customize_vaffle_mappings()
    augroup END
endif

"neoterm
if s:plug.is_installed("neoterm")
    let g:neoterm_default_mod='belowright'
    let g:neoterm_size=8
    let g:neoterm_autoscroll=1
    nnoremap <silent> <Leader>to :<C-u>Ttoggle<CR><ESC>
    tnoremap <A-t> <C-\><C-n>:Ttoggle<CR>
    vnoremap <silent> <C-e> :TREPLSendSelection<CR><ESC>
endif

"vim-airline
if s:plug.is_installed("vim-airline")
    let g:airline_section_y = '%{&fileencoding},%{&fileformat}'
    let g:airline_section_z = '%l/%L,%c'
    "let g:airline#extensions#whitespace#enabled = 0
    let g:airline_theme='distinguished'
    let g:airline_powerline_fonts = 1
endif

"vimtex
if s:plug.is_installed("vimtex")
    let g:tex_flavor = 'latax'
    let g:vimtex_quickfix_open_on_warning = 0
    let g:vimtex_compiler_latexmk_engines = { '_' : '-pdfdvi' }
    let g:vimtex_compiler_progname = 'nvr'
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

if s:plug.is_installed("auto-pairs")
    nnoremap <Leader>p :<C-u>call AutoPairsToggle()<CR>
endif

"colorsheme
if s:plug.is_installed("iceberg.vim")
    set termguicolors
    set t_Co=256
    set background=dark
    colorscheme iceberg
endif

augroup delay_autocmd
    autocmd!
    autocmd Filetype * set formatoptions-=ro
augroup END
