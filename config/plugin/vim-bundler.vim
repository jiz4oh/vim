function! s:gem_content_search(gem, query, fullscreen) abort
  " let l:gemdir = substitute(system("bundle show " . a:gem), '\n\+$', '', '')
  let l:gemdir = bundler#project().paths()[a:gem]
  if has_key(g:, 'fzf_grep_cmd')
    let l:grep_cmd = printf(g:fzf_grep_cmd, '--color=always '. shellescape(a:query))
  else
    let l:grep_cmd = 'find '. l:gemdir . ''
  endif
  call fzf#vim#grep(l:grep_cmd, 1, fzf#vim#with_preview({'dir': l:gemdir, 'options': ['--prompt', a:gem.'> ']}), a:fullscreen)
endfunction

" Gem search
function! s:gem_search(query, fullscreen) abort
  if empty(bundler#project())
    echo 'not in a ruby project'
    return
  endif
  " call fzf#vim#grep("bundle list | sed '1d;$d' | cut -d ' ' -f 4", 0, {'sink': {gem -> s:gem_content_search(gem, a:query, a:fullscreen)}}, a:fullscreen)
  " let l:gems = "echo " . shellescape(join(keys(bundler#project().paths()), ' ')) . "|awk '{for(i=1;i<=NF;++i) print $i}'"
  " call fzf#vim#grep(l:gems, 0, {'sink': {gem -> s:gem_content_search(gem, a:query, a:fullscreen)}}, a:fullscreen)
  let l:gems = keys(bundler#project().paths())

  try
    let action = get(g:, 'fzf_action')
    let g:fzf_action = {
      \ 'enter':  {gem -> s:gem_content_search(gem[0], a:query, a:fullscreen)},
      \ 'ctrl-l':  {_ -> s:gems_search(a:query, a:fullscreen) },
      \}
    let l:spec = {
                  \'options': [
                    \'--prompt', 'Gem> ',
                  \],
                  \'source': l:gems,
                  \}

    call fzf#run(fzf#wrap(l:spec, a:fullscreen))
  finally
    if exists('action') && action != 0
      let g:fzf_action = action
    else
      unlet! g:fzf_action
    endif
  endtry
endfunction

" Gems search
function! s:gems_search(query, fullscreen) abort
  if empty(bundler#project())
    echo 'not in a ruby project'
    return
  endif
  let l:project = bundler#project()
  let l:gem_paths = values(bundler#project().paths())

  if has_key(g:, 'fzf_grep_cmd')
    let l:query = empty(a:query) ? shellescape('') : '-w ' . shellescape(a:query)
    let l:grep_cmd = printf(g:fzf_grep_cmd, '--color=always '.l:query . ' ' . join(l:gem_paths, ' '))
  else
    let l:grep_cmd = 'find '. join(l:gem_paths, ' ') . ' -type f'
  endif

  try
    let action = get(g:, 'fzf_action')
    let g:fzf_action = extend({
      \ 'ctrl-l':  {_ -> s:gem_search(a:query, a:fullscreen) },
      \}, get(g:, 'fzf_action', g:fzf_default_action), 'keep'
      \)
    let l:dir = getcwd()
    let l:spec = {
                  \'dir': l:dir,
                  \'options': [
                    \'--ansi', 
                    \'--prompt', 'Gems> ',
                    \'--multi', '--bind', 'alt-a:select-all,alt-d:deselect-all',
                    \'--delimiter', ':', '--preview-window', '+{2}-/2'
                  \]}

    try
      let prev_default_command = $FZF_DEFAULT_COMMAND
      let $FZF_DEFAULT_COMMAND = l:grep_cmd
      call fzf#run(fzf#wrap(fzf#vim#with_preview(l:spec), a:fullscreen))
    finally
      let $FZF_DEFAULT_COMMAND = prev_default_command
    endtry
  finally
    if exists('action') && action != 0
      let g:fzf_action = action
    else
      unlet! g:fzf_action
    endif
  endtry
endfunction

command! -nargs=? -bang Gem  call s:gem_search(<q-args>, <bang>0)
command! -nargs=? -bang Gems call s:gems_search(<q-args>, <bang>0)

if exists('*FzfGrepMap')
  call FzfGrepMap('<leader>sg', 'Gems')
endif
