vnoremap <silent> // :<C-u>execute '/'.personal#functions#Selected()<CR>
vnoremap <silent> ?? :<C-u>execute '?'.personal#functions#Selected()<CR>
" Navigation
map  <expr> <leader>e g:NERDTree.IsOpen() ? ":NERDTreeClose\<CR>" : ":NERDTreeMirror\<CR>:NERDTreeFind\<CR>"
map  <F1> :NERDTreeToggle<CR>
map! <F1> :NERDTreeToggle<CR>

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
