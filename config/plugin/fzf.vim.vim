augroup update_bat_theme
    autocmd!
    autocmd colorscheme * if &background == 'dark' | let $BAT_THEME='OneHalfDark' | else | let $BAT_THEME='' | endif
augroup end

" stole from fzf https://github.com/junegunn/fzf/blob/b5efc68737e8231001d2a18234c18aa3f658a973/plugin/fzf.vim#L302
function! FzfPathSink(action, lines) abort
  if len(a:lines) < 2
    return
  endif
  let key = remove(a:lines, 0)
  let Cmd = get(a:action, key, 'e')
  if type(Cmd) == type(function('call'))
    return Cmd(a:lines)
  endif
  try
    let empty = empty(expand('%', 1)) && line('$') == 1 && empty(getline(1)) && !&modified
    " Preserve the current working directory in case it's changed during
    " the execution (e.g. `set autochdir` or `autocmd BufEnter * lcd ...`)
    let cwd = exists('w:fzf_pushd') ? w:fzf_pushd.dir : expand('%:p:h')
    for item in a:lines
      if item[0] != '~' && item !~ (g:is_win ? '^[A-Z]:\' : '^/')
        let sep = g:is_win ? '\' : '/'
        let item = join([cwd, item], cwd[len(cwd)-1] == sep ? '' : sep)
      endif
      if empty
        execute 'e' personal#functions#escape(item)
        let empty = 0
      else
        execute Cmd personal#functions#escape(item)
      endif
      if !has('patch-8.0.0177') && !has('nvim-0.2') && exists('#BufEnter')
            \ && isdirectory(item)
        doautocmd BufEnter
      endif
    endfor
  catch /^Vim:Interrupt$/
  endtry
endfunction

function! s:grep_in(dir, query, fullscreen) abort
  if !isdirectory(a:dir)
    echomsg a:dir . ' is not a directory or is not exists'
    return
  endif

  if !empty(a:query)
    let @/ = a:query
  endif

  let l:dir = a:dir
  let l:query = empty(a:query) ? shellescape('') : '-w ' . shellescape(a:query)

  if has_key(g:, 'fzf_grep_cmd')
    let l:grep_cmd = printf(g:fzf_grep_cmd, l:query)
  else
    let l:grep_cmd = 'find '. l:dir . ''
  endif

  let l:spec = {
      \'dir': l:dir,
      \'options': [
          \'--prompt', personal#functions#shortpath(l:dir) .'> ',
            \'--delimiter', ':',
            \'--nth', '4..',
          \]}

  call fzf#vim#grep(l:grep_cmd, 1, fzf#vim#with_preview(l:spec), a:fullscreen)
endfunction

" `brew install ripgrep` before you use rg command
if !executable('rg')
  function! s:git_grep(query, dir, fullscreen)
    if !empty(a:query)
      let @/ = a:query
    endif
    let l:query = empty(a:query) ? shellescape('') : '-w ' . shellescape(a:query)
    let l:grep_cmd = 'git grep --color=always --line-number ' . l:query . ' -- ' . a:dir

    call fzf#vim#grep(l:grep_cmd, 0, fzf#vim#with_preview({'dir': a:dir, 'options': ['--prompt', personal#functions#shortpath(a:dir) . '> ', '--delimiter', ':', '--nth', '3..']}), a:fullscreen)
  endfunction

  function! Rg(query, fullscreen)
    echohl WarningMsg
    echom 'ripgrep not found, please read https://github.com/BurntSushi/ripgrep#installation about how to install'
    echohl None
    return 0
  endfunction

  function! s:project_grep(query, fullscreen)
    let l:dir = exists('*FindRootDirectory') ? FindRootDirectory() : ''
    let l:dir = empty(l:dir) ? personal#git#Repo() : l:dir

    call s:git_grep(a:query, l:dir, a:fullscreen)
  endfunction

  function! s:workdir_grep(query, fullscreen)
    let l:dir = getcwd()

    call s:git_grep(a:query, l:dir, a:fullscreen)
  endfunction
else
  set grepprg=rg\ --vimgrep\ --smart-case\ --follow
  set grepformat=%f:%l:%c:%m
  let $FZF_DEFAULT_COMMAND='rg --files --hidden -g "!{.git}/*" 2>/dev/null'
  let g:fzf_grep_cmd = 'rg --column --line-number --no-heading --smart-case --follow --color=always %s || true'

  function! s:git_grep(query, dir, fullscreen)
    if !empty(a:query)
      let @/ = a:query
    endif
    let l:query = empty(a:query) ? shellescape('') : '-w ' . shellescape(a:query)
    let l:grep_cmd = printf(g:fzf_grep_cmd, l:query)
    let l:spec = {
          \'dir': a:dir,
          \'options': [
             \'--prompt', personal#functions#shortpath(a:dir) .'> ',
             \'--delimiter', ':',
             \'--nth', '4..'
             \]}

    call fzf#vim#grep(l:grep_cmd, 1, fzf#vim#with_preview(l:spec), a:fullscreen)
  endfunction

  function! s:project_grep(query, fullscreen)
    let l:dir = exists('*FindRootDirectory') ? FindRootDirectory() : ''
    let l:dir = empty(l:dir) ? getcwd() : l:dir
    call s:grep_in(l:dir, a:query, a:fullscreen)
  endfunction

  function! s:workdir_grep(query, fullscreen)
    let l:dir = getcwd()
    call s:grep_in(l:dir, a:query, a:fullscreen)
  endfunction

  function! RipgrepFzf(query, fullscreen)
    if !empty(a:query)
      let @/ = a:query
    endif
    let l:grep_cmd = printf(g:fzf_grep_cmd, shellescape(a:query))
    let l:reload_command = printf(g:fzf_grep_cmd, '{q}')
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

function! Find(query, fullscreen) abort
  if !empty(a:query)
    let @/ = a:query
  endif

  let l:slash = (g:is_win && !&shellslash) ? '\\' : '/'
  let l:paths = substitute(&path, '[/\\]*$', l:slash, 'g')
  let l:paths = substitute(&path, ',', ' ', 'g')

  if has_key(g:, 'fzf_grep_cmd')
    let l:query = empty(a:query) ? shellescape('') : '-w ' . shellescape(a:query)
    let l:grep_cmd = printf(g:fzf_grep_cmd, l:query . ' ' . l:paths)
  else
    let l:grep_cmd = 'find '. l:paths . ' -type f'
  endif
  let l:spec = {
        \'options': [
            \'--prompt', personal#functions#shortpath(getcwd()) .'> ',
            \]}

  call fzf#vim#grep(l:grep_cmd, 1, fzf#vim#with_preview(l:spec), a:fullscreen)
endfunction

function! s:sessions(fullscreen) abort
  if !isdirectory(g:session_dir)
    call mkdir(fnamemodify(g:session_dir, ':p'), 'p')
  endif

  let l:paths = systemlist('ls ' . g:session_dir)

  let l:fzf_action = {
    \ 'enter': {name -> LoadSessionFromFzf(name[0])},
    \}

  let l:spec = {
                \'options': [
                  \'--prompt', 'Sessions> ',
                  \'--expect', join(keys(l:fzf_action), ','),
                \],
                \'source': l:paths,
                \'sink*': {lines -> FzfPathSink(l:fzf_action, lines) }
                \}

  call fzf#run(fzf#wrap(l:spec, a:fullscreen))
endfunction

function! s:search_path(query, fullscreen) abort
  let l:slash = (g:is_win && !&shellslash) ? '\\' : '/'
  let l:paths = substitute(&path, '[/\\]*$', l:slash, 'g')
  let l:paths = map(split(&path, ','), {_, val -> fnamemodify(val, ':.:~')})
  let l:paths = uniq(sort(sort(l:paths), {i1, i2 -> len(split(i1, l:slash)) - len(split(i2, l:slash))}))
  let l:paths = filter(l:paths, {_, v -> isdirectory(fnamemodify(v, ':p')) })

  let l:fzf_action = {
    \ 'enter':  {dir -> s:grep_in(fnamemodify(dir[0], ':p'), a:query, a:fullscreen) },
    \ 'ctrl-t': 'NERDTree ',
    \ 'ctrl-x': 'NERDTree ',
    \ 'ctrl-v': 'NERDTree '
    \}

  let l:spec = {
                \'options': [
                  \'--prompt', 'Path> ',
                  \'--expect', join(keys(l:fzf_action), ','),
                \],
                \'source': l:paths,
                \'sink*': {lines -> FzfPathSink(l:fzf_action, lines) }
                \}

  call fzf#run(fzf#wrap(l:spec, a:fullscreen))
endfunction

command! -nargs=? -bang Find      call Find(<q-args>, <bang>0)
command! -nargs=? -bang Sp        call s:search_path(<q-args>, <bang>0)
command! -nargs=? -bang Sessions  call s:sessions(<bang>0)

command! -nargs=? -bang RG        call RipgrepFzf(<q-args>, <bang>0)
command! -nargs=? -bang Pg        call s:project_grep(<q-args>, <bang>0)
command! -nargs=? -bang Wg        call s:workdir_grep(<q-args>, <bang>0)
command! -nargs=? -bang GitGrep   call s:git_grep(<q-args>, personal#git#Repo(), <bang>0)
command! -nargs=? -bang GGrep     call s:git_grep(<q-args>, personal#git#Repo(), <bang>0)
command! -nargs=* -bang Tags      call fzf#vim#tags(expand('<cword>') . ' ', fzf#vim#with_preview({ 'dir': systemlist('git rev-parse --show-toplevel 2>/dev/null || pwd')[0], "placeholder": "--tag {2}:{-1}:{3..}", 'options': '--exact --select-1 --exit-0 +i'}), <bang>0)

" fzf
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-l> <plug>(fzf-complete-line)
if executable('rg')
  inoremap <expr> <c-x><c-f> fzf#vim#complete#path($FZF_DEFAULT_COMMAND)
  inoremap <expr> <c-x><c-l> fzf#vim#complete(fzf#wrap({
  \ 'prefix': '^.*$',
  \ 'source': 'rg -n ^ --color always',
  \ 'options': '--ansi --delimiter : --nth 3..',
  \ 'reducer': { lines -> join(split(lines[0], ':\zs')[2:], '') }}))
endif

function! FzfGrepMap(lhs, cmd)
  "nnoremap <silent> <leader>sp :Pg<Cr>
  execute 'nnoremap ' . a:lhs.' :' . a:cmd . '<CR>'

  "vnoremap <silent> <leader>sp :<C-u>execute ':Pg '.personal#functions#selected()<CR>
  execute "vnoremap <silent> " . a:lhs . " :<C-u>execute ':" . a:cmd . " '.personal#functions#selected()<CR>"
endfunction

call FzfGrepMap('<leader>s<Space>', 'RG')
call FzfGrepMap('<leader>ss', 'Sessions')
call FzfGrepMap('<leader>sd', 'Find')
call FzfGrepMap('<leader>sl', 'Sp')
call FzfGrepMap('<leader>sp', 'Pg')
call FzfGrepMap('<leader>sw', 'Wg')

nnoremap <leader>st :Tags<cr>
nnoremap <leader>sb :BLines<cr>
nnoremap <leader>s: :History:<cr>
nnoremap <leader>s/ :History/<cr>
nnoremap <C-]>      :Tags<cr>

