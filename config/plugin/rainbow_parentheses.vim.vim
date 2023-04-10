augroup rainbow_parentheses_augroup
  autocmd!
  autocmd FileType lisp,clojure,scheme RainbowParentheses
augroup END

map <silent> <special> <F3> :RainbowParentheses!!<CR>
