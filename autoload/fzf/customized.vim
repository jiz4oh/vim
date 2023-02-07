" `brew install ripgrep` before you use rg command
if !executable('rg')
  function! fzf#customized#grep(dir, query, fullscreen) abort
    if !empty(a:query)
      let @/ = a:query
    endif
    let l:query = empty(a:query) ? shellescape('') : '-w ' . shellescape(a:query)
    let l:grep_cmd = 'git grep --color=always --line-number ' . l:query . ' -- ' . a:dir

    call fzf#vim#grep(l:grep_cmd, 0, fzf#vim#with_preview({'dir': a:dir, 'options': ['--prompt', personal#functions#shortpath(a:dir) . ' ', '--delimiter', ':', '--nth', '3..']}), a:fullscreen)
  endfunction

  function! fzf#customized#rg(query, fullscreen)
    echohl WarningMsg
    echom 'ripgrep not found, please read https://github.com/BurntSushi/ripgrep#installation about how to install'
    echohl None
    return 0
  endfunction
else
  function! fzf#customized#grep(dir, query, fullscreen) abort
    if !empty(a:query)
      let @/ = a:query
    endif

    let l:dir = fnamemodify(a:dir, ':p:h')
    let l:spec = {
        \'dir': l:dir,
        \'options': [
            \'--prompt', personal#functions#shortpath(l:dir) .' ',
              \'--delimiter', ':',
            \]}

    if exists('*FzfWithWildignore')
      let l:query = empty(a:query) ? shellescape('') : '-w ' . shellescape(a:query)
      let l:grep_cmd = FzfWithWildignore(l:query)

      call add(l:spec['options'], '--nth')
      call add(l:spec['options'], '4..')
    else
      let l:grep_cmd = 'find '. l:dir . ''
    endif

    if !empty(a:query)
      call add(l:spec['options'], '--header')
      call add(l:spec['options'], a:query)
    endif

    call fzf#vim#grep(l:grep_cmd, 1, fzf#vim#with_preview(l:spec), a:fullscreen)
  endfunction

  function! fzf#customized#rg(query, fullscreen)
    if !empty(a:query)
      let @/ = a:query
    endif
    let l:grep_cmd = FzfWithWildignore(shellescape(a:query))
    let l:reload_command = FzfWithWildignore('{q}')
    let l:spec = {
          \'options': [
             \'--prompt', personal#functions#shortpath(getcwd()) .'> ',
             \'--phony',
             \'--query', a:query,
             \'--bind', 'change:reload:'.l:reload_command
             \]}

    call fzf#vim#grep(l:grep_cmd, 1, fzf#vim#with_preview(l:spec), a:fullscreen)
  endfunction
endif

