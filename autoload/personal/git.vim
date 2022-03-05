function! personal#git#Repo()
  if !has_key(b:, 'git_repo')
    let b:git_repo = trim(system('git rev-parse --show-toplevel 2>/dev/null'))
  endif
  return b:git_repo
endfunction

function! personal#git#RepoName()
  let l:repo = personal#git#Repo()
  if empty(l:repo)
    return l:repo
  endif
  return split(l:repo, '/')[-1]
endfunction

function! personal#git#BranchName()
  if !has_key(b:, 'git_branch_name')
    let b:git_branch_name = trim(system('git rev-parse --abbrev-ref HEAD 2>/dev/null'))
  endif
  return b:git_branch_name
endfunction

function! personal#git#RelativePath() abort
  let l:repo_path = personal#git#Repo()
  if empty(l:repo_path)
    return expand('%:p:~')
  else
    return substitute(expand('%:p'), l:repo_path . '/', '', '')
  endif
endfunction

function! personal#git#Modified()
    let files = systemlist('git ls-files -m 2>/dev/null')
    return map(files, "{'line': v:val, 'cmd': ':execute \"e \" . fnameescape(\"' . v:val . '\") | Gvdiffsplit'}")
endfunction

" same as above, but show untracked files, honouring .gitignore
function! personal#git#Untracked()
    let files = systemlist('git ls-files -o --exclude-standard 2>/dev/null')
    return map(files, "{'line': v:val, 'path': v:val}")
endfunction

function! personal#git#Staged()
    let files = systemlist('git diff --name-only --staged 2>/dev/null')
    return map(files, "{'line': v:val, 'cmd': ':execute \"e \" . fnameescape(\"' . v:val . '\") | aboveleft Gvdiffsplit HEAD'}")
endfunction
