
" lsp
nnoremap gr <cmd>lua vim.lsp.buf.references()<CR>
nnoremap gi <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <space>D <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <space>rn <cmd>lua vim.lsp.buf.rename()<CR>
nnoremap gs <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap gS <cmd>lua vim.lsp.buf.workspace_symbol('')<CR>
nnoremap <space>wa <cmd>lua vim.lsp.buf.add_workspace_folder()<CR>
nnoremap <space>wr <cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>
nnoremap <space>wl <cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>
nnoremap [d <cmd>lua vim.diagnostic.goto_prev()<CR>
nnoremap ]d <cmd>lua vim.diagnostic.goto_next()<CR>
nnoremap <space>f <cmd>lua vim.lsp.buf.formatting()<CR>

nnoremap c d
xnoremap c d

nnoremap cc dd
nnoremap C D

" fzf
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-l> <plug>(fzf-complete-line)
if executable('rg')
  inoremap <expr> <c-x><c-f> fzf#vim#complete#path($FZF_DEFAULT_COMMAND)
  inoremap <expr> <c-x><c-l> fzf#vim#complete(fzf#wrap({
  \ 'prefix': '^.*$',
  \ 'source': 'rg -n ^ --color always',
  \ 'options': '--ansi --delimiter : --nth 3..',
  \ 'reducer': { lines -> join(split(lines[0], ':\zs')[2:], '') }}))
endif

function! FzfGrepMap(key, cmd)
  "nnoremap <silent> <leader>sp :Pg<Cr>
  execute 'nnoremap <leader>s' . a:key.' :' . a:cmd . '<CR>'

  "vnoremap <silent> <leader>sp :<C-u>execute ':Pg '.personal#functions#Selected()<CR>
  execute "vnoremap <silent> <leader>s" . a:key . " :<C-u>execute ':" . a:cmd . " '.personal#functions#Selected()<CR>"
endfunction

call FzfGrepMap('b', 'BLines')
call FzfGrepMap('p', 'Pg')
call FzfGrepMap('t', 'Tags')
call FzfGrepMap('g', 'Gems')

" Navigation
map  <expr> <F1> g:NERDTree.IsOpen() ? ":NERDTreeClose\<CR>" : ":NERDTreeMirror\<CR>:NERDTreeFind\<CR>"
map! <expr> <F1> g:NERDTree.IsOpen() ? "<Esc>:NERDTreeClose\<CR>" : "<Esc>:NERDTreeMirror\<CR>:NERDTreeFind\<CR>"

map  <silent> <F3> :TagbarToggle<CR>
map! <silent> <F3> :TagbarToggle<CR>

map <F4> :call ToggleStartify()<CR>
"
" `s{char}`
map f <Plug>(easymotion-bd-f)
nmap f <Plug>(easymotion-overwin-f)

" move to line
map  gl <Plug>(easymotion-bd-jk)
nmap gl <Plug>(easymotion-overwin-line)
