" ============================================================================
" KEY MAP {{{
" ============================================================================
" Determining the highlight group that the word under the cursor belongs to
nmap <silent> <F11>   :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<' . synIDattr(synID(line("."),col("."),0),"name") . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" " Prevent common mistake of pressing q: instead :q
" map q: :q

" visually select the text that was last edited/pasted (Vimcast#26).
noremap gV `[v`]

" expand %% to path of current buffer in command mode.
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

" open a terminal window
if has('nvim')
  nmap <Leader>tt <C-W>s<bar>:term<CR>i
  nmap <Leader>tv <C-W>v<bar>:term<CR>i
  tnoremap <C-W><Esc>     <C-\><C-N>
  tnoremap <C-D>          <C-\><C-N>:quit<CR>
  tnoremap <C-W>w         <C-\><C-N><bar><C-W>w
  tnoremap <C-W><C-W>     <C-\><C-N><bar><C-W>w
  tnoremap <expr> <C-W>" '<C-\><C-N>"'.nr2char(getchar()).'pi'
elseif has('terminal')
  nmap <Leader>tt :below :term<CR>
  nmap <Leader>tv :belowright :vert :term<CR>
  tnoremap <C-W><Esc> <C-W>N
endif

" https://vi.stackexchange.com/a/8535
command! Cnext try | cnext | catch | cfirst | catch | endtry
command! Cprev try | cprev | catch | clast | catch | endtry
nnoremap <silent> ]q :Cnext<cr>
nnoremap <silent> [q :Cprev<cr>

command! Lnext try | lnext | catch | lfirst | catch | endtry
command! Lprev try | lprev | catch | llast | catch | endtry
nnoremap <silent> ]l :Lnext<cr>
nnoremap <silent> [l :Lprev<cr>

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
nnoremap <silent> q :quit<cr>
" use Q to record macro instead of q
noremap Q q

nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-h> <C-W>h
nnoremap <C-l> <C-W>l
" fast window switching: ALT+SHIFT+HJKL
noremap <m-H> <c-w>h
noremap <m-L> <c-w>l
noremap <m-J> <c-w>j
noremap <m-K> <c-w>k
if has('nvim')
  tnoremap <m-H> <c-\><c-N><bar><c-w>h
  tnoremap <m-L> <c-\><c-N><bar><c-w>l
  tnoremap <m-J> <c-\><c-N><bar><c-w>j
  tnoremap <m-K> <c-\><c-N><bar><c-w>k
elseif has('terminal')
  tnoremap <m-H> <c-w>h
  tnoremap <m-L> <c-w>l
  tnoremap <m-J> <c-w>j
  tnoremap <m-K> <c-w>k
endif
inoremap <m-H> <esc><c-w>h
inoremap <m-L> <esc><c-w>l
inoremap <m-J> <esc><c-w>j
inoremap <m-K> <esc><c-w>k

" save
inoremap <C-s>     <C-O>:update<cr>
nnoremap <C-s>     :update<cr>

" switch setting
map  <special> <F2> :Lexplore<CR>
map! <special> <F2> <esc>:<c-u>Lexplore<CR>

" remap U to <C-r> for easier redo
nnoremap U <C-r>
" y$ -> Y Make Y behave like other capitals
map Y y$

" Better x
nnoremap x "_x

" Better s
nnoremap s "_s

" Substitute.
xnoremap s :s//g<Left><Left>

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
nnoremap <silent><leader>/ :nohls<CR>

" change cwd
if exists(':tcd')
  noremap <silent>       <leader>cd. :tcd %:p:h<CR>:echo 'cwd: ' . getcwd()<CR>
  noremap <expr><silent> <leader>cdp ':tcd ' . personal#project#find_home() . "<CR>:echo 'cwd: ' . getcwd()<CR>"
else
  noremap <silent>       <leader>cd. :cd %:p:h<CR>:echo 'cwd: ' . getcwd()<CR>
  noremap <expr><silent> <leader>cdp ':cd ' . personal#project#find_home() . "<CR>:echo 'cwd: ' . getcwd()<CR>"
end

function! QFOpen()
  if exists(':Copen')
    bot Copen!
  end
  bot copen
endfunction

" repeat last replacement operation
nnoremap g. /\V\C<C-r>"<CR>cgn<C-@>

nnoremap <silent> <leader>eq :call QFOpen()<CR>

nnoremap <silent> <F10> :call personal#functions#rotate_colors()<cr>
inoremap <C-k> <C-o>D

" Use Ctrl-Tab and Alt-Tab to switch tab
map    <C-Tab>  :tabnext<CR>
imap   <C-Tab>  <C-O>:tabnext<CR>
map    <M-Tab>  :tabprev<CR>
imap   <M-Tab>  <C-O>:tabprev<CR>

for s:i in range(1, 9)
  " <Leader>[1-9] move to tab [1-9]
  execute 'nnoremap <Leader>'.s:i s:i.'gt'

  " <Leader>w[1-9] move to window [1-9]
  execute 'nnoremap <Leader>w'.s:i ' :'.s:i.'wincmd w<CR>'

  " <Leader>b[1-9] move to buffer [1-9]
  execute 'nnoremap <Leader>b'.s:i ':b'.s:i.'<CR>'
endfor
unlet s:i

" insert mode fast
inoremap <c-x>( ()<esc>i
inoremap <c-x>[ []<esc>i
inoremap <c-x>' ''<esc>i
inoremap <c-x>" ""<esc>i
inoremap <c-x>< <><esc>i
inoremap <c-x>{ {<esc>o}<esc>ko

inoremap <M-(> ()<esc>i
inoremap <M-[> []<esc>i
inoremap <M-'> ''<esc>i
inoremap <M-"> ""<esc>i
inoremap <M-<> <><esc>i
inoremap <M-{> {<esc>o}<esc>ko

" https://forum.obsidian.md/t/open-note-in-obsidian-from-within-vim-and-vice-versa/6837
" Open file in Obsidian vault
nnoremap <silent> <leader>io :execute "silent !open 'obsidian://open?vault=" . fnamemodify(g:notes_root, ':t') . "&file=index" . expand('%:r') . "'"<cr>

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
