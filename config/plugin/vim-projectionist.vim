let g:projectionist_heuristics = {
      \ ".git/": {
      \   ".git/hooks/*": {"type": "githook"},
      \   ".github/workflows/*": {"type": "githubworkflow"}
      \ },
      \ ".hg/|.svn/|.bzr/|Makefile": {
      \ },
      \ "package.json": {
      \ },
      \ "Gemfile|Rakefile": {
      \ }}

function! s:init() abort
  if exists(':tcd')
    noremap <buffer> <silent>cdp :Ptcd<CR>:echo 'cwd: ' . getcwd()<CR>
  else
    noremap <buffer> <silent>cdp :Pcd<CR>:echo 'cwd: ' . getcwd()<CR>
  end
endfunction
