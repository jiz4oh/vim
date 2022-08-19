" ============================================================================
" KEY MAP {{{
" ============================================================================
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
xnoremap <silent> <C-k> :move-2<cr>gv
xnoremap <silent> <C-j> :move'>+<cr>gv
" move line leftward/rightward
xnoremap < <gv
xnoremap > >gv
nnoremap << <<_
nnoremap >> >>_
xnoremap <silent> <C-h> <gv
xnoremap <silent> <C-l> >gv

noremap <C-a> <Home>
noremap <C-e> <End>

" close window
nnoremap <silent> q :close<cr>
" use Q to record macro instead of q
noremap Q q
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-h> <C-W>h
nnoremap <C-l> <C-W>l

" save
inoremap <C-s>     <C-O>:update<cr>
nnoremap <C-s>     :update<cr>
nnoremap <leader>s :update<cr>

" switch setting
map  <special> <F2> :Lexplore<CR>
map! <special> <F2> <esc>:<c-u>Lexplore<CR>

" " remap U to <C-r> for easier redo
" nnoremap U <C-r>
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

nnoremap <silent> <F12> :call personal#functions#rotate_colors()<cr>
inoremap <C-k> <C-o>D

" if !exists("g:plugs") || !has_key(g:plugs, 'vim-rsi')
"   inoremap        <C-A> <Home>
"   inoremap   <C-X><C-A> <C-A>
"   cnoremap        <C-A> <Home>
"   cnoremap   <C-X><C-A> <C-A>

"   inoremap <expr> <C-B> getline('.')=~'^\s*$'&&col('.')>strlen(getline('.'))?"0\<Lt>C-D>\<Lt>Esc>kJs":"\<Lt>Left>"
"   cnoremap        <C-B> <Left>

"   inoremap <expr> <C-D> col('.')>strlen(getline('.'))?"\<Lt>C-D>":"\<Lt>Del>"
"   cnoremap <expr> <C-D> getcmdpos()>strlen(getcmdline())?"\<Lt>C-D>":"\<Lt>Del>"

"   inoremap <expr> <C-E> col('.')>strlen(getline('.'))<bar><bar>pumvisible()?"\<Lt>C-E>":"\<Lt>End>"

"   inoremap <expr> <C-F> col('.')>strlen(getline('.'))?"\<Lt>C-F>":"\<Lt>Right>"
"   cnoremap <expr> <C-F> getcmdpos()>strlen(getcmdline())?&cedit:"\<Lt>Right>"
" end
" }}}