if get(s:, 'loaded', 0) != 0
	finish
endif
let s:loaded = 1

let g:neovide_input_macos_alt_is_meta = v:true
if has('nvim')
  finish
endif

function! Terminal_MetaMode()
  set ttimeout
  if $TMUX != ''
    set ttimeoutlen=35
  elseif &ttimeoutlen > 80 || &ttimeoutlen <= 0
    set ttimeoutlen=85
  endif
  function! s:meta_code(key)
    if has("gui_running") && has("gui_macvim")
      set macmeta
    elseif index(get(g:, "alt_compatible_programs", []), $TERM_PROGRAM) < 0
      exec "set <M-".a:key.">=\e".a:key
    endif

    " terminal map for vim
    exec "tnoremap <m-". a:key."> <Esc>".a:key
  endfunc
  for i in range(10)
    call s:meta_code(nr2char(char2nr('0') + i))
  endfor
  for i in range(26)
    call s:meta_code(nr2char(char2nr('a') + i))
  endfor
  for i in range(15) + range(16, 25)
    call s:meta_code(nr2char(char2nr('A') + i))
  endfor
  for c in [',', '.', '/', ';', '{', '}']
    call s:meta_code(c)
  endfor
  for c in ['?', ':', '-', '_', '+', '=', "'"]
    call s:meta_code(c)
  endfor
  function! s:key_escape(name, code)
    exec "set ".a:name."=\e".a:code
  endfunc
  call s:key_escape('<F1>', 'OP')
  call s:key_escape('<F2>', 'OQ')
  call s:key_escape('<F3>', 'OR')
  call s:key_escape('<F4>', 'OS')
endfunc

call Terminal_MetaMode()
