let $FZF_DEFAULT_OPTS="--reverse --bind 'change:first,alt-n:page-down,alt-p:page-up,alt-j:preview-down,alt-k:preview-up'"
let g:fzf_preview_window = ['down:60%', 'ctrl-/']

let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit'
  \}

" jump to existed window if possible
let g:fzf_buffers_jump = 1
let g:fzf_history_dir = '~/.local/share/fzf-history'
if exists('$TMUX')
  let g:fzf_layout = { 'tmux': '-p90%,60%' }
elseif has('nvim') || has('patch-8.2.191')
  " https://github.com/junegunn/fzf.vim/issues/672#issuecomment-1191112563
  " autocmd! FileType fzf tnoremap <expr> <C-r> getreg(nr2char(getchar()))
  autocmd! FileType fzf tnoremap <expr> <C-r> getreg(nr2char(getchar()))

  let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.8 } }
else
  autocmd! FileType fzf tnoremap <expr> <C-r> getreg(nr2char(getchar()))

  " disable popup in favor of location window
  let g:fzf_layout = { 'down': '60%' }
endif
