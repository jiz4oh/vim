" Conflict with vim-rsi
inoremap <silent><expr> <C-e> coc#pum#visible() ? coc#pum#cancel() : col('.')>strlen(getline('.'))?"\<Lt>C-E>":"\<Lt>End>"
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <M-j> coc#float#has_scroll() ? coc#float#scroll(1) : "\<M-j>"
  nnoremap <silent><nowait><expr> <M-k> coc#float#has_scroll() ? coc#float#scroll(0) : "\<M-k>"
  inoremap <silent><nowait><expr> <M-j> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<M-j>"
  inoremap <silent><nowait><expr> <M-k> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<M-k>"
  vnoremap <silent><nowait><expr> <M-j> coc#float#has_scroll() ? coc#float#scroll(1) : "\<M-j>"
  vnoremap <silent><nowait><expr> <M-k> coc#float#has_scroll() ? coc#float#scroll(0) : "\<M-k>"
endif
