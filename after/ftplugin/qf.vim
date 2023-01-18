" save current location/quickfix list and associate it with a given name or the
" last used name
command! -buffer -nargs=? -complete=customlist,qf#namedlist#CompleteList SaveList    call qf#namedlist#SaveList(0, <q-args>)
" like SaveList, but add to a potentially existing named list
command! -buffer -nargs=? -complete=customlist,qf#namedlist#CompleteList SaveListAdd call qf#namedlist#SaveList(1, <q-args>)

" replace location/quickfix list with named lists
command! -buffer -nargs=+ -complete=customlist,qf#namedlist#CompleteList LoadList    call qf#namedlist#LoadList(0, <q-args>)
" like LoadList but append instead of replace
command! -buffer -nargs=+ -complete=customlist,qf#namedlist#CompleteList LoadListAdd call qf#namedlist#LoadList(1, <q-args>)

" list currently saved lists
command! -buffer ListLists call qf#namedlist#ListLists()
" remove given lists or all
command! -buffer -nargs=* -bang -complete=customlist,qf#namedlist#CompleteList RemoveList call qf#namedlist#RemoveList(expand("<bang>") == "!" ? 1 : 0, <q-args>)
