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
" ?il | inner line
" ----------------------------------------------------------------------------
xnoremap <silent> il <Esc>^vg_
onoremap <silent> il :<C-U>normal! ^vg_<CR>

" " ----------------------------------------------------------------------------
" " ?i# | inner comment
" " ----------------------------------------------------------------------------
" function! s:inner_comment(vis)
"   if synIDattr(synID(line('.'), col('.'), 0), 'name') !~? 'comment'
"     call s:textobj_cancel()
"     if a:vis
"       normal! gv
"     endif
"     return
"   endif

"   let origin = line('.')
"   let lines = []
"   for dir in [-1, 1]
"     let line = origin
"     let line += dir
"     while line >= 1 && line <= line('$')
"       execute 'normal!' line.'G^'
"       if synIDattr(synID(line('.'), col('.'), 0), 'name') !~? 'comment'
"         break
"       endif
"       let line += dir
"     endwhile
"     let line -= dir
"     call add(lines, line)
"   endfor

"   execute 'normal!' lines[0].'GV'.lines[1].'G'
" endfunction
" xmap <silent> i# :<C-U>call <SID>inner_comment(1)<CR><Plug>(TOC)
" omap <silent> i# :<C-U>call <SID>inner_comment(0)<CR><Plug>(TOC)

" " ----------------------------------------------------------------------------
" " ?ic / ?iC | Blockwise column object
" " ----------------------------------------------------------------------------
" function! s:inner_blockwise_column(vmode, cmd)
"   if a:vmode == "\<C-V>"
"     let [pvb, pve] = [getpos("'<"), getpos("'>")]
"     normal! `z
"   endif

"   execute "normal! \<C-V>".a:cmd."o\<C-C>"
"   let [line, col] = [line('.'), col('.')]
"   let [cb, ce]    = [col("'<"), col("'>")]
"   let [mn, mx]    = [line, line]

"   for dir in [1, -1]
"     let l = line + dir
"     while line('.') > 1 && line('.') < line('$')
"       execute "normal! ".l."G".col."|"
"       execute "normal! v".a:cmd."\<C-C>"
"       if cb != col("'<") || ce != col("'>")
"         break
"       endif
"       let [mn, mx] = [min([line('.'), mn]), max([line('.'), mx])]
"       let l += dir
"     endwhile
"   endfor

"   execute printf("normal! %dG%d|\<C-V>%s%dG", mn, col, a:cmd, mx)

"   if a:vmode == "\<C-V>"
"     normal! o
"     if pvb[1] < line('.') | execute "normal! ".pvb[1]."G" | endif
"     if pvb[2] < col('.')  | execute "normal! ".pvb[2]."|" | endif
"     normal! o
"     if pve[1] > line('.') | execute "normal! ".pve[1]."G" | endif
"     if pve[2] > col('.')  | execute "normal! ".pve[2]."|" | endif
"   endif
" endfunction

" xnoremap <silent> ic mz:<C-U>call <SID>inner_blockwise_column(visualmode(), 'iw')<CR>
" xnoremap <silent> iC mz:<C-U>call <SID>inner_blockwise_column(visualmode(), 'iW')<CR>
" xnoremap <silent> ac mz:<C-U>call <SID>inner_blockwise_column(visualmode(), 'aw')<CR>
" xnoremap <silent> aC mz:<C-U>call <SID>inner_blockwise_column(visualmode(), 'aW')<CR>
" onoremap <silent> ic :<C-U>call   <SID>inner_blockwise_column('',           'iw')<CR>
" onoremap <silent> iC :<C-U>call   <SID>inner_blockwise_column('',           'iW')<CR>
" onoremap <silent> ac :<C-U>call   <SID>inner_blockwise_column('',           'aw')<CR>
" onoremap <silent> aC :<C-U>call   <SID>inner_blockwise_column('',           'aW')<CR>
" " }}}
