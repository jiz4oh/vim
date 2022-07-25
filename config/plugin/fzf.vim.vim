augroup update_bat_theme
    autocmd!
    autocmd colorscheme * if &background == 'dark' | let $BAT_THEME='OneHalfDark' | else | let $BAT_THEME='' | endif
augroup end

" `brew install ripgrep` before you use rg command
if !executable('rg')
  function! s:git_grep(query, dir, fullscreen)
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

  function! s:git_grep(query, fullscreen)
    let l:query = empty(a:query) ? shellescape('') : '-w ' . shellescape(a:query)
    let l:grep_cmd = printf(g:fzf_grep_cmd, l:query)
    let l:dir = personal#git#Repo()
    let l:spec = {
          \'dir': l:dir,
          \'options': [
             \'--prompt', personal#functions#shortpath(l:dir) .'> ',
             \'--delimiter', ':',
             \'--nth', '4..'
             \]}

    call fzf#vim#grep(l:grep_cmd, 1, fzf#vim#with_preview(l:spec), a:fullscreen)
  endfunction

  function! s:project_grep(query, fullscreen)
    let l:query = empty(a:query) ? shellescape('') : '-w ' . shellescape(a:query)
    let l:grep_cmd = printf(g:fzf_grep_cmd, l:query)
    let l:dir = exists('*FindRootDirectory') ? FindRootDirectory() : ''
    let l:dir = empty(l:dir) ? getcwd() : l:dir

    let l:spec = {
          \'dir': l:dir,
          \'options': [
             \'--prompt', personal#functions#shortpath(l:dir) .'> ',
             \'--delimiter', ':',
             \'--nth', '4..',
             \]}

    call fzf#vim#grep(l:grep_cmd, 1, fzf#vim#with_preview(l:spec), a:fullscreen)
  endfunction

  function! s:workdir_grep(query, fullscreen)
    let l:query = empty(a:query) ? shellescape('') : '-w ' . shellescape(a:query)
    let l:grep_cmd = printf(g:fzf_grep_cmd, l:query)
    let l:dir = getcwd()

    let l:spec = {
          \'dir': l:dir,
          \'options': [
             \'--prompt', personal#functions#shortpath(l:dir) .'> ',
             \'--delimiter', ':',
             \'--nth', '4..',
             \]}

    call fzf#vim#grep(l:grep_cmd, 1, fzf#vim#with_preview(l:spec), a:fullscreen)
  endfunction

  function! RipgrepFzf(query, fullscreen)
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
call FzfGrepMap('<leader>sb', 'BLines')
call FzfGrepMap('<leader>sp', 'Pg')
call FzfGrepMap('<leader>sw', 'Wg')
call FzfGrepMap('<leader>st', 'Tags')
call FzfGrepMap('<C-]>', 'Tags')
