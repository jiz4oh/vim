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
  " fallback to the directory containing the file
  let l:dir = get(l:, 'dir', expand('%:p'))
  " or the user's home directory
  let l:dir = get(l:, 'dir', expand('~'))
  return l:dir
endfunction
