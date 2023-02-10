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

if exists('*setbufline')
  let s:git_cmd = ':Git!'
else
  let s:git_cmd = ':Git'
end

function! s:fugitive_init() abort
  let b:start    = s:git_cmd . ' push'
  execute "nnoremap <buffer> '<space> " . s:git_cmd . ' push<space>'
  " branch track
  nnoremap <buffer><silent> cbt :execute ':Git branch --set-upstream-to=origin/' . FugitiveHead()<cr>
  " merge force
  nnoremap <buffer> cmf :Git merge -X theirs<space>
  nnoremap <buffer> cob :Git checkout -b<space>
  nnoremap <buffer> cbd :Git branch -d<space>
  nnoremap <buffer> cbD :Git branch -D<space>
endfunction
