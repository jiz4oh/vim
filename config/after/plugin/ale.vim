function! s:extend_linters(map)
  for filetype in keys(a:map)
    call extend(a:map[filetype], get(g:ale_linters, '*', []), 'keep')
  endfor

  return a:map
endfunction

function! s:extend_fixers(map)
  for filetype in keys(a:map)
    call extend(a:map[filetype], get(g:ale_fixers, '*', []), 'keep')
  endfor

  return a:map
endfunction

augroup vimrc
  autocmd BufRead,BufNewFile */.github/*/*.y{,a}ml
      \ let b:ale_linters = {'yaml': ['actionlint']}

  autocmd BufRead,BufNewFile *.html.erb
      \ let b:ale_fixers = ['erblint', 'prettier-eslint']
augroup END
