let g:projectionist_heuristics = {
      \ ".git/": {
      \   ".git/hooks/*": {"type": "githook"},
      \   ".github/workflows/*": {"type": "githubworkflow"}
      \ },
      \ ".hg/|.svn/|.bzr/|Makefile": {
      \ },
      \ "package.json": {
      \ },
      \ "Gemfile|Rakefile|*.gemspec": {
      \ }}

let g:projects = []

function! s:activate() abort
  let ps = filter(keys(b:projectionist), 'v:val !~ "^fugitive:.*"')
  call extend(g:projects, ps)

  let dict = {}
  for l in g:projects
    let dict[l] = ''
  endfor

  let g:projects = keys(dict)
  return g:projects
endfunction


augroup projectionist-augroup
  autocmd!
  autocmd User ProjectionistActivate call s:activate()
augroup END