function! fzf#customized#sessions(fullscreen) abort
  if !isdirectory(g:session_dir)
    call mkdir(fnamemodify(g:session_dir, ':p'), 'p')
  endif

  let l:paths = systemlist('ls ' . g:session_dir)

  try
    let action = get(g:, 'fzf_action')
    let g:fzf_action = {
      \ 'enter': {name -> LoadSessionFromFzf(name[0])},
      \}
    let l:spec = {
                  \'options': [
                    \'--prompt', 'Sessions> ',
                  \],
                  \'source': l:paths,
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

function! s:search_paths(query, fullscreen) abort
  if !empty(a:query)
    let @/ = a:query
  endif

  let l:slash = (g:is_win && !&shellslash) ? '\\' : '/'
  let l:paths = substitute(&path, ',', ' ', 'g')

  if exists('*FzfWithWildignore')
    let l:query = empty(a:query) ? shellescape('') : '-w ' . shellescape(a:query)
    let l:grep_cmd = FzfWithWildignore(l:query . ' ' . l:paths)
  else
    let l:grep_cmd = 'find '. l:paths . ' -type f'
  endif

  let container = {}
  function! container.func() closure
    let $FZF_DEFAULT_COMMAND = l:grep_cmd
    let actions = {
      \ 'ctrl-l':  {_ -> fzf#customized#path(a:query, a:fullscreen) },
      \ 'ctrl-t': 'tab split',
      \ 'ctrl-x': 'split',
      \ 'ctrl-v': 'vsplit'
      \}
    let l:dir = getcwd()
    let l:spec = {
                  \'dir': l:dir,
                  \'sink*': { lines -> fzf#helper#handler(lines, 1, actions) },
                  \'options': [
                    \'--expect', join(keys(actions), ','),
                    \'--ansi',
                    \'--prompt', personal#functions#shortpath(l:dir) .' ',
                    \'--multi', '--bind', 'alt-a:select-all,alt-d:deselect-all',
                    \'--delimiter', ':', '--preview-window', '+{2}-/2'
                  \]}

    if !empty(a:query)
      call add(l:spec['options'], '--header')
      call add(l:spec['options'], a:query)
    endif

    call fzf#run(fzf#wrap(fzf#vim#with_preview(l:spec), a:fullscreen))
  endfunction

  call fzf#helper#reserve_cmd(container.func)()
endfunction

function! fzf#customized#projects(query, fullscreen) abort
  let l:projects = get(g:, 'projects', [])

  let container = {}
  function! container.func() closure
    let g:fzf_action = {
      \ 'enter':  {dir -> fzf#customized#grep(fnamemodify(dir[0], ':p'), a:query, a:fullscreen) },
      \ 'ctrl-t': 'NERDTree ',
      \ 'ctrl-x': 'NERDTree ',
      \ 'ctrl-v': 'NERDTree '
      \}

    let l:dir = getcwd()
    let l:spec = {
                  \'dir': l:dir,
                  \'options': [
                    \'--prompt', personal#functions#shortpath(getcwd()) .' ',
                  \],
                  \'source': l:projects,
                  \}

    if !empty(a:query)
      call add(l:spec['options'], '--header')
      call add(l:spec['options'], a:query)
    endif

    call fzf#run(fzf#wrap(l:spec, a:fullscreen))
  endfunction

  call fzf#helper#reserve_action(container.func)()
endfunction

" pick up from 'path'
function! fzf#customized#path(query, fullscreen) abort
  let l:slash = (g:is_win && !&shellslash) ? '\\' : '/'
  let l:paths = map(split(&path, ','), {_, val -> fnamemodify(expand(val), ':~:.')})
  let l:paths = uniq(sort(sort(l:paths), {i1, i2 -> len(split(i1, l:slash)) - len(split(i2, l:slash))}))
  let l:paths = filter(l:paths, {_, v -> isdirectory(fnamemodify(v, ':p')) })

  let container = {}
  function! container.func() closure
    let g:fzf_action = {
      \ 'enter':  {dir -> fzf#customized#grep(fnamemodify(dir[0], ':p'), a:query, a:fullscreen) },
      \ 'ctrl-l':  {_ -> s:search_paths(a:query, a:fullscreen) },
      \ 'ctrl-t': 'NERDTree ',
      \ 'ctrl-x': 'NERDTree ',
      \ 'ctrl-v': 'NERDTree '
      \}

    let l:dir = getcwd()
    let l:spec = {
                  \'dir': l:dir,
                  \'options': [
                    \'--prompt', personal#functions#shortpath(getcwd()) .' ',
                  \],
                  \'source': l:paths,
                  \}

    if !empty(a:query)
      call add(l:spec['options'], '--header')
      call add(l:spec['options'], a:query)
    endif

    call fzf#run(fzf#wrap(l:spec, a:fullscreen))
  endfunction

  call fzf#helper#reserve_action(container.func)()
endfunction

function! fzf#customized#compilers()
  let compilers = split(globpath(&rtp, "compiler/*.vim"), "\n")
  if has('packages')
    let compilers += split(globpath(&packpath, "pack/*/opt/*/compiler/*.vim"), "\n")
  endif
  return fzf#run(fzf#wrap('compilers', {
  \ 'source':  fzf#vim#_uniq(map(compilers, "substitute(fnamemodify(v:val, ':t'), '\\..\\{-}$', '', '')")),
  \ 'sink':    'compiler ',
  \ 'options': '+m --prompt="Compilers> "'
  \}))
endfunction
