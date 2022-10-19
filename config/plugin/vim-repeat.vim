map <silent> <Plug>DecreaseWindowHeight :3wincmd -<bar>silent! call repeat#set("\<Plug>DecreaseWindowHeight", v:count)<cr>
map <silent> <Plug>IncreaseWindowHeight :3wincmd +<bar>silent! call repeat#set("\<Plug>IncreaseWindowHeight", v:count)<cr>
map <silent> <Plug>DecreaseWindowWidth  :10wincmd <<bar>silent! call repeat#set("\<Plug>DecreaseWindowWidth", v:count)<cr>
map <silent> <Plug>IncreaseWindowWidth  :10wincmd ><bar>silent! call repeat#set("\<Plug>IncreaseWindowWidth", v:count)<cr>

nmap <leader>- <Plug>DecreaseWindowHeight
nmap <leader>+ <Plug>IncreaseWindowHeight
nmap <leader>< <Plug>DecreaseWindowWidth
nmap <leader>> <Plug>IncreaseWindowWidth

