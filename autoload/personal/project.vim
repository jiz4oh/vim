" returns nearest parent directory contains one of the markers
function! personal#project#find_root()
  if exists('*projectionist#path')
    let l:dir = get(l:, 'dir', projectionist#path())
  endif
  if exists('*FindRootDirectory')
    let l:dir = get(l:, 'dir', FindRootDirectory())
  endif
  return l:dir
endfunction

" returns nearest parent directory contains one of the markers
function! personal#project#find_home()
  let l:dir = personal#project#find_root()
  return empty(l:dir) ? getcwd() : l:dir
endfunction
