augroup ruby_aucmd
  autocmd!
  autocmd FileType ruby compiler ruby
  autocmd FileType eruby compiler eruby
augroup END

function! s:gem_content_search(gem, query, fullscreen)
  let l:gemdir = substitute(system("bundle show " . a:gem), '\n\+$', '', '')
  if has_key(g:, 'fzf_grep_cmd')
    let l:grep_cmd = printf(g:fzf_grep_cmd, shellescape(a:query))
  else
    let l:grep_cmd = 'find '. l:gemdir . ''
  endif
  call fzf#vim#grep(l:grep_cmd, 1, fzf#vim#with_preview({'dir': l:gemdir, 'options': ['--prompt', a:gem.'> ']}), a:fullscreen)
endfunction

" Gem search
function! s:gem_search(query, fullscreen)
  call fzf#vim#grep("budle list | sed '1d;$d' | cut -d ' ' -f 4", 0, {'sink': {gem -> s:gem_content_search(gem, a:query, a:fullscreen)}}, a:fullscreen)
endfunction

" Gems search
function! s:gems_search(query, fullscreen) abort
  let b:project = bundler#project()
  if !empty(b:project)
    if !has_key(b:, 'gem_paths')
      let b:gem_paths = []
      for [gem, path] in items(b:project.paths())
        call add(b:gem_paths, path)
      endfor
    endif

    if has_key(g:, 'fzf_grep_cmd')
      let l:query = empty(a:query) ? shellescape('') : '-w ' . shellescape(a:query)
      let l:grep_cmd = printf(g:fzf_grep_cmd, l:query . ' ' . join(b:gem_paths, ' '))
    else
      let l:grep_cmd = 'find '. join(b:gem_paths, ' ') . ' -type f'
    endif
    call fzf#vim#grep(l:grep_cmd, 1, fzf#vim#with_preview({'options': ['--prompt', 'Gems> ']}), a:fullscreen)
  endif
endfunction

command! -nargs=? -bang Gem  call s:gem_search(<q-args>, <bang>0)
command! -nargs=? -bang Gems call s:gems_search(<q-args>, <bang>0)
