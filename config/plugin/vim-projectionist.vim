let g:projectionist_heuristics = {
      \ ".git/": {
      \   ".git/hooks/*": {"type": "githook"},
      \   ".github/workflows/*": {"type": "githubworkflow"}
      \ },
      \ ".hg/|.svn/|.bzr/|Makefile": {
      \ },
      \ "package-lock.json": {
      \   "*": {
      \      "make": "npm",
      \   },
      \   "yarn.lock": {
      \      "make": "yarn",
      \   },
      \ },
      \ "yarn.lock": {
      \   "*": {
      \      "make": "yarn",
      \   },
      \   "package-lock.json": {
      \      "make": "npm",
      \   },
      \ },
      \ "package.json": {
      \   "*": {
      \      "console": "node"
      \   },
      \   "package.json": {
      \      "type": "lib",
      \      "alternate": ["yarn.lock", "package-lock.json"]
      \   },
      \   "package-lock.json": {
      \      "dispatch": "npm install",
      \      "alternate": "package.json",
      \      "start": "npm run start",
      \   },
      \   "yarn.lock": {
      \      "dispatch": "yarn install",
      \      "alternate": "package.json",
      \      "start": "yarn run start",
      \   },
      \ },
      \ "Gemfile|Rakefile|*.gemspec": {
      \ },
      \ 'requirements.txt|requirements.in': {
      \   '*.py': {
      \      'make': 'python',
      \   },
      \   'requirements.txt': {
      \      'make': 'pip',
      \      'dispatch': 'pip install -r %',
      \   },
      \ }
      \}

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
