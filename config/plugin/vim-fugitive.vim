nmap <leader>g :Git<cr>gg)
nnoremap g<space> :Git<space>

augroup fugitive_vim
  autocmd!
  autocmd FileType fugitive call s:fugitive_init()
augroup END

function! s:fugitive_init() abort
  nnoremap <buffer> cmf<space> :Git merge -X theirs<space>
  nnoremap <buffer> cob<space> :Git checkout -b<space>
  nnoremap <buffer> cbd<space> :Git branch -d<space>
  nnoremap <buffer> cbD<space> :Git branch -D<space>
endfunction
