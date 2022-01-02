let s:darwin = has('mac')
let s:windows = has('win32') || has('win64')

" leader
let mapleader      = ' '
let maplocalleader = ' '
let g:mapleader = ' '

" netrw
" https://vonheikemen.github.io/devlog/tools/using-netrw-vim-builtin-file-explorer/
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
"let g:netrw_altv = 1
let g:netrw_winsize = 25
let g:netrw_keepdir = 0                " Keep the current directory and the browsing directory synced
let g:netrw_localcopydircmd = 'cp -r'  " enable recursive copy of directories

function! NetrwMapping()
  nmap <buffer> H u
  nmap <buffer> h -^
  nmap <buffer> l <CR>

  nmap <buffer> . gh
  nmap <buffer> P <C-w>z

  nmap <buffer> L <CR>:Lexplore<CR>
  nmap <buffer> <Leader>dd :Lexplore<CR>
endfunction

augroup netrw_mapping
  autocmd!
  autocmd filetype netrw call NetrwMapping()
augroup END

" syntax
syntax on
syntax enable

" history : how many lines of history VIM has to remember
set history=2000

" filetype
filetype on
" Enable filetype plugins
filetype plugin on
filetype indent on

" base
set nocompatible                " don't bother with vi compatibility
set autochdir
set autoread                    " reload files when changed on disk, i.e. via `git checkout`
set shortmess=atI

set magic                       " For regular expressions turn magic on
set title                       " change the terminal's title
set hidden                      " donot hidden after disable terminal
set splitbelow                  " split a window one the below
set splitright                  " vsplit a window on the right

if !isdirectory($HOME.'/.vim/files') && exists('*mkdir')
  call mkdir($HOME.'/.vim/files')
endif

" backupfiles
set nobackup
set nowritebackup
"set backupdir   =$HOME/.vim/files/backup/
"set backupext   =-vimbackup
set backupskip  =
" swapfiles
set noswapfile
"set directory   =$HOME/.vim/files/swap/
"set updatecount =100
" undofiles
set noundofile
"set undodir     =$HOME/.vim/files/undo/

set novisualbell                " turn off visual bell
set noerrorbells                " don't beep
set visualbell t_vb=            " turn off error beep/flash
set t_vb=
set tm=500
"set t_ti= t_te=                " 退出vim时显示当前屏幕内容在终端

set cursorline
set colorcolumn=80

" movement
set scrolloff=7                 " keep 7 lines when scrolling

" show
set ruler                       " show the current row and column
set number                      " show line numbers
"set nowrap                      " 超过窗口的行不换行显示
set showcmd                     " display incomplete commands
set showmode                    " display current modes
set showmatch                   " jump to matches when entering parentheses
set matchtime=2                 " tenths of a second to show the matching parenthesis

" search
set hlsearch                    " highlight searches
set incsearch                   " do incremental searching, search as you type
set ignorecase                  " ignore case when searching
set smartcase                   " no ignorecase if Uppercase char present

" tab
set expandtab                   " expand tabs to spaces
set smarttab
set shiftround

" indent
set autoindent smartindent shiftround
set shiftwidth=2
set tabstop=2
set softtabstop=2                " insert mode tab and backspace use 4 spaces

" fold
set foldmethod=indent            " fold based on indent
set nofoldenable                 " disable fold when open vim

" encoding
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,gb2312,gbk,cp936,gb18030,big5,euc-jp,euc-kr,latin1
set termencoding=utf-8
set ffs=unix,dos,mac
set formatoptions+=m
set formatoptions+=B

" select & complete
set selection=inclusive
set selectmode=mouse,key

