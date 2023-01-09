" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" In normal mode, press bar (|) to select table and align it

augroup vim-easy-align-group
  autocmd!

  autocmd FileType markdown nnoremap <buffer> <Bar> vip:EasyAlign*<Bar><Enter>
augroup END
