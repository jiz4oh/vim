function! s:init() abort
  if exists(':tcd')
    noremap <buffer> <silent>cdp :Ptcd<CR>:echo 'cwd: ' . getcwd()<CR>
  else
    noremap <buffer> <silent>cdp :Pcd<CR>:echo 'cwd: ' . getcwd()<CR>
  end
endfunction