set completeopt=longest,menu
set wildmenu                           " show a navigable menu for tab completion"
set wildmode=longest,list,full
" 文件搜索和补全时忽略下面的扩展名
set suffixes=.bak,~,.o,.h,.info,.swp,.obj,.pyc,.pyo,.egg-info,.class
"stuff to ignore when tab completing
set wildignore=*.o,*.obj,*~,*.exe,*.a,*.pdb,*.lib
set wildignore+=*.so,*.dll,*.swp,*.egg,*.jar,*.class,*.pyc,*.pyo,*.bin,*.dex
" MacOSX/Linux
set wildignore+=*.zip,*.7z,*.rar,*.gz,*.tar,*.gzip,*.bz2,*.tgz,*.xz
set wildignore+=*DS_Store*,*.ipch
set wildignore+=*.gem
set wildignore+=*.png,*.jpg,*.gif,*.bmp,*.tga,*.pcx,*.ppm,*.img,*.iso
set wildignore+=*.so,*.swp,*.zip,*/.Trash/**,*.pdf,*.dmg,*/.rbenv/**
set wildignore+=*/.nx/**,*.app,*.git,.git
set wildignore+=*.wav,*.mp3,*.ogg,*.pcm
set wildignore+=*.mht,*.suo,*.sdf,*.jnlp
set wildignore+=*.chm,*.epub,*.pdf,*.mobi,*.ttf
set wildignore+=*.mp4,*.avi,*.flv,*.mov,*.mkv,*.swf,*.swc
set wildignore+=*.ppt,*.pptx,*.docx,*.xlt,*.xls,*.xlsx,*.odt,*.wps
set wildignore+=*.msi,*.crx,*.deb,*.vfd,*.apk,*.ipa,*.bin,*.msu
set wildignore+=*.gba,*.sfc,*.078,*.nds,*.smd,*.smc
set wildignore+=*.linux2,*.win32,*.darwin,*.freebsd,*.linux,*.android
" others
set backspace=indent,eol,start         " make that backspace key work the way it should
set whichwrap+=<,>,h,l
set clipboard+=unnamed
set updatetime=100
set diffopt+=vertical                  " make diff windows vertical

" ============================ theme and status line ============================

colo desert
set background=dark
set t_Co=256                           " 指定配色方案是256色
if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif

" status line
set laststatus=2                       "  Always show the status line - use 2 lines for the status bar
let s:disable_statusline =
    \ ['defx', 'denite', 'vista', 'tagbar', 'undotree', 'diff', 'peekaboo', 'sidemenu', 'qf', 'coc-explorer', 'startify', 'vim-plug']

function! GitRepo()
  if !has_key(b:, 'git_repo')
    let b:git_repo = trim(system('git rev-parse --show-toplevel 2>/dev/null'))
  endif
  return b:git_repo
endfunction

function! GitRepoName()
  let l:repo = GitRepo()
  if empty(l:repo)
    return l:repo
  endif
  return split(l:repo, '/')[-1]
endfunction

function! GitBranchName()
  if !has_key(b:, 'git_branch_name')
    let b:git_branch_name = trim(system('git rev-parse --abbrev-ref HEAD 2>/dev/null')) 
  endif
  return b:git_branch_name
endfunction

function! StatusLineFileName()
  if !has_key(b:, 'buffer_relative_path')
    let b:buffer_relative_path = empty(GitRepoName()) ? expand('%:p:~') : expand('%:p:.')
  endif
  return b:buffer_relative_path
endfunction

let s:stl = ''
" repo name
let s:stl .= "%#Directory#%{empty(GitRepoName()) ? '' : GitRepoName().'  '}"
" brance name
let s:stl .= "%#ModeMsg#%{empty(GitBranchName()) ? '' : '  '.GitBranchName().' '}"
" file name
let s:stl .= "%#Title#%{StatusLineFileName()}%h%w%r "

let s:stl .= "%="
let s:stl .= "%<"

let s:stl .= "%#StatusLineNC#  %p%% ☰ %l:%v "
let s:stl .= "%#StatusLineNC# %{&fileencoding?&fileencoding:&encoding}[%{&fileformat}] "
let s:stl .= "%#StatusLine# %{&filetype}"

let s:stl_nc = ""
let s:stl_nc .= "%#PmenuThumb# %n %f%h%w%r"

function s:status_line_active() abort
    if index(s:disable_statusline, &ft) > 0
        return
    endif

    let &l:statusline = s:stl
endfunction

function s:status_line_inactive() abort
    let &l:statusline = s:stl_nc
endfunction

augroup vime_theme_statusline_group
    autocmd!

    autocmd VimEnter,ColorScheme,FileType,WinEnter,BufWinEnter * call s:status_line_active()
    autocmd WinLeave * call s:status_line_inactive()

    autocmd FileChangedShellPost,BufFilePost,BufNewFile,BufWritePost * redrawstatus
augroup END

" set mark column color
hi! link SignColumn   LineNr
hi! link ShowMarksHLl DiffAdd
hi! link ShowMarksHLu DiffChange

" ================================= autocmd ===================================
augroup vimrc
  autocmd!
   "File types
  au BufNewFile,BufRead *.icc                           set filetype=cpp
  au BufNewFile,BufRead *.pde                           set filetype=java
  au BufNewFile,BufRead *.coffee-processing             set filetype=coffee
  au BufNewFile,BufRead Dockerfile*                     set filetype=dockerfile
  au BufNewFile,BufRead *.md,*.mkd,*.markdown           set filetype=markdown.mkd
  au BufNewFile *.sh,*.py exec ":call AutoSetFileHead()"
  function! AutoSetFileHead()
       ".sh
      if &filetype == 'sh'
          call setline(1, "\#!/bin/bash")
      endif

       "python
      if &filetype == 'python'
          call setline(1, "\#!/usr/bin/env python")
          call append(1, "\# encoding: utf-8")
      endif

      normal G
      normal o
      normal o
  endfunc

  au FileType python set tabstop=4 shiftwidth=4 expandtab ai
  au FileType ruby set tabstop=2 shiftwidth=2 softtabstop=2 expandtab ai
  au FileType c,cpp,java,go,php,javascript,puppet,python,rust,twig,xml,yml,perl au BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()
  fun! <SID>StripTrailingWhitespaces()
      let l = line(".")
      let c = col(".")
      %s/\s\+$//e
      call cursor(l, c)
  endfun

   "http://vim.wikia.com/wiki/Highlight_unwanted_spaces
  au BufNewFile,BufRead,InsertLeave * silent! match ExtraWhitespace /\s\+$/
  au InsertEnter * silent! match ExtraWhitespace /\s\+\%#\@<!$/

   "Close preview window
  if exists('##CompleteDone')
    au CompleteDone * pclose
  else
    au InsertLeave * if !pumvisible() && (!exists('*getcmdwintype') || empty(getcmdwintype())) | pclose | endif
  endif

   "Automatic rename of tmux window
  if exists('$TMUX') && !exists('$NORENAME')
    au BufEnter * if empty(&buftype) | call system('tmux rename-window '.expand('%:t:S')) | endif
    au VimLeave * call system('tmux set-window automatic-rename on')

  "return where you left last time
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif | normal! zvzz
  endif
augroup END

" ============================ key map ============================
"make vim respond to alt key
"https://github.com/fgheng/vime/blob/master/plugin/alt.vim
if !has('nvim')
  function! Terminal_MetaMode(mode)
    set ttimeout
    if $TMUX != ''
        set ttimeoutlen=30
    elseif &ttimeoutlen > 80 || &ttimeoutlen <= 0
        set ttimeoutlen=80
    endif
    if has('nvim') || has('gui_running')
        return
    endif
    function! s:metacode(mode, key)
        if a:mode == 0
            exec "set <M-".a:key.">=\e".a:key
        else
            exec "set <M-".a:key.">=\e]{0}".a:key."~"
        endif
    endfunc
    for i in range(10)
        call s:metacode(a:mode, nr2char(char2nr('0') + i))
    endfor
    for i in range(26)
        call s:metacode(a:mode, nr2char(char2nr('a') + i))
        call s:metacode(a:mode, nr2char(char2nr('A') + i))
    endfor
    if a:mode != 0
        for c in [',', '.', '/', ';', '[', ']', '{', '}']
            call s:metacode(a:mode, c)
        endfor
        for c in ['?', ':', '-', '_']
            call s:metacode(a:mode, c)
        endfor
    else
        for c in [',', '.', '/', ';', '{', '}']
            call s:metacode(a:mode, c)
        endfor
        for c in ['?', ':', '-', '_']
            call s:metacode(a:mode, c)
        endfor
    endif
  endfunc

  call Terminal_MetaMode(0)
endif

" cd pwd to current dir
nnoremap <silent> <leader>cd :cd %:p:h<CR>

noremap <silent> <leader><tab> <C-^>

" ie = inner entire buffer
onoremap ie :exec "normal! ggVG"<cr>
" iv = current viewable text in the buffer
onoremap iv :exec "normal! HVL"<cr>

" open a terminal window
if has('nvim')
  map <Leader>tt <C-W>s :term<CR>
  map <Leader>tv <C-W>v :term<CR>
  tnoremap <C-W><Esc> <C-\><C-N>
else
  map <Leader>tt :below :term<CR>
  map <Leader>tv :belowright :vert :term<CR>
  tnoremap <C-W><Esc> <C-W>N
endif

" move line upforward/downward
nnoremap [e :<c-u>move .-2<CR>==
nnoremap ]e :<c-u>move .+1<CR>==
vnoremap [e :move '<-2<CR>gv=gv
vnoremap ]e :move '>+1<CR>gv=gv
nnoremap <M-k> :<c-u>move .-2<CR>==
nnoremap <M-j> :<c-u>move .+1<CR>==
inoremap <M-k> <Esc>:move .-2<CR>==gi
inoremap <M-j> <Esc>:move .+1<CR>==gi
vnoremap <M-k> :move '<-2<CR>gv=gv
vnoremap <M-j> :move '>+1<CR>gv=gv
" move line leftward/rightward
vnoremap < <gv
vnoremap > >gv
nnoremap << <<_
nnoremap >> >>_
vnoremap <M-h> <gv
vnoremap <M-l> >gv
inoremap <M-h> <Esc><<_i
inoremap <M-l> <Esc>>>_i
nnoremap <M-h> <<_
nnoremap <M-l> >>_

" emacs shortcut
noremap <C-a> <Home>
noremap! <C-a> <Home>
noremap <C-e> <End>
noremap! <C-e> <End>
inoremap <C-a> <Home>
inoremap <C-e> <End>
inoremap <C-b> <Left>
inoremap <C-f> <Right>
" â is <Alt-B>
inoremap â <C-Left>
inoremap <M-b> <C-Left>
" æ is <Alt-F>
inoremap æ <C-Right>
inoremap <M-f> <C-Right>
" known bug: cannot remove first char at beginning of line
inoremap <C-k> <Esc>lDa
inoremap <C-u> <Esc>d0dli

noremap k gk
noremap gk k
noremap j gj
noremap gj j

" close window
nnoremap <silent> q <esc>:close<cr>
vnoremap <silent> q <esc>:close<cr>
" use Q to record macro instead of q
noremap Q q
noremap <C-j> <C-W>j
noremap <C-k> <C-W>k
noremap <C-h> <C-W>h
noremap <C-l> <C-W>l

" switch setting
nnoremap <F1> :Lexplore<CR>
inoremap <F1> <Esc>:Lexplore<CR>
nnoremap <F2> :set nu! nu?<CR>
nnoremap <F3> :set list! list?<CR>
nnoremap <F4> :set wrap! wrap?<CR>
" when in insert mode, press <F5> to go to
" paste mode, where you can paste mass data
" that won't be autoindented
nnoremap <F5> :set paste! paste?<CR>  
"au InsertLeave * set nopaste
nnoremap <F6> :exec exists('syntax_on') ? 'syn off' : 'syn on'<CR>

" remap U to <C-r> for easier redo
nnoremap U <C-r>
" y$ -> Y Make Y behave like other capitals
map Y y$

" Swap implementations of ` and ' jump to markers
" By default, ' jumps to the marked line, ` jumps to the marked line and
" column, so swap them
nnoremap ' `
nnoremap ` '

" switch # *
" nnoremap # *
" nnoremap * #

"Keep search pattern at the center of the screen."
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *zz
nnoremap <silent> # #zz
nnoremap <silent> g* g*zz

" remove highlight
noremap <silent><leader>/ :nohls<CR>

" in case you forgot to sudo
cnoremap w!! %!sudo tee > /dev/null %

let configs = ['/.vim/vimrc.bundles', '/.vim/vimrc.local']

for config in configs
  let path = $HOME.config
  if filereadable(path)
    exec "source " . path
  endif
endfor

