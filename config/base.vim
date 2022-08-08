let g:is_darwin = has('mac')
let g:is_win = has('win32') || has('win64')

" leader
let mapleader      = ' '
let maplocalleader = ' '
let g:mapleader    = ' '

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
set autoread                    " reload files when changed on disk, i.e. via `git checkout`
set shortmess=atIF

set magic                       " For regular expressions turn magic on
set title                       " change the terminal's title
set hidden                      " donot hidden after disable terminal
set splitbelow                  " split a window one the below
set splitright                  " vsplit a window on the right
set exrc

if has('vim_starting') && exists('+undofile')
  set undofile
endif

if v:version >= 700
  set viminfo=!,'20,<50,s10,h
endif
if !empty($SUDO_USER) && $USER !=# $SUDO_USER
  set viminfo=
  set directory-=~/tmp
  set backupdir-=~/tmp
elseif exists('+undodir') && !has('nvim-0.5')
  if !empty($XDG_DATA_HOME)
    let s:data_home = substitute($XDG_DATA_HOME, '/$', '', '') . '/vim/'
  elseif g:is_win
    let s:data_home = expand('~/AppData/Local/vim/')
  else
    let s:data_home = expand('~/.local/share/vim/')
  endif
  let &undodir = s:data_home . 'undo//'
  let &directory = s:data_home . 'swap//'
  let &backupdir = s:data_home . 'backup//'
  if !isdirectory(&undodir) | call mkdir(&undodir, 'p') | endif
  if !isdirectory(&directory) | call mkdir(&directory, 'p') | endif
  if !isdirectory(&backupdir) | call mkdir(&backupdir, 'p') | endif
endif

set novisualbell                " turn off visual bell
set noerrorbells                " don't beep
set visualbell t_vb=            " turn off error beep/flash
set t_vb=
set t_RV=
set tm=500

set colorcolumn=80

" movement
" set scrolloff=7                 " keep 7 lines when scrolling

" show
set ruler                       " show the current row and column
set number                      " show line numbers
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
set shiftwidth=2                " auto indent use 2 spaces
set tabstop=2                   " insert mode tab use 2 spaces
set softtabstop=2               " insert mode <Tab> use 2 spaces

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

set wildmenu                           " show a navigable menu for tab completion"
set wildmode=longest,full
if has('patch-8.2.4325')
  set wildoptions=pum
endif
if v:version >= 900
  set wildoptions+=fuzzy
