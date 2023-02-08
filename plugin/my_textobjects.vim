" ============================================================================
" TEXT OBJECTS {{{
" ============================================================================

" ----------------------------------------------------------------------------
" Common
" ----------------------------------------------------------------------------
function! s:textobj_cancel()
  if v:operator == 'c'
    augroup textobj_undo_empty_change
      autocmd InsertLeave <buffer> execute 'normal! u'
            \| execute 'autocmd! textobj_undo_empty_change'
            \| execute 'augroup! textobj_undo_empty_change'
    augroup END
  endif
endfunction

noremap         <Plug>(TOC) <nop>
inoremap <expr> <Plug>(TOC) exists('#textobj_undo_empty_change')?"\<esc>":''
" ----------------------------------------------------------------------------
" ?ie | entire object
" ----------------------------------------------------------------------------
xnoremap <silent> ie gg0oG$
onoremap <silent> ie :<C-U>execute "normal! m`"<Bar>keepjumps normal! ggVG<CR>

" ----------------------------------------------------------------------------
" ?iv | current viewable text in the buffer
" ----------------------------------------------------------------------------
onoremap <silent> iv :<C-U>execute "normal! m`"<Bar>keepjumps normal! HVL"<CR>

" ----------------------------------------------------------------------------
" ?iL | inner Line
" ----------------------------------------------------------------------------
xnoremap <silent> iL <Esc>^vg_
onoremap <silent> iL :<C-U>normal! ^vg_<CR>

" ----------------------------------------------------------------------------
" ?a= / i= | a erb text object
" ----------------------------------------------------------------------------
" https://github.com/AndrewRadev/Vimfiles/blob/215a193d1906c354b29451ff806a86ddf28bfdfb/ftplugin/eruby.vim#L22
augroup textobjects-augroup
  autocmd!

  autocmd FileType eruby onoremap <silent><buffer> a= :<c-u>call <SID>ErbTextObject('a')<cr>
  autocmd FileType eruby xnoremap <silent><buffer> a= :<c-u>call <SID>ErbTextObject('a')<cr>
  autocmd FileType eruby onoremap <silent><buffer> i= :<c-u>call <SID>ErbTextObject('i')<cr>
  autocmd FileType eruby xnoremap <silent><buffer> i= :<c-u>call <SID>ErbTextObject('i')<cr>
augroup END

function! s:ErbTextObject(mode)
  if search('<%.*\%#.*%>', 'n') <= 0
    return
  endif

  if a:mode == 'i'
    let [start_flags, end_flags] = ['be', '']
  else " a:mode == 'a'
    let [start_flags, end_flags] = ['b', 'e']
  endif

  call search('<%=\?\s*.', start_flags, line('.'))
  let start = col('.') - 1
  call search('.\s*-\?%>', end_flags, line('.'))
  let end = col('.') - 1

  let interval = end - start

  if start == 0
    exe 'normal! 0v'.interval.'l'
  else
    exe 'normal! 0'.start.'lv'.interval.'l'
  endif
endfunction
" " }}}
