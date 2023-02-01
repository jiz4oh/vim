if get(s:, 'loaded', 0) != 0
	finish
endif
let s:loaded = 1

let g:disable_personal_stl = get(g:, 'disable_personal_stl', 0)

let s:diabled_fts =
  \ ['defx', 'denite', 'vista', 'tagbar', 'undotree', 'diff', 'peekaboo', 'sidemenu', 'qf', 'coc-explorer', 'startify', 'vim-plug']

function! StatusDiagnostic() abort
  let info = get(b:, 'coc_diagnostic_info', {})
  if empty(info) | return '' | endif
  let msgs = []
  if get(info, 'error', 0)
    call add(msgs, 'E' . info['error'])
  endif
  if get(info, 'warning', 0)
    call add(msgs, 'W' . info['warning'])
  endif
  return join(msgs, ' ') . ' ' . get(g:, 'coc_status', '')
endfunction

function! StatusLineMode()
  let s:mode_map = {
  \  'n': 'NORMAL', 'i': 'INSERT', 'R': 'REPLACE', 'v': 'VISUAL', 'V': 'V-LINE', "\<C-v>": 'V-BLOCK',
  \  'c': 'COMMAND', 's': 'SELECT', 'S': 'S-LINE', "\<C-s>": 'S-BLOCK', 't': 'TERMINAL'
  \}
  return get(s:mode_map, mode(), '')
endfunction

function! ShortDir() abort
  try
    let short = fnamemodify(fnamemodify('%', ':p'), ':h:~:.')
    if !has('win32unix')
      let short = pathshorten(short)
    endif
    let slash = (g:is_win && !&shellslash) ? '\' : '/'

    " add last slash
    return empty(short) ? '~'.slash : short . (short =~ escape(slash, '\').'$' ? '' : slash)
  catch
    return fnamemodify('%', ':p:h:~:.') . '/'
  endtry
endfunction

let s:stl = ''
let s:stl .= "%#StatusLine#"
let s:stl .= "%n"
let s:stl .= "%#ModeMsg#"
let s:stl .= " %{StatusLineMode()} "
let s:stl .= "%#StatusLineNC#"
let s:stl .= "%{ShortDir()}"
let s:stl .= "%#Identifier#"
let s:stl .= "%f %m%h%w%r "

let s:stl .= "%<"
let s:stl .= "%="
let s:stl .= "%{StatusDiagnostic()}"
let s:stl .= "%#StatusLineNC#"
let s:stl .= "%{&fileencoding?&fileencoding:&encoding}[%{&fileformat}]"
let s:stl .= "%#ModeMsg#"
let s:stl .= " %{&filetype} "
let s:stl .= "%#StatusLine#"
let s:stl .= "  %p%% ☰ %l:%v "

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
    autocmd FileChangedShellPost,BufNewFile,BufWritePost * redrawstatus
augroup END

" set mark column color
hi! link SignColumn   LineNr
hi! link ShowMarksHLl DiffAdd
hi! link ShowMarksHLu DiffChange
