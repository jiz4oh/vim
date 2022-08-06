let g:db = "postgresql://postgres:@localhost/postgres"

xnoremap <expr> <Plug>(DBExe)     db#op_exec()
nnoremap <expr> <Plug>(DBExe)     db#op_exec()
nnoremap <expr> <Plug>(DBExeLine) db#op_exec() . '_'

xmap db  <Plug>(DBExe)
nmap db  <Plug>(DBExe)
omap db  <Plug>(DBExe)
nmap dbb <Plug>(DBExeLine)

