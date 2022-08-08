let $FZF_DEFAULT_OPTS="--reverse"
let g:fzf_preview_window = ['down:60%', 'ctrl-/']

" jump to existed window if possible
let g:fzf_buffers_jump = 1
let g:fzf_history_dir = '~/.local/share/fzf-history'
if exists('$TMUX')
  let g:fzf_layout = { 'tmux': '-p90%,60%' }
elseif has('nvim') || has('patch-8.2.191')
  let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.8 } }
else
  " disable popup in favor of location window
  let g:fzf_layout = { 'down': '60%' }
endif
