" 当处于非项目下时保持和 autochdir 相同行为
let g:rooter_change_directory_for_non_project_files = 'current'
if exists(':tcd')
  let g:rooter_cd_cmd = 'tcd'
else
  let g:rooter_cd_cmd = 'cd'
end
let g:rooter_resolve_links = 1
let g:rooter_manual_only = 1
