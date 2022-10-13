nnoremap <leader>sf :FZFMru<cr>

if g:is_win
  let MRU_Exclude_Files = '^D:\\temp\\.*'           " For MS-Windows
else
  let MRU_Exclude_Files = '^/tmp/.*\|^/var/tmp/.*'  " For Unix
endif
