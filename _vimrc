if !1 | finish | endif

"Encoding
set fileencodings=utf-8,sjis
set encoding=utf-8

scriptencoding utf-8

if &compatible
    set nocompatible
endif

"Options (:options)
"2 moving around, searching and patterns
set wrapscan
set incsearch
set ignorecase
set smartcase
"3 tags
set tags=./tags;
"4 displaying text
set scrolloff=5
set breakindent
set showbreak=>\
set display=lastline
set cmdheight=2
set list
set listchars=tab:^-
set number
"5 syntax, highlighting and spelling
set background=dark
set hlsearch
set termguicolors
set t_Co=256
set cursorline
"6 multiple windows
set laststatus=2
set statusline=%<%t%m%r%h%w%=
set statusline+=\|\ %{&fileencoding},%{&fileformat}\ \|
set statusline+=\ %Y\ \|\ %l/%L,%c\ \|
set hidden
"8 terminal
set title
set titlestring=Vim:\ %f%{ShowModified()}
"11 messages and info
set showcmd
set noerrorbells
set visualbell t_vb=
set belloff=all
set helplang=en,ja
"12 selecting text
" set clipboard+=unnamed
"13 editing text
set backspace=indent,eol,start
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
set wildmode=longest,full
set wildmenu
"25 various
set viminfo='50,<500,s100,h

colorscheme desert

