if !(exists("g:plugs") && has_key(g:plugs, 'vim-airline'))
  let s:disable_statusline =
    \ ['defx', 'denite', 'vista', 'tagbar', 'undotree', 'diff', 'peekaboo', 'sidemenu', 'qf', 'coc-explorer', 'startify', 'vim-plug']

  let s:stl = ''
  let s:stl .= "%#Identifier#%f%h%w%r "

  let s:stl .= "%="
  let s:stl .= "%#StatusLine# %{&filetype}"
  let s:stl .= "%#StatusLineNC# %{&fileencoding?&fileencoding:&encoding}[%{&fileformat}] "
  let s:stl .= "%#StatusLineNC#  %p%% ☰ %l:%v "

  let s:stl_nc = ""
  let s:stl_nc .= "%f%h%w%r"

  function s:status_line_active() abort
      if index(s:disable_statusline, &ft) > 0
          return
      endif

      let &l:statusline = s:stl
  endfunction

  function s:status_line_inactive() abort
      let &l:statusline = s:stl_nc
  endfunction

  augroup vime_theme_statusline_group
      autocmd!
      autocmd WinLeave * call s:status_line_inactive()
      autocmd VimEnter,ColorScheme,FileType,WinEnter,BufWinEnter * call s:status_line_active()
      autocmd FileChangedShellPost,BufFilePost,BufNewFile,BufWritePost * redrawstatus
  augroup END

  " set mark column color
  hi! link SignColumn   LineNr
  hi! link ShowMarksHLl DiffAdd
  hi! link ShowMarksHLu DiffChange
endif
