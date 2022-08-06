let g:dbs = {
\ 'mysql_development': 'mysql://root@localhost/development',
\ 'reids_development': 'redis:0',
\ }

if g:is_darwin
  let g:db_ui_use_nerd_fonts = 1
endif

let g:db_ui_auto_execute_table_helpers = 1

map  <silent> <leader>ed :DBUIToggle<CR>

augroup dbui_zvim
  autocmd!
  autocmd FileType dbui call s:dbui_init()
augroup END

function! s:dbui_init() abort
  nnoremap <silent><buffer> h <Plug>(DBUI_GotoParentNode)<Plug>(DBUI_SelectLine)
  nnoremap <silent><buffer> l <Plug>(DBUI_GotoChildNode)
endfunction
