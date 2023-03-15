if exists('g:project_markers')
  let g:terminal_rootmarkers = g:project_markers
end

let g:terminal_pos = 'botright'
let g:terminal_height = 20
let g:terminal_cwd = 2
let g:terminal_default_mapping = 0

let g:terminal_key = '<m-=>'
let g:terminal_close = 1

let s:cmd = 'nnoremap <silent>'.(g:terminal_key). ' '
execute s:cmd . ':call TerminalToggle()<cr>'

if has('nvim')
  let s:cmd = 'tnoremap <silent>'.(g:terminal_key). ' '
  execute s:cmd . '<c-\><c-n>:call TerminalToggle()<cr>'
elseif has('terminal') && exists(':terminal') == 2 && has('patch-8.1.1')
  let s:cmd = 'tnoremap <silent>'.(g:terminal_key). ' '
  let termwinkey = empty(&termwinkey) ? '<c-w>' : &termwinkey
  execute s:cmd . termwinkey . ':call TerminalToggle()<cr>'
endif

augroup vim-terminal-help-augroup
  autocmd!

  " need unlet t:__terminal_bid__ after terminal closed, a good option is set
  " exit_cb in term_start
  if has('nvim')
    autocmd TermOpen * let t:__terminal_bid__ = bufnr('')
  elseif exists('##TerminalWinOpen')
    autocmd TerminalWinOpen * let t:__terminal_bid__ = bufnr('')
  endif
augroup END
