if get(s:, 'loaded', 0) != 0
	finish
endif
let s:loaded = 1

if get(g:, 'disable_personal_stl', 0)
	finish
endif

set guioptions-=e          " make gui use &tabline
set tabline=%!MyTabLine()  " custom tab pages line

" https://stackoverflow.com/a/33765365/12644334
function! MyTabLine()
  let s = ''

  let session_flag = ' [<' . fnamemodify(v:this_session, ':t') . '>]'

  " set session name
  if !empty(v:this_session) && &sessionoptions =~ "tabpages"
    let s .= session_flag
  end

  " loop through each tab page
  for i in range(tabpagenr('$'))
    if i + 1 == tabpagenr()
      let s .= '%#TabLineSel#'
    else
      let s .= '%#TabLine#'
    endif
    if i + 1 == tabpagenr()
      let s .= '%#TabLineSel#' " WildMenu
    else
      let s .= '%#Title#'
    endif

    " set session name
    if !empty(v:this_session) && &sessionoptions !~ "tabpages"
      let s .= session_flag
    end
    
    " set the tab page number (for mouse clicks)
    let s .= '%' . (i + 1) . 'T '
    " set page number string
    let s .= i + 1 . ''
    
    " get buffer names and statuses
    let n = ''  " temp str for buf names
    let m = 0   " &modified counter
    let buflist = tabpagebuflist(i + 1)
    " loop through each buffer in a tab
    for b in buflist
      " if getbufvar(b, "&buftype") == 'help'
      "   " let n .= '[H]' . fnamemodify(bufname(b), ':t:s/.txt$//')
      " elseif getbufvar(b, "&buftype") == 'quickfix'
      "   " let n .= '[Q]'
      " elseif getbufvar(b, "&modifiable")
      "   " let n .= personal#functions#shortpath(expand("#" . bufnr(b) . ":p")) . ', ' " pathshorten(bufname(b))
      "   let n .= fnamemodify(bufname(b), ':t') . ', ' " pathshorten(bufname(b))
      " endif
      if getbufvar(b, "&modified")
        let m += 1
      endif
    endfor

    let n .= fnamemodify(bufname(buflist[tabpagewinnr(i + 1) - 1]), ':t')

    " remove last ,
    let n = substitute(n, ', $', '', '')
    " add modified label
    if m > 0
      " let s .= '+'
      let s .= '[' . m . '+]'
    endif
    if i + 1 == tabpagenr()
      let s .= ' %#TabLineSel#'
    else
      let s .= ' %#TabLine#'
    endif
    " add buffer names
    if n == ''
      let s.= '%f'
    else
      let s .= n
    endif
    " switch to no underlining and add final space
    let s .= ' '
  endfor
  let s .= '%#TabLineFill#%T'
  " right-aligned close button
  " if tabpagenr('$') > 1
  "   let s .= '%=%#TabLineFill#%999Xclose'
  " endif
  return s
endfunction
