nnoremap <c-w>c :call undoquit#SaveWindowQuitHistory()<cr><c-w>c

function s:quit()
  if tabpagenr('$') > 1 && (tabpagewinnr(tabpagenr(), '$') == 1)
    UndoableTabclose
  else
    confirm quit
  endif
endfunction

nnoremap <silent> q :call <SID>quit()<cr>
