if !1 | finish | endif

" Encoding
set fileencodings=utf-8,sjis
set encoding=utf-8

scriptencoding utf-8

if &compatible
    set nocompatible
endif

" Version settings
let s:is_neovim = has('nvim')
let s:is_windows = has('win32') || has('win64')

if s:is_windows
    let s:vimfiles_dir = expand('~/vimfiles')
else
    set shell=/bin/bash
    if s:is_neovim
        let s:vimfiles_dir = expand('~/.local/share/nvim')
    else
        let s:vimfiles_dir = expand('~/.vim')
    endif
endif

if exists('s:vimfiles_dir')
    let s:plug_dir = s:vimfiles_dir . '/plugged'
    let s:swap_dir = s:vimfiles_dir . '/swap'

    function! s:makeDir(dir) abort
        if !isdirectory(a:dir)
            call mkdir(a:dir, 'p')
        endif
    endfunction
    call s:makeDir(s:swap_dir)

    "swap file
    execute 'set directory=' . s:swap_dir
    set swapfile
endif

" Options (:options)
" 2 moving around, searching and patterns
set wrapscan
set incsearch
set ignorecase
set smartcase
" 3 tags
set tags+=tags;
" 4 displaying text
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
" 5 syntax, highlighting and spelling
set hlsearch
set cursorline
" 6 multiple windows
set laststatus=2
set statusline=%<%t%m%r%h%w
set statusline+=%=
set statusline+=\|\ %{&fileencoding},%{&fileformat}
set statusline+=\ \|\ %Y
set statusline+=\ \|\ %l/%L,%c\ \|
set hidden
" 8 terminal
set title
if s:is_neovim
    set titlestring=NeoVim
else
    set titlestring=Vim
endif
set titlestring+=:\ %f%m
" 11 messages and info
set showcmd
set noerrorbells
set visualbell t_vb=
set belloff=all
set helplang=en,ja
" 12 selecting text
"set clipboard+=unnamed
" 13 editing text
set backspace=indent,eol,start
set formatoptions-=ro
set pumheight=10
set showmatch
set matchtime=1
" 14 tabs and indenting
set tabstop=4
set shiftwidth=4
set expandtab
set autoindent
set smartindent
" 18 reading and writing files
set nobackup
" 20 command line editing
set wildmenu
" 25 various
set viminfo='50,<500,s100,h

" Key-mappings
let g:mapleader = "\<Space>"
nnoremap <Space> <Nop>
" Normal mode
" Leader mappings
nnoremap <Leader>w :<C-u>write<CR>
nnoremap <silent> <Leader>q :<C-u>quit<CR>
nnoremap <Leader>wq :<C-u>wq<CR>
nnoremap <Leader>gs :<C-u>s///g<Left><Left><Left>
nnoremap <Leader>gps :<C-u>%s///g<Left><Left><Left>
nnoremap <Leader>s. :<C-u>source $MYVIMRC<CR>
"nnoremap <Leader>r :<C-u>registers<CR>
nnoremap <silent><Leader>. :<C-u>e $MYVIMRC<CR>
" Insert line break
nnoremap <silent> <Leader>o :<C-u>for i in range(1, v:count1) \| call append(line('.'),   '') \| endfor \| silent! call repeat#set("<Leader>o", v:count1)<CR>
nnoremap <silent> <Leader>O :<C-u>for i in range(1, v:count1) \| call append(line('.')-1, '') \| endfor \| silent! call repeat#set("<Leader>o", v:count1)<CR>
nnoremap <silent> <Leader><C-l> <C-l>
if !s:is_neovim
    nnoremap <silent> <Leader>to :<C-u>botright terminal ++rows=8<CR>
