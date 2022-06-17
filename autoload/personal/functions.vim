" keep old clipboard
function! personal#functions#selected()
  let old_reg = getreg('"')
  let old_regtype = getregtype('"')
  let old_clipboard = &clipboard
  set clipboard&
  normal! ""gvy
  let selection = getreg('"')
  call setreg('"', old_reg, old_regtype)
  let &clipboard = old_clipboard
  return selection
endfunction

" stole from fzf.vim https://github.com/junegunn/fzf.vim/blob/d5f1f8641b24c0fd5b10a299824362a2a1b20ae0/autoload/fzf/vim.vim#L362
function! personal#functions#shortpath(path)
  let short = fnamemodify(a:path, ':~:.')
  if !has('win32unix')
    let short = pathshorten(short)
  endif
  let slash = (g:is_win && !&shellslash) ? '\' : '/'
  return empty(short) ? '~'.slash : short . (short =~ escape(slash, '\').'$' ? '' : slash)
endfunction

function! personal#functions#escape_for_regexp(str)
  return escape(a:str, '^$.*?/\[]')
endfunction
