vnoremap <silent> <leader>gl :Flog<cr>
nnoremap <silent> <leader>gl :Flog -path=%<cr>
nnoremap <silent> <leader>gL :Flog<cr>

augroup flog_vim
  autocmd!
  autocmd FileType floggraph call s:init()
augroup END

function! s:init() abort
  nnoremap <silent> <buffer> o :vertical Flogsplitcommit<cr>
endfunction
