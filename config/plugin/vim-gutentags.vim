if exists('g:project_markers')
  let g:gutentags_project_root = g:project_markers
endif

if executable('ripper-tags')
  let g:gutentags_ctags_executable_ruby = 'ripper-tags'
endif

if executable('gotags')
  let g:gutentags_ctags_executable_go = 'gotags'
endif

