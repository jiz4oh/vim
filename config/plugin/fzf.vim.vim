augroup update_bat_theme
    autocmd!
    autocmd colorscheme * if &background == 'dark' | let $BAT_THEME='OneHalfDark' | else | let $BAT_THEME='' | endif
augroup end

" `brew install ripgrep` before you use rg command
if !executable('rg')
  function! s:git_grep(query, fullscreen)
    let l:query = empty(a:query) ? shellescape('') : '-w ' . shellescape(a:query)
    let l:grep_cmd = 'git grep --line-number ' . l:query
    let l:dir = personal#git#Repo()

    call fzf#vim#grep(l:grep_cmd, 0, fzf#vim#with_preview({'dir': l:dir, 'options': ['--prompt', fnamemodify(l:dir, ':t').''.personal#git#BranchName().'> ', '--delimiter', ':', '--nth', '3..']}), a:fullscreen)
  endfunction

  function! Rg(query, fullscreen)
    echohl WarningMsg
    echom 'ripgrep not found, please read https://github.com/BurntSushi/ripgrep#installation about how to install'
    echohl None
    return 0
  endfunction

  function! s:project_grep(query, fullscreen)
    call s:git_grep(a:query, a:fullscreen)
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

    call fzf#vim#grep(l:grep_cmd, 1, fzf#vim#with_preview({'dir': l:dir, 'options': ['--prompt', fnamemodify(l:dir, ':t').''.personal#git#BranchName().'> ', '--delimiter', ':', '--nth', '4..']}), a:fullscreen)
  endfunction

  function! s:project_grep(query, fullscreen)
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

command! -nargs=? -bang RG        call RipgrepFzf(<q-args>, <bang>0)
command! -nargs=? -bang Pg        call s:project_grep(<q-args>, <bang>0)
command! -nargs=? -bang GitGrep   call s:git_grep(<q-args>, <bang>0)
command! -nargs=? -bang GGrep     call s:git_grep(<q-args>, <bang>0)
command! -nargs=* -bang Tags      call fzf#vim#tags(<q-args>, fzf#vim#with_preview({ 'dir': systemlist('git rev-parse --show-toplevel 2>/dev/null || pwd')[0], "placeholder": "--tag {2}:{-1}:{3..}", 'options': '--exact --select-1 --exit-0 +i'}), <bang>0)

