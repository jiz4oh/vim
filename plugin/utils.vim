" if exists('g:loaded_utils_vim')
"   finish
" endif
" let g:loaded_utils_vim = 1

function! GitModified()
    let files = systemlist('git ls-files -m 2>/dev/null')
    return map(files, "{'line': v:val, 'cmd': ':execute \"e \" . fnameescape(\"' . v:val . '\") | Gvdiffsplit'}")
endfunction

" same as above, but show untracked files, honouring .gitignore
function! GitUntracked()
    let files = systemlist('git ls-files -o --exclude-standard 2>/dev/null')
    return map(files, "{'line': v:val, 'path': v:val}")
endfunction

function! GitStaged()
    let files = systemlist('git diff --name-only --staged 2>/dev/null')
    return map(files, "{'line': v:val, 'cmd': ':execute \"e \" . fnameescape(\"' . v:val . '\") | aboveleft Gvdiffsplit HEAD'}")
endfunction

" `brew install ripgrep` before you use rg command
if !executable('rg')
  function! GitGrep(query, fullscreen)
    let l:query = empty(a:query) ? shellescape('') : '-w ' . shellescape(a:query)
    let l:grep_cmd = 'git grep --line-number ' . l:query
    let l:dir = GitRepo()

    call fzf#vim#grep(l:grep_cmd, 0, fzf#vim#with_preview({'dir': l:dir, 'options': ['--prompt', fnamemodify(l:dir, ':t').''.GitBranchName().'> ', '--delimiter', ':', '--nth', '3..']}), a:fullscreen)
  endfunction

  function! Rg(query, fullscreen)
    echohl WarningMsg
    echom 'ripgrep not found, please read https://github.com/BurntSushi/ripgrep#installation about how to install'
    echohl None
    return 0
  endfunction

  function! ProjectGrep(query, fullscreen)
    call GitGrep(a:query, a:fullscreen)
  endfunction
else
  set grepprg=rg\ --vimgrep\ --smart-case\ --follow
  set grepformat=%f:%l:%c:%m
  let $FZF_DEFAULT_COMMAND='rg --files --hidden -g "!{.git}/*" 2>/dev/null'
  let g:fzf_grep_cmd = 'rg --column --line-number --no-heading --smart-case --follow --color=always %s || true'
  inoremap <expr> <c-x><c-f> fzf#vim#complete#path($FZF_DEFAULT_COMMAND)
  inoremap <expr> <c-x><c-l> fzf#vim#complete(fzf#wrap({
  \ 'prefix': '^.*$',
  \ 'source': 'rg -n ^ --color always',
  \ 'options': '--ansi --delimiter : --nth 3..',
  \ 'reducer': { lines -> join(split(lines[0], ':\zs')[2:], '') }}))

  function! GitGrep(query, fullscreen)
    let l:query = empty(a:query) ? shellescape('') : '-w ' . shellescape(a:query)
    let l:grep_cmd = printf(g:fzf_grep_cmd, l:query)
    let l:dir = GitRepo()

    call fzf#vim#grep(l:grep_cmd, 1, fzf#vim#with_preview({'dir': l:dir, 'options': ['--prompt', fnamemodify(l:dir, ':t').''.GitBranchName().'> ', '--delimiter', ':', '--nth', '4..']}), a:fullscreen)
  endfunction

  function! ProjectGrep(query, fullscreen)
    let l:query = empty(a:query) ? shellescape('') : '-w ' . shellescape(a:query)
    let l:grep_cmd = printf(g:fzf_grep_cmd, l:query)
    let l:dir = empty(FindRootDirectory()) ? getcwd() : FindRootDirectory()

    call fzf#vim#grep(l:grep_cmd, 1, fzf#vim#with_preview({'dir': l:dir, 'options': ['--prompt', fnamemodify(l:dir, ':t') .'> ', '--delimiter', ':', '--nth', '4..']}), a:fullscreen)
  endfunction

  function! RipgrepFzf(query, fullscreen)
    let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case -- %s || true'
    let initial_command = printf(command_fmt, shellescape(a:query))
    let reload_command = printf(command_fmt, '{q}')
    let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
    call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
  endfunction
endif

function! VisualSelection()
  let old_reg = getreg('"')
  let old_regtype = getregtype('"')
  let old_clipboard = &clipboard
  set clipboard&
  normal! ""gvy
  let selection = getreg('"')
  call setreg('"', old_reg, old_regtype)
  let &clipboard = old_clipboard
  return selection
endfunction

function! FzfGrepMap(key, cmd)
  execute 'nnoremap <leader>s' . a:key.' :' . a:cmd . '<CR>'

  execute "vnoremap <silent> <leader>s" . a:key . " :<C-u>execute ':" . a:cmd . " '.VisualSelection()<CR>"
endfunction

