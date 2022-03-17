" disable default mappings
let g:EasyMotion_do_mapping = 0
" turn on case-insensitive feature
let g:EasyMotion_smartcase  = 1
" `s{char}`
map f <Plug>(easymotion-bd-f)
nmap f <Plug>(easymotion-overwin-f)

" move to line
map  gl <Plug>(easymotion-bd-jk)
nmap gl <Plug>(easymotion-overwin-line)
