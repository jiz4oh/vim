nnoremap g<space>   :Git<space>
nmap     <leader>gg :Git<cr>gg)
nmap     <leader>eg :Git<cr>gg)
nnoremap <leader>gd :Gdiffsplit<cr>
nnoremap <leader>gb :Git blame<cr>
vnoremap <leader>gb :Git blame<cr>
nnoremap <leader>gx :GBrowse<cr>
vnoremap <leader>gx :GBrowse<cr>
nnoremap <leader>gr :Gread<cr>
nnoremap <leader>gw :Gwrite<cr>

augroup fugitive_vim
  autocmd!
  autocmd FileType fugitive call s:fugitive_init()
augroup END

function! s:fugitive_init() abort
  let b:start    = ':Git push'
  nnoremap '<space> :Git push<space>
  " branch track
  nnoremap <buffer><silent> cbt :execute ':Git branch --set-upstream-to=origin/' . FugitiveHead()<cr>
  " merge force
  nnoremap <buffer> cmf :Git merge -X theirs<space>
  nnoremap <buffer> cob :Git checkout -b<space>
  nnoremap <buffer> cbd :Git branch -d<space>
  nnoremap <buffer> cbD :Git branch -D<space>
endfunction
