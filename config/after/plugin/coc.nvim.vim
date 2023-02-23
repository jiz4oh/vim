" Conflict with vim-rsi
inoremap <silent><expr> <C-e> coc#pum#visible() ? coc#pum#cancel() : col('.')>strlen(getline('.'))?"\<Lt>C-E>":"\<Lt>End>"
