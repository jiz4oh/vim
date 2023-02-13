if exists('g:project_markers')
  let g:terminal_rootmarkers = g:project_markers
end

let g:terminal_pos = 'botright'
let g:terminal_default_mapping = 0

let g:terminal_key = '<m-=>'
let g:terminal_close = 1

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
