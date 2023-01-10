let g:dbs = {
\ 'mysql': 'mysql://root@localhost/mysql',
\ 'mysql_sys': 'mysql://root@localhost/sys',
\ 'mysql_information_schema': 'mysql://root@localhost/information_schema',
\ 'reids_development': 'redis:0',
\ }

let g:db_ui_use_nerd_fonts = get(g:, 'enable_nerd_font', 0)
let g:db_ui_auto_execute_table_helpers = 1

nmap  <silent> <leader>ed :DBUIToggle<CR>

augroup dbui_zvim
  autocmd!
  autocmd FileType dbui call s:dbui_init()
augroup END

function! s:dbui_init() abort
  nnoremap <silent><buffer> h <Plug>(DBUI_GotoParentNode)<Plug>(DBUI_SelectLine)
  nnoremap <silent><buffer> l <Plug>(DBUI_GotoChildNode)
endfunction
