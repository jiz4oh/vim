let g:repl_config = {
            \   'javascript': { 'cmd': 'node' },
            \   'ruby': { 'cmd': 'irb'},
            \   'vim': { 'cmd': 'vim -e'},
            \ }

nnoremap <silent> <leader>rr :botright keep 16 Repl<cr>

if has('nvim')
  runtime zepl/contrib/nvim_autoscroll_hack.vim
endif
