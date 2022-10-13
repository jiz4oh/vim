" returns nearest parent directory contains one of the markers
function! personal#project#find_root()
  if exists('*projectionist#path')
    let l:dir = get(l:, 'dir', projectionist#path())
  endif
  if exists('*FindRootDirectory')
    let l:dir = get(l:, 'dir', FindRootDirectory())
  endif
  return get(l:, 'dir', '')
endfunction

" returns nearest parent directory contains one of the markers
function! personal#project#find_home()
  let dir = personal#project#find_root()
  " fallback to the directory containing the file
  if empty(dir)
    let dir = expand('%:h:p')
  endif
  " or the user's home directory
  if empty(dir)
    let dir = expand('~')
  endif
  return dir
endfunction