endif
" Others
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
" Normal, visual mode
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
" Insert mode
inoremap jj <Esc>
inoremap <C-c> <Esc>
inoremap <S-Tab> <C-d>
inoremap <C-@> <C-[>
" Terimnal mode
tnoremap <A-w> <C-\><C-n><C-w>w
tnoremap jj <C-\><C-n>
" Function mappings
nnoremap <silent> <Leader>jh :<C-u>call <SID>helplangToJapanese()<CR>
nnoremap <silent> <Leader>f :<C-u>call <SID>toggleQuickfix()<CR>
nnoremap <silent> <Leader>tm :<C-u>call <SID>moveToNewtab()<CR>

" Function
" For map
let s:helplang_is_ja = 0
" For displaying help in Japanese
function! s:helplangToJapanese() abort
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

" Quickfix window open
function! s:toggleQuickfix() abort
    let l:nr = winnr('$')
    cwindow
    let l:nr2 = winnr('$')
    if l:nr == l:nr2
        cclose
    endif
endfunction

function! s:moveToNewtab() abort
    tab split
    tabprevious
    if winnr('$') > 1
        close
    elseif bufnr('$') > 1
        buffer #
    endif
    tabnext
endfunction

" For autocmd functions
function! s:quickfixSettings() abort
    setlocal nowrap
endfunction

function! s:terminalmodeSettings() abort
    setlocal bufhidden=wipe
    nnoremap <silent> <buffer> <Leader>q :<C-u>quit!<CR>
endfunction

" Command
command! -nargs=1 VimGrepF execute 'vimgrep <args> %'
command! -nargs=1 VimGrepD execute 'vimgrep <args> **'
command! Cd execute 'lcd %:h'
command! -nargs=* TermOpen execute 'botright terminal ++rows=8 <args>'

" Autocmd
augroup myAutocmd
    autocmd!
    autocmd ColorScheme * highlight clear Cursorline
    autocmd InsertLeave * set nopaste
    "autocmd BufWritePre * :%s/\s\+$//e

    " Help autocmd
    autocmd FileType help,qf nnoremap <silent> <buffer> q :<C-u>q<CR>
    autocmd FileType help,vim setlocal keywordprg=:help

    " Quickfix autocmd
    autocmd QuickFixCmdPost *grep*,make cwindow
    autocmd FileType qf call s:quickfixSettings()
    autocmd BufEnter * if (winnr('$') == 1 && &filetype ==# 'qf') | q | endif

    " Terminal mode autocmd
    autocmd BufEnter * if &buftype ==# 'terminal' | setlocal nonumber | endif
    autocmd BufEnter * if (winnr('$') == 1 && &buftype ==# 'terminal') | q! | endif
    if !s:is_neovim
        autocmd TerminalOpen * if &buftype ==# 'terminal' | call s:terminalmodeSettings() | endif
    else
        autocmd WinEnter * if &buftype ==# 'terminal' | startinsert | endif
    endif
augroup END

" Finish when using git commit
if $HOME != $USERPROFILE && $GIT_EXEC_PATH != ''
    finish
end

" Package
if !s:is_neovim
    if has('eval') && v:version >= 800
        packadd! matchit
    endif
    if v:version >= 801
        packadd! termdebug
        let g:termdebug_wide = 163
    endif
endif

" Plugin
" vim-plug
if empty(globpath(&rtp, 'autoload/plug.vim'))
    " Finish when vim-plug isn't installed
    colorscheme ron
    finish
endif

call plug#begin(s:plug_dir)
" Manual
Plug 'junegunn/vim-plug'
Plug 'vim-jp/vimdoc-ja'
" fzf
Plug 'junegunn/fzf', { 'do': { -> fzf#install()  }  }
Plug 'junegunn/fzf.vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'mattn/ctrlp-matchfuzzy'
" vim-lsp, auto complete
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
" Git
Plug 'tpope/vim-fugitive'
" Filer
Plug 'mattn/vim-molder'
Plug 'lambdalisue/fern.vim'
" Terminal
if s:is_neovim
    Plug 'kassio/neoterm'
endif
" Theme
Plug 'itchyny/lightline.vim'
Plug 'cocopon/iceberg.vim'
" Others
Plug 'lervag/vimtex'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'jiangmiao/auto-pairs'
call plug#end()

let s:plug = { 'plugs': get(g:, 'plugs', {}) }
function! s:plug.isInstalled(name) abort
    return has_key(self.plugs, a:name) ? isdirectory(self.plugs[a:name].dir) : 0
endfunction

" fzf.vim
if s:plug.isInstalled("fzf.vim")
    command! -bang -nargs=* Rg
                \ call fzf#vim#grep(
                \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
                \   <bang>0 ? fzf#vim#with_preview('up:60%')
                \           : fzf#vim#with_preview('right:50%:hidden', '?'),
                \   <bang>0)

    augroup fzfAutocmd
        au!
        autocmd FileType fzf set laststatus=0 noshowmode noruler
                    \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
    augroup END
endif

" ctrlp.vim
if s:plug.isInstalled("ctrlp.vim")
    let g:ctrlp_map = '<Leader>p'
    let g:ctrlp_match_func = {'match': 'ctrlp_matchfuzzy#matcher'}
endif

" vim-lsp
if s:plug.isInstalled("vim-lsp")
    let g:lsp_diagnostics_enabled = 1
    let g:lsp_diagnostics_echo_cursor = 1

    function! s:lsp_buffer_settings() abort
        setlocal omnifunc=lsp#complete
        setlocal signcolumn=yes
        if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
        nmap <silent> <buffer> <C-p> <plug>(lsp-previous-diagnostic)
        nmap <silent> <buffer> <C-n> <plug>(lsp-next-diagnostic)
        nmap <silent> <buffer> gd <plug>(lsp-definition)
        nmap <silent> <buffer> <Leader>rn <plug>(lsp-rename)
        nmap <silent> <buffer> K <plug>(lsp-hover)
        inoremap <expr> <cr> pumvisible() ? "\<c-y>\<cr>" : "\<cr>"
    endfunction

    augroup vimlspAutocmd
        autocmd!
        autocmd User lsp_buffer_enabled call s:lsp_buffer_settings()
        if executable('haskell-language-server')
            autocmd User lsp_setup call lsp#register_server({
                    \ 'name': 'haskell-language-server',
                    \ 'cmd': {server_info->['haskell-language-server-wrapper', '--lsp']},
                    \ 'allowlist': ['haskell','lhaskell'],
                    \})
        endif
    augroup END
endif

" asyncomplete.vim
if s:plug.isInstalled("asyncomplete.vim")
    let g:asyncomplete_popup_delay = 200

    inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
    inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<C-d>"
    inoremap <expr> <cr>    pumvisible() ? "\<C-y>" : "\<cr>"
endif

" vim-molder
if s:plug.isInstalled("vim-molder")
    function! s:customize_vimmolder_mappings() abort
        nmap <buffer> l <Plug>(molder-open)
        nmap <buffer> h <Plug>(molder-up)
    endfunction

    augroup vimmolderAutocmd
        autocmd!
        autocmd FileType molder call s:customize_vimmolder_mappings()
    augroup END
endif

" fern
if s:plug.isInstalled("fern.vim")
    nnoremap <silent> <leader>f :<C-u>Fern . -reveal=% -drawer -stay -toggle<CR>

    augroup fernAutocmd
        autocmd!
        autocmd FileType fern setlocal nonumber
    augroup END
endif

" neoterm
if s:plug.isInstalled("neoterm")
    let g:neoterm_default_mod="belowright"
    let g:neoterm_size=8
    let g:neoterm_autoscroll=1

    nnoremap <silent> <Leader>to :<C-u>Ttoggle<CR><ESC>
    tnoremap <A-t> <C-\><C-n>:Ttoggle<CR>
    vnoremap <silent> <C-e> :TREPLSendSelection<CR><ESC>
endif

" lightline.vim
if s:plug.isInstalled("lightline.vim")
    set noshowmode
    let g:lightline = {
                \ 'colorscheme': 'ayu_mirage',
                \ 'active': {
                \   'left' : [ ['mode', 'paste'],
                \              ['fugitive', 'readonly', 'filename'] ],
                \   'right': [ ['lsp_errors', 'lsp_warnings', 'lineinfo'],
                \              ['filetype'],
                \              ['fileencoding_and_fileformat'] ],
                \ },
                \ 'inactive': {
                \   'right': [ ['lineinfo'] ],
                \ },
                \ 'component': {
                \   'lineinfo': '%2l/%L,%-2c%<',
                \   'filetype': '%{&filetype !=# "" ? &filetype : ""}',
                \ },
                \ 'component_function': {
                \   'mode': 'LightlineMode',
                \   'fugitive': 'LightlineFugitive',
                \   'readonly': 'LightlineReadonly',
                \   'filename': 'LightlineFilename',
                \   'fileencoding_and_fileformat': 'LightlineEncandFt',
                \ },
                \ 'component_expand': {
                \   'lsp_errors': 'LightlineLSPErrors',
                \   'lsp_warnings': 'LightlineLSPWarnings',
                \ },
                \ 'component_type': {
                \   'lsp_errors': 'error',
                \   'lsp_warnings': 'warning',
                \ },
                \ }

    function! LightlineMode() abort
        return &buftype ==# "terminal" ? "TERMINAL" :
                    \ &filetype ==# "help" ? "HELP" :
                    \ &filetype ==# "qf" ? "" :
                    \ &filetype ==# "molder" ? "MOLDER" :
                    \ winwidth(0) <= 70 && &filetype ==# "fern" ? "" :
                    \ &filetype ==# "fern" ? "FERN" :
                    \ lightline#mode()
    endfunction

    function! LightlineFugitive() abort
        if winwidth(0) > 70 && &filetype !~ "\v(help|qf)"
            if exists('*FugitiveHead')
                let l:branch = FugitiveHead()
                return branch !=# "" ? " ". l:branch : ""
            endif
        endif
        return ""
    endfunction

    function! LightlineModified() abort
        if &filetype !=# 'help'
            if &modified
                return "[+]"
            elseif !&modifiable
                return "[-]"
            endif
        endif
        return ""
    endfunction

    function! LightlineFilename() abort
        if &filetype ==# "molder"
            return expand('%')
        elseif &filetype ==# "fern"
            return b:fern.root._path
        elseif &filetype ==# "qf"
            return "QuickFix"
        else
            let l:filename = expand('%:t') !=# "" ? expand('%:t') : "[No Name]"
            return l:filename . LightlineModified()
        endif
    endfunction

    function! LightlineReadonly() abort
        return &readonly && &filetype !=# 'help' ? "RO" : ""
    endfunction

    function! LightlineEncandFt() abort
        if winwidth(0) > 70
            let l:encoding = &fileencoding !=# "" ? &fileencoding : &encoding
            let l:format = &fileformat
            return l:encoding . "," . l:format
        endif
        return ""
    endfunction

    function! LightlineLSPWarnings() abort
        let l:counts = lsp#ui#vim#diagnostics#get_buffer_diagnostics_counts()
        return l:counts.warning == 0 ? '' : printf('W:%d', l:counts.warning)
    endfunction

    function! LightlineLSPErrors() abort
        let l:counts = lsp#ui#vim#diagnostics#get_buffer_diagnostics_counts()
        return l:counts.error == 0 ? '' : printf('E:%d', l:counts.error)
    endfunction

    augroup lightlineAutocmd
        autocmd!
        autocmd User lsp_diagnostics_updated call lightline#update()
    augroup END
endif

" vimtex
if s:plug.isInstalled("vimtex")
    let g:tex_flavor = 'latax'
    let g:vimtex_quickfix_open_on_warning = 0
    if s:is_neovim
        let g:vimtex_compiler_progname = 'nvr'
    endif
endif

" auto-pairs
if s:plug.isInstalled("auto-pairs")
    nnoremap <Leader>( :<C-u>call AutoPairsToggle()<CR>
endif

" Colorscheme
if s:plug.isInstalled("iceberg.vim")
    set termguicolors
    set t_Co=256
    set background=dark
    colorscheme iceberg
endif

augroup delayAutocmd
    autocmd!
    autocmd Filetype * set formatoptions-=ro
augroup END
