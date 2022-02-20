let s:darwin = has('mac')
let s:windows = has('win32') || has('win64')

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
set autochdir
set autoread                    " reload files when changed on disk, i.e. via `git checkout`
set shortmess=atIF

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

set cursorline
set colorcolumn=80

" movement
set scrolloff=7                 " keep 7 lines when scrolling

" show
set ruler                       " show the current row and column
set number                      " show line numbers
set relativenumber              " show relative number
augroup relative_numbser
    autocmd!
    autocmd InsertEnter * :set norelativenumber
    autocmd InsertLeave * :set relativenumber
augroup END
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
set sessionoptions+=globals

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
set lazyredraw
" ================================= autocmd ===================================
augroup set_file_type
  autocmd!
  autocmd BufNewFile,BufRead *.icc                           set filetype=cpp
  autocmd BufNewFile,BufRead *.pde                           set filetype=java
  autocmd BufNewFile,BufRead *.coffee-processing             set filetype=coffee
  autocmd BufNewFile,BufRead Dockerfile*                     set filetype=dockerfile
  " autocmd BufNewFile,BufRead *.md,*.mkd,*.markdown           set filetype=markdown.mkd
augroup END

augroup python_group
  autocmd!
  autocmd FileType python set tabstop=4 shiftwidth=4 expandtab ai
augroup END

augroup other_group
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
augroup END

" ============================ key map ============================
"make vim respond to alt key
"https://github.com/fgheng/vime/blob/master/plugin/alt.vim
if !has('nvim') || !has("gui_running")
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
map  <F1> :Lexplore<CR>
map! <F1> :Lexplore<CR>

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

map  <silent> <F2> :call QFToggle()<CR>
map! <silent> <F2> :call QFToggle()<CR>

function! QFToggle()
  if has_key(g:, 'qf_is_open') && g:qf_is_open
    let g:qf_is_open = 0
    cclose
  else
    let g:qf_is_open = 1
    copen
  endif
endfunction

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

let configs = ['/.vim/vimrc.bundles', '/.vim/vimrc.local']

for config in configs
  let path = $HOME.config
  if filereadable(path)
    exec "source " . path
  endif
endfor

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

if !exists("g:plugs") || !has_key(g:plugs, 'nerdtree')
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
endif

if !(exists("g:plugs") && has_key(g:plugs, 'vim-airline'))
  let s:disable_statusline =
    \ ['defx', 'denite', 'vista', 'tagbar', 'undotree', 'diff', 'peekaboo', 'sidemenu', 'qf', 'coc-explorer', 'startify', 'vim-plug']

  let s:stl = ''
  " repo name
  let s:stl .= "%#Directory#%{empty(GitRepoName()) ? '' : GitRepoName().'  '}"
  " brance name
  let s:stl .= "%#Statement#%{empty(GitBranchName()) ? '' : GitBranchName().'  '}"
  " file name
  let s:stl .= "%#Identifier#%{RelativePath()}%h%w%r "

  let s:stl .= "%="
  let s:stl .= "%#StatusLine# %{&filetype}"
  let s:stl .= "%#StatusLineNC# %{&fileencoding?&fileencoding:&encoding}[%{&fileformat}] "
  let s:stl .= "%#StatusLineNC#  %p%% ☰ %l:%v "

  let s:stl_nc = ""
  let s:stl_nc .= "%f%h%w%r"

  function! RelativePath() abort
    let l:repo_path = GitRepo()
    if empty(l:repo_path)
      return expand('%:p:~')
    else
      return substitute(expand('%:p'), l:repo_path . '/', '', '')
    endif
  endfunction

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
      autocmd WinLeave * call s:status_line_inactive()
      autocmd VimEnter,ColorScheme,FileType,WinEnter,BufWinEnter * call s:status_line_active()
      autocmd FileChangedShellPost,BufFilePost,BufNewFile,BufWritePost * redrawstatus

      autocmd FileChangedShellPost,BufFilePost,BufNewFile,BufWritePost * redrawstatus
  augroup END

  " set mark column color
  hi! link SignColumn   LineNr
  hi! link ShowMarksHLl DiffAdd
  hi! link ShowMarksHLu DiffChange
endif
