let g:fzf_mru_no_sort = 1

command! -bang -nargs=? FZFMru call fzf_mru#actions#mru(<q-args>, fzf#vim#with_preview({'options': '--prompt "MRU>"'}))

nnoremap <leader>sf :FZFMru<cr>

if g:is_win
  let g:fzf_mru_exclude = '^D:\\temp\\.*'           " For MS-Windows
else
  let g:fzf_mru_exclude = '^/tmp/.*\|^/var/tmp/.*'
  " ignore session
  let g:fzf_mru_exclude .= '\|Session.vim\|^'. resolve(expand(g:session_dir)) . '/.*'
  let g:fzf_mru_exclude .= '\|.git/.*MSG'
endif

function! MRUCwd(...) abort
  let files = fzf_mru#mrufiles#source()[0: a:1 - 1]
  return map(files, { _, val -> {
        \ 'line': val,
        \ 'path': val
        \}})
endfunction
