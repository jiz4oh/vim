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
  autocmd FileType ruby if filereadable(expand(personal#project#find_home() . "/.rubocop.yml")) |
        \   let b:ale_linters = s:extend_linters({ 'ruby': ['rubocop'] }) |
        \   let b:ale_fixers = s:extend_fixers({ 'ruby': ['rubocop'] }) |
        \ elseif executable('standardrb') |
        \   let b:ale_linters = s:extend_linters({ 'ruby': ['standardrb'] }) |
        \   let b:ale_fixers = s:extend_fixers({ 'ruby': ['standardrb'] }) |
        \ else |
        \   let b:ale_linters = s:extend_linters({ 'ruby': ['rubocop'] }) |
        \   let b:ale_fixers = s:extend_fixers({ 'ruby': ['rubocop'] }) |
        \ endif
augroup END