endif
" 文件搜索和补全时忽略下面的扩展名
set suffixes=.bak,~,.o,.h,.info,.swp,.obj,.pyc,.pyo,.egg-info,.class
"stuff to ignore when tab completing
set wildignore=*.o,*.obj,*~,*.exe,*.a,*.pdb,*.lib
set wildignore+=*.so,*.dll,*.swp,*.egg,*.jar,*.class,*.pyc,*.pyo,*.bin,*.dex
set wildignore+=tags,.*.un~
" MacOSX/Linux
set wildignore+=*.zip,*.7z,*.rar,*.gz,*.tar,*.gzip,*.bz2,*.tgz,*.xz
set wildignore+=*DS_Store*,*.ipch
set wildignore+=*.gem
set wildignore+=*.png,*.jpg,*.gif,*.bmp,*.tga,*.pcx,*.ppm,*.img,*.iso
set wildignore+=*.so,*.swp,*.zip,*/.Trash/**,*.pdf,*.dmg
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
set sessionoptions-=buffers sessionoptions-=curdir sessionoptions+=sesdir,globals
if !g:is_win
  set dictionary+=/usr/share/dict/words
endif

" make faster
set ttyfast
" https://github.com/vim/vim/issues/1735#issuecomment-383353563
set synmaxcol=200
if v:version < 800 && &term =~ "xterm.*"
    let &t_ti = &t_ti . "\e[?2004h"
    let &t_te = "\e[?2004l" . &t_te
    function! XTermPasteBegin(ret)
        set pastetoggle=<Esc>[201~
        set paste
        return a:ret
    endfunction
    map <expr> <Esc>[200~ XTermPasteBegin("i")
    imap <expr> <Esc>[200~ XTermPasteBegin("")
    vmap <expr> <Esc>[200~ XTermPasteBegin("c")
    cmap <Esc>[200~ <nop>
    cmap <Esc>[201~ <nop>
endif

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

" cursor style
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_SR = "\<Esc>]50;CursorShape=2\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"

" status line
set laststatus=2                       "  Always show the status line - use 2 lines for the status bar
" tabline
set showtabline=2
" ================================= autocmd ===================================
augroup vimrc
  autocmd!
  " Exit Vim if quickfix is the only window remaining in the only tab.
  autocmd WinEnter * if winnr('$') == 1 && &buftype == "quickfix"|q|endif
   "Close preview window
  if exists('##CompleteDone')
    autocmd CompleteDone * pclose
  else
    autocmd InsertLeave * if !pumvisible() && (!exists('*getcmdwintype') || empty(getcmdwintype())) | pclose | endif
  endif

   "Automatic rename of tmux window
  if exists('$TMUX') && !exists('$NORENAME')
    autocmd BufEnter * if empty(&buftype) | call system('tmux rename-window '.expand('%:t:S')) | endif
    autocmd VimLeave * call system('tmux set-window automatic-rename on')
  endif

  "return where you left last time
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif | normal! zvzz

  "remove extra white spaces
  autocmd BufWritePre * :%s/\s\+$//e

  autocmd VimEnter * nested
      \ if !argc() && empty(v:this_session) && filereadable('Session.vim') && !&modified |
      \   source Session.vim |
      \ endif

  "set relative number
  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif

  autocmd BufNewFile,BufRead *.icc                           set filetype=cpp
  autocmd BufNewFile,BufRead *.pde                           set filetype=java
  autocmd BufNewFile,BufRead *.coffee-processing             set filetype=coffee
  autocmd BufNewFile,BufRead Dockerfile*                     set filetype=dockerfile
  " autocmd BufNewFile,BufRead *.md,*.mkd,*.markdown           set filetype=markdown.mkd
  autocmd FileType ruby setlocal regexpengine=1
  autocmd FileType ruby setlocal iskeyword+=!,?
  autocmd FileType ruby compiler ruby
  autocmd FileType eruby compiler eruby

  autocmd FileType coffee,javascript setlocal iskeyword+=$
  " set '-' to be part of a word when dealing with CSS classes and IDs.
  autocmd BufReadPost,BufNewFile *.{html,svg,xml,css,scss,less,stylus,js,coffee,erb,jade,blade} setlocal iskeyword+=-
  autocmd BufReadPost,BufNewFile *.json setlocal iskeyword+=-

  autocmd FileType python setlocal tabstop=4 shiftwidth=4 expandtab ai
  autocmd Filetype gitcommit setlocal spell textwidth=72
augroup END

" ============================ key map ============================
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

noremap <C-a> <Home>
noremap <C-e> <End>

" close window
nnoremap <silent> q :close<cr>
" use Q to record macro instead of q
noremap Q q
noremap <C-j> <C-W>j
noremap <C-k> <C-W>k
noremap <C-h> <C-W>h
noremap <C-l> <C-W>l

" save
inoremap <C-s>     <C-O>:update<cr>
nnoremap <C-s>     :update<cr>
nnoremap <leader>s :update<cr>

" Tags
nnoremap <C-]> g<C-]>

" switch setting
map  <special> <F2> :Lexplore<CR>
map! <special> <F2> <esc>:<c-u>Lexplore<CR>

" remap U to <C-r> for easier redo
nnoremap U <C-r>
" y$ -> Y Make Y behave like other capitals
map Y y$

" Swap implementations of ` and ' jump to markers
" By default, ' jumps to the marked line, ` jumps to the marked line and
" column, so swap them
nnoremap ' `
nnoremap ` '

"Keep search pattern at the center of the screen."
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *zz
nnoremap <silent> # #zz
nnoremap <silent> g* g*zz

" remove highlight
noremap <silent><leader>/ :nohls<CR>

" change cwd
noremap <silent>cd. :lcd %:p:h<CR>:echo 'cwd: ' . getcwd()<CR>
" set current directory as project root by default
noremap <silent>cdp :lcd %:p:h<CR>:echo 'cwd: ' . getcwd()<CR>

function! QFOpen()
  if exists(':Copen')
    bot Copen!
  end
  bot copen
endfunction

nnoremap <silent> <leader>eq :call QFOpen()<CR>

inoremap <C-k> <C-o>D
if !exists("g:plugs") || !has_key(g:plugs, 'vim-rsi')
  inoremap        <C-A> <Home>
  inoremap   <C-X><C-A> <C-A>
  cnoremap        <C-A> <Home>
  cnoremap   <C-X><C-A> <C-A>

  inoremap <expr> <C-B> getline('.')=~'^\s*$'&&col('.')>strlen(getline('.'))?"0\<Lt>C-D>\<Lt>Esc>kJs":"\<Lt>Left>"
  cnoremap        <C-B> <Left>

  inoremap <expr> <C-D> col('.')>strlen(getline('.'))?"\<Lt>C-D>":"\<Lt>Del>"
  cnoremap <expr> <C-D> getcmdpos()>strlen(getcmdline())?"\<Lt>C-D>":"\<Lt>Del>"

  inoremap <expr> <C-E> col('.')>strlen(getline('.'))<bar><bar>pumvisible()?"\<Lt>C-E>":"\<Lt>End>"

  inoremap <expr> <C-F> col('.')>strlen(getline('.'))?"\<Lt>C-F>":"\<Lt>Right>"
  cnoremap <expr> <C-F> getcmdpos()>strlen(getcmdline())?&cedit:"\<Lt>Right>"
end

" netrw
" https://vonheikemen.github.io/devlog/tools/using-netrw-vim-builtin-file-explorer/
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
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

" stole from https://github.com/junegunn/dotfiles/blob/master/vimrc
function! s:colors(...)
  return filter(map(filter(split(globpath(&rtp, 'colors/*.vim'), "\n"),
        \                  'v:val !~ "^/usr/"'),
        \           'fnamemodify(v:val, ":t:r")'),
        \       '!a:0 || stridx(v:val, a:1) >= 0')
endfunction

function! s:rotate_colors()
  if !exists('s:colors')
    let s:colors = s:colors()
  endif
  let name = remove(s:colors, 0)
  call add(s:colors, name)
  execute 'colorscheme' name
  redraw
  echo name
endfunction

nnoremap <silent> <F10> :call <SID>rotate_colors()<cr>
