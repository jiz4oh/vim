let s:darwin = has('mac')
let s:windows = has('win32') || has('win64')

" leader
let mapleader      = ' '
let maplocalleader = ' '
let g:mapleader = ' '

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
set autochdir
set nocompatible                " don't bother with vi compatibility
set autoread                    " reload files when changed on disk, i.e. via `git checkout`
set shortmess=atI

set magic                       " For regular expressions turn magic on
set title                       " change the terminal's title

if !isdirectory($HOME.'/.vim/files') && exists('*mkdir')
  call mkdir($HOME.'/.vim/files')
endif

" backupfiles
set nobackup
set nowritebackup
set backupdir   =$HOME/.vim/files/backup/
set backupext   =-vimbackup
set backupskip  =
" swapfiles
set noswapfile
set directory   =$HOME/.vim/files/swap/
set updatecount =100
" undofiles
set undofile
set undodir     =$HOME/.vim/files/undo/

set novisualbell                " turn off visual bell
set noerrorbells                " don't beep
set visualbell t_vb=            " turn off error beep/flash
set t_vb=
set tm=500
"set t_ti= t_te=                " 退出vim时显示当前屏幕内容在终端

set cursorcolumn

set cursorline

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
set wildignore=*.o,*~,*.pyc,*.class

" others
set backspace=indent,eol,start         " make that backspace key work the way it should
set whichwrap+=<,>,h,l
set clipboard+=unnamed

" ============================ theme and status line ============================

colo desert
set background=dark
set t_Co=256                           " 指定配色方案是256色

" status line
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ %{strftime(\"%Y/%m/%d\ -\ %H:%M\")}
set laststatus=2                       "  Always show the status line - use 2 lines for the status bar

" set mark column color
hi! link SignColumn   LineNr
hi! link ShowMarksHLl DiffAdd
hi! link ShowMarksHLu DiffChange

" ================================= autocmd ===================================
augroup vimrc
  au BufWritePost vimrc,.vimrc nested if expand('%') !~ 'fugitive' | source % | endif
  au BufWritePost $MYVIMRC,$HOME/.vim/vimrc,$HOME/.vim/vimrc.bundles,$HOME/.vimrc.local source $MYVIMRC

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
  au BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe normal! g`\"" |
    \ endif                      
  endif
augroup END

" ============================ key map ============================

" cd pwd to current dir
nnoremap <silent> <leader>cd :cd %:p:h<CR>

noremap <silent> <leader><tab> <C-^>

" select all
map <Leader>sa ggVG"

" open a terminal window
map <Leader>t :below :term<CR>
map <Leader>vt :belowright :vert :term<CR>
tnoremap <C-W><Esc> <C-W>N

" switch to last command
cnoremap <C-u> <down>
cnoremap <C-d> <up>

" move up/down current line
nnoremap [e  :<c-u>execute 'move -1-'. v:count1<cr>
nnoremap ]e  :<c-u>execute 'move +'. v:count1<cr>

" move
map <C-a> <Home>
map <C-e> <End>
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

nnoremap k gk
nnoremap gk k
nnoremap j gj
nnoremap gj j

" switch setting
nnoremap <F2> :set nu! nu?<CR>
nnoremap <F3> :set list! list?<CR>
nnoremap <F4> :set wrap! wrap?<CR>
set pastetoggle=<F5>            "    when in insert mode, press <F5> to go to
                                "    paste mode, where you can paste mass data
                                "    that won't be autoindented
"au InsertLeave * set nopaste
nnoremap <F6> :exec exists('syntax_on') ? 'syn off' : 'syn on'<CR>

" Quickly close the current window
" nnoremap <leader>q :q<CR>
" Quickly save the current file
" nnoremap <leader>w :w<CR>

" remap U to <C-r> for easier redo
nnoremap U <C-r>

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

" Shift+H goto head of the line, Shift+L goto end of the line
nnoremap H <Home>
nnoremap L <End>

" command mode, ctrl-a to head， ctrl-e to tail
cnoremap <C-a> <Home>
cnoremap <C-e> <End>

" in case you forgot to sudo
cnoremap w!! %!sudo tee > /dev/null %

" show location

"Reselect visual block after indent/outdent
vnoremap < <gv
vnoremap > >gv

" y$ -> Y Make Y behave like other capitals
map Y y$

