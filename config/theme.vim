let g:disable_personal_stl = get(g:, 'disable_personal_stl', 0)

let s:diabled_fts =
  \ ['defx', 'denite', 'vista', 'tagbar', 'undotree', 'diff', 'peekaboo', 'sidemenu', 'qf', 'coc-explorer', 'startify', 'vim-plug']

function! StatusLineMode()
  let s:mode_map = {
  \  'n': 'NORMAL', 'i': 'INSERT', 'R': 'REPLACE', 'v': 'VISUAL', 'V': 'V-LINE', "\<C-v>": 'V-BLOCK',
  \  'c': 'COMMAND', 's': 'SELECT', 'S': 'S-LINE', "\<C-s>": 'S-BLOCK', 't': 'TERMINAL'
  \}
  return get(s:mode_map, mode(), '')
endfunction

let s:stl = ''
let s:stl .= "%#StatusLine#%n"
let s:stl .= "%#ModeMsg#\ %{StatusLineMode()}\ "
let s:stl .= "%#Identifier#%f\ %m%h%w%r\ "

let s:stl .= "%="
let s:stl .= "%#StatusLineNC#%<%{&fileencoding?&fileencoding:&encoding}[%{&fileformat}]"
let s:stl .= "%#ModeMsg#\ %{&filetype}\ "
let s:stl .= "%#StatusLine#\ \ %p%%\ ☰\ %l:%v\ "

let s:stl_nc = ""
let s:stl_nc .= "%f%h%w%r"

function s:status_line_active() abort
    if g:disable_personal_stl || index(s:diabled_fts, &ft) > 0
        return
    endif

    set noshowmode
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