"Key-mappings
let g:mapleader = "\<Space>"
nnoremap <Space> <Nop>
"Normal mode
"Leader mappings
nnoremap <Leader>w :<C-u>write<CR>
nnoremap <Leader>q :<C-u>quit<CR>
nnoremap <Leader>m :<C-u>marks<CR>
nnoremap <Leader>rg :<C-u>registers<CR>
nnoremap <Leader>gs :<C-u>s///g<Left><Left><Left>
nnoremap <Leader>gps :<C-u>%s///g<Left><Left><Left>
nnoremap <Leader>s. :<C-u>source $MYVIMRC<CR>
"erace space
nnoremap <Leader>d :<C-u>%s/\s\+$//e<CR>
nnoremap <Leader>tj :<C-u>tag<CR>
nnoremap <Leader>tk :<C-u>pop<CR>
nnoremap <Leader>tl :<C-u>tags<CR>
nnoremap <Leader>tm <C-w>T
nnoremap <silent><Leader>. :<C-u>call <SID>editActualFile($MYVIMRC)<CR>
nnoremap <silent> <Leader><C-l> :<C-u>nohlsearch<CR><C-l>
"Insert line break
"http://deris.hatenablog.jp/entry/20130404/1365086716
nnoremap <silent> <Leader>o :<C-u>for i in range(1, v:count1) \| call append(line('.'),   '') \| endfor \| silent! call repeat#set("<Leader>o", v:count1)<CR>
nnoremap <silent> <Leader>O :<C-u>for i in range(1, v:count1) \| call append(line('.')-1, '') \| endfor \| silent! call repeat#set("<Leader>O", v:count1)<CR>
"Others
nnoremap <silent> <Down> <C-w>-
nnoremap <silent> <Up> <C-w>+
nnoremap <silent> <Left> <C-w><
nnoremap <silent> <Right> <C-w>>
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap Y y$
nnoremap <C-]> g<C-]>
"Normal, visual mode
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
"Insert mode
inoremap jj <Esc>
inoremap <C-c> <Esc>
inoremap <S-Tab> <C-d>
inoremap <C-@> <C-[>
inoremap <C-U> <C-G>u<C-U>
"Command mode
cnoremap <C-q> <C-f>
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-d> <Del>
"Terimnal mode
tnoremap <A-w> <C-\><C-n><C-w>w
tnoremap jj <C-\><C-n>
"Quickfix 
nnoremap cn :<C-u>cnext<CR>
nnoremap cp :<C-u>cprevious<CR>
nnoremap co :<C-u>call <SID>toggleQuickfix()<CR>
"Function mappings
nnoremap <silent> <Leader>jh :<C-u>call <SID>helplang2Japanese()<CR>

"Function
function! ShowModified() abort
    if &buftype ==# "terminal"
        if &modified
            return " [Runnning]"
        elseif !&modifiable
            return " [Finished]"
        endif
    endif
    if &filetype !=# "help"
        if &modified
            return " [+]"
        elseif !&modifiable
            return " [-]"
        endif
    endif
    return ""
endfunction

"Map functions
"For displaying help in Japanese
let s:helplang_is_ja = 0
function! s:helplang2Japanese() abort
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

"Quickfix window open
function! s:toggleQuickfix() abort
    let l:nr = winnr('$')
    cwindow
    let l:nr2 = winnr('$')
    if l:nr == l:nr2
        cclose
    endif
endfunction

"For editing symbolic link file
function! s:editActualFile(filename) abort
    let l:actualFilename = resolve(expand(a:filename))
    execute "e " . l:actualFilename
endfunction

"Autocmd functions
function! s:adjustWindowHeight(minHeight, maxHeight) abort
    execute max([min([line("$"), a:maxHeight]), a:minHeight]) . "wincmd _"
endfunction

function! s:quickfixSettings() abort
    setlocal nowrap
    call s:adjustWindowHeight(3,8)
endfunction

function! s:terminalmodeSettings() abort
    setlocal bufhidden=wipe
    nnoremap <silent> <buffer> <Leader>q :<C-u>quit!<CR>
endfunction

"Command
command! -nargs=1 VimGrepF execute 'vimgrep <args> %'
command! -nargs=1 VimGrepD execute 'vimgrep <args> **'
command! -nargs=* TermOpen execute 'botright terminal ++rows=8 <args>'
command! Cd execute 'lcd %:h'

"Autocmd
augroup myAutocmd
    autocmd!
    autocmd ColorScheme * highlight clear Cursorline
    autocmd InsertLeave * set nopaste
    autocmd BufReadPost * if line("'\"") >= 1 &&
                \line("'\"") <= line("$") && &ft !~# 'commit'
                \| exe "normal! g`\"" | endif

    "Filetype autocmd
    autocmd FileType help,vim setlocal keywordprg=:help
    autocmd FileType help,qf nnoremap <silent> <buffer> q :<C-u>q<CR>
    autocmd FileType qf call s:quickfixSettings()

    "Quickfix autocmd
    autocmd QuickFixCmdPost *grep*,make if len(getqflist()) != 0 | cwindow | endif

    "Terminal mode autocmd
    autocmd BufEnter * if &buftype ==# 'terminal' | setlocal nonumber | endif

    autocmd BufEnter * if (winnr('$') == 1 && 
                \(&buftype ==# 'terminal' || &filetype =~# '\v(qf|quickrun)'))
                \| q! | endif
    autocmd TerminalOpen * if &buftype ==# 'terminal'
                \| call s:terminalmodeSettings() | endif
augroup END

"Version settings
let s:is_windows = has('win32') || has('win64')

if s:is_windows
    let s:vimfiles_dir = expand('~/vimfiles')
    set viminfo+=n~/vimfiles/.viminfo
    set noshellslash

    nnoremap <silent> <Leader>to :<C-u>botright terminal ++rows=8 powershell<CR>
    nnoremap <silent><Leader>g. :<C-u>call <SID>editActualFile($MYGVIMRC)<CR>
else
    let s:vimfiles_dir = expand('~/.vim')
    let s:viminfo_path = s:vimfiles_dir . '/.viminfo'
    execute 'set viminfo+=n' . s:viminfo_path
    set shell=/bin/bash

    nnoremap <silent> <Leader>to :<C-u>botright terminal ++rows=8<CR>
endif

"let s:viminfo_path = s:vimfiles_dir . '/.viminfo'
let s:swap_dir = s:vimfiles_dir . '/swap'
let s:undo_dir = s:vimfiles_dir . '/undo'

"Make directory
function! s:makeDir(dir) abort
    if !isdirectory(a:dir)
        call mkdir(a:dir, 'p')
    endif
endfunction

call s:makeDir(s:swap_dir)
"execute 'set viminfo+=n' . s:viminfo_path
execute 'set directory=' . s:swap_dir
set swapfile

if has('persistent_undo')
    call s:makeDir(s:undo_dir)
    execute 'set undodir=' . s:undo_dir
    set undofile
endif

"Default plugin disable
let g:loaded_zip = 1
let g:loaded_zipPlugin = 1
let g:loaded_tar = 1
let g:loaded_tarPlugin = 1
let g:loaded_gzip = 1
let g:loaded_getscript = 1
let g:loaded_getscriptPlugin = 1
let g:loaded_vimball = 1
let g:loaded_vimballPlugin = 1
let g:loaded_2html_plugin = 1
let g:skip_loading_mswin = 1

"Finish when using git commit
if $HOME != $USERPROFILE && $GIT_EXEC_PATH != ''
    finish
end

"Package
packadd! matchit
if v:version >= 801
    packadd! termdebug
    let g:termdebug_wide = 163
endif

"Use Ripgrep in Quickfix
if executable('rg')
    let &grepprg = 'rg --vimgrep --hidden'
    set grepformat=%f:%l:%c:%m
endif

"Plugin
"vim-plug
if empty(globpath(&rtp, 'autoload/plug.vim'))
    filetype plugin indent on
    syntax enable
    finish
endif

let s:plug_dir = s:vimfiles_dir . '/plugged'
call plug#begin(s:plug_dir)
"Manual
Plug 'junegunn/vim-plug'
Plug 'vim-jp/vimdoc-ja'
"vim-lsp, auto complete, snippet
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'
"Language
"html
Plug 'mattn/emmet-vim', { 'for': 'html' }
Plug 'alvan/closetag.vim', { 'for': 'html' }
"fuzzy finder
Plug 'ctrlpvim/ctrlp.vim'
"Git
Plug 'tpope/vim-fugitive'
"Filer
Plug 'mattn/vim-molder'
Plug 'lambdalisue/fern.vim', { 'on': 'Fern' }
"Theme
Plug 'itchyny/lightline.vim'
Plug 'cocopon/iceberg.vim'
"Others
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'thinca/vim-quickrun'
Plug 'jiangmiao/auto-pairs'
Plug 'kana/vim-operator-user'
Plug 'kana/vim-operator-replace'
call plug#end()

let s:plug = { 'plugs': get(g:, 'plugs', {}) }
function! s:plug.isInstalled(name) abort
    return has_key(self.plugs, a:name) ? isdirectory(self.plugs[a:name].dir) : 0
endfunction

"asyncomplete.vim
let g:asyncomplete_popup_delay = 200

inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<C-d>"
inoremap <expr> <CR>    pumvisible() ? "\<C-y>" : "\<CR>"

"vim-lsp
let g:lsp_diagnostics_enabled = 1
let g:lsp_diagnostics_echo_cursor = 1
let g:lsp_settings_enable_suggestions = 0

function! s:vimlspSettings() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> <Leader>rn <plug>(lsp-rename)
    if &filetype != "vim" | nmap <buffer> K <plug>(lsp-hover) | endif
    inoremap <expr> <cr> pumvisible() ? "\<c-y>\<cr>" : "\<cr>"
    inoremap <buffer> <expr><C-f> lsp#scroll(+4)
    inoremap <buffer> <expr><C-d> lsp#scroll(-4)
endfunction

augroup vimlspAutocmd
    autocmd!
    autocmd User lsp_buffer_enabled call s:vimlspSettings()
augroup END

"ctrlP
let g:ctrlp_match_window = 'min:8,max:8'
let g:ctrlp_cache_dir = s:vimfiles_dir . '/.cache/ctrlp'
let g:ctrlp_custom_ignore = {
            \ 'dir':  '\v[\/]\.(git|hg|svn)$',
            \ 'file': '\v\.(exe|so|dll)$',
            \ }

"vim-molder
let g:loaded_netrw       = 1
let g:loaded_netrwPlugin = 1
let g:loaded_netrwSettings = 1
let g:loaded_netrwFileHandlers = 1

function! s:vimmolderSettings() abort
    nmap <buffer> l <Plug>(molder-open)
    nmap <buffer> h <Plug>(molder-up)
    nmap <buffer> . <Plug>(molder-toggle-hidden)
    nnoremap <buffer> e :<C-u>lcd %<CR>:e<Space>
    nnoremap <buffer> cd :<C-u>lcd %<CR>
endfunction

augroup vimmolderAutocmd
    autocmd!
    autocmd FileType molder call s:vimmolderSettings()
augroup END

"fern
if s:plug.isInstalled("fern.vim")
    nnoremap <silent> <Leader>f :<C-u>Fern . -reveal=% -drawer -stay -toggle<CR>

    function! s:fernSettings()
        setlocal nonumber
        nmap <buffer> <Leader>. <Plug>(fern-action-hidden)
    endfunction

    augroup fernAutocmd
        autocmd!
        autocmd FileType fern call s:fernSettings()
    augroup END
endif

"lightline.vim
set noshowmode
let g:lightline = {
            \ 'colorscheme': 'iceberg',
            \ 'active': {
                \   'left' : [ ['mode', 'paste'],
                \              ['fugitive', 'readonly', 'filename'], ['ctrlpmark'] ],
                \   'right': [ ['lsp_errors', 'lsp_warnings', 'lineinfo'],
                \              ['filetype'],
                \              ['fileencoding_and_fileformat'] ],
                \   },
                \ 'inactive': {
                    \   'right': [ ['lineinfo'] ],
                    \   },
                    \ 'component': {
                        \   'lineinfo': '%2l/%L,%-2c%<',
                        \   'filetype': '%{&filetype !=# "" ? &filetype : ""}',
                        \   },
                        \ 'component_function': {
                            \   'mode': 'LightlineMode',
                            \   'fugitive': 'LightlineFugitive',
                            \   'readonly': 'LightlineReadonly',
                            \   'filename': 'LightlineFilename',
                            \   'fileencoding_and_fileformat': 'LightlineEncandFt',
                            \   'ctrlpmark': 'CtrlPMark',
                            \   },
                            \ 'component_expand': {
                                \   'lsp_errors': 'LightlineLSPErrors',
                                \   'lsp_warnings': 'LightlineLSPWarnings',
                                \   },
                                \ 'component_type': {
                                    \   'lsp_errors': 'error',
                                    \   'lsp_warnings': 'warning',
                                    \   },
                                    \ }

function! LightlineMode() abort
    return &filetype ==# "help" ? "HELP" :
                \ &filetype ==# "qf" ? "" :
                \ &filetype ==# 'ctrlp' ? 'CtrlP' :
                \ &filetype ==# "molder" ? "MOLDER" :
                \ &filetype ==# "fern" ? "FERN" :
                \ winwidth(0) <= 70 && &filetype ==# "fern" ? "" :
                \ lightline#mode()
endfunction

function! LightlineFugitive() abort
    if winwidth(0) > 70 && &filetype !~# '\v(help|qf|ctrlp|quickrun)'
        if exists('*FugitiveHead')
            let l:branch = FugitiveHead()
            return branch !=# "" ? " ". l:branch : ""
        endif
    endif
    return ""
endfunction

function! LightlineFilename() abort
    if &filetype ==# "qf"
        if exists("w:quickfix_title")
            return "[Quickfix List]" . " | " . w:quickfix_title
        else
            return "[Quickfix List]"
        endif
    elseif &filetype ==# 'ctrlp' && has_key(g:lightline, 'ctrlp_item') 
        return g:lightline.ctrlp_item
    elseif &filetype ==# "molder"
        return expand('%')
    elseif &filetype ==# "fern"
        return b:fern.root._path
    else
        let l:filename = expand('%:t') !=# "" ? expand('%:t') : "[No Name]"
        return l:filename . ShowModified()
    endif
endfunction

function! LightlineReadonly() abort
    return &readonly && &filetype !~# '\v(help|molder)' ? "RO" : ""
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
    let l:counts = lsp#get_buffer_diagnostics_counts()
    return l:counts.warning == 0 ? '' : printf('W:%d', l:counts.warning)
endfunction

function! LightlineLSPErrors() abort
    let l:counts = lsp#get_buffer_diagnostics_counts()
    return l:counts.error == 0 ? '' : printf('E:%d', l:counts.error)
endfunction

function! CtrlPMark()
    if &filetype ==# 'ctrlp' && has_key(g:lightline, 'ctrlp_item')
        call lightline#link('iR'[g:lightline.ctrlp_regex])
        return lightline#concatenate([g:lightline.ctrlp_prev, g:lightline.ctrlp_item
                    \ , g:lightline.ctrlp_next], 0)
    else
        return ''
    endif
endfunction

"lightline in CtrlP
let g:ctrlp_status_func = {
            \ 'main': 'CtrlPStatusFunc_1',
            \ 'prog': 'CtrlPStatusFunc_2',
            \ }

function! CtrlPStatusFunc_1(focus, byfname, regex, prev, item, next, marked)
    let g:lightline.ctrlp_regex = a:regex
    let g:lightline.ctrlp_prev = a:prev
    let g:lightline.ctrlp_item = a:item
    let g:lightline.ctrlp_next = a:next
    return lightline#statusline(0)
endfunction

function! CtrlPStatusFunc_2(str)
    return lightline#statusline(0)
endfunction

augroup lightlineAutocmd
    autocmd!
    autocmd User lsp_diagnostics_updated call lightline#update()
augroup END

"quickrun
let g:quickrun_config = {
            \ '_': {
                \   'outputter': 'buffer',
                \   'outputter/buffer/name': "[Quickrun Output]",
                \   'outputter/buffer/split': ":botright 8",
                \   'outputter/buffer/running_mark': "[Runninng...]",
                \   'runner': 'job',
                \   },
                \ 'tex' : {
                    \   'command': 'lualatex',
                    \   'exec': ['%c -interaction=nonstopmode -file-line-error %s']
                    \   }
                    \ }

"auto-pairs
if s:plug.isInstalled("auto-pairs")
    nnoremap <Leader>( :<C-u>call AutoPairsToggle()<CR>
endif

"vim-operator-replace
if s:plug.isInstalled("vim-operator-replace")
    map _ <Plug>(operator-replace)
endif

"Colorscheme
if s:plug.isInstalled("iceberg.vim")
    colorscheme iceberg
endif

augroup delayAutocmd
    autocmd!
    autocmd Filetype * set formatoptions-=ro
augroup END
