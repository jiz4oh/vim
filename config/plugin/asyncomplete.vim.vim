if !has('gui_running') 
  let g:asyncomplete_auto_popup = 0
endif
let g:asyncomplete_auto_completeopt = 0

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <TAB>
  \ pumvisible() ? "\<C-n>" :
  \ <SID>check_back_space() ? "\<TAB>" :
  \ asyncomplete#force_refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
" conflict with endwise
inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"

autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif
