nnoremap <leader>sf :FZFMru<cr>

if g:is_win
  let MRU_Exclude_Files = '^D:\\temp\\.*'           " For MS-Windows
else
  let MRU_Exclude_Files = '^/tmp/.*\|^/var/tmp/.*'
  let MRU_Exclude_Files .= '\|Session.vim'
  let MRU_Exclude_Files .= '\|^'. resolve(expand(g:session_dir)) . '/.*'
endif
