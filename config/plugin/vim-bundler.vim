command! -nargs=? -bang Gem  call personal#functions#GemSearch(<q-args>, <bang>0)
command! -nargs=? -bang Gems call personal#functions#GemsSearch(<q-args>, <bang>0)

