if get(s:, 'loaded', 0) != 0
	finish
endif
let s:loaded = 1

"make vim respond to alt key
"https://github.com/fgheng/vime/blob/master/plugin/alt.vim
let s:alt_compatible_programs = ['iTerm.app']

if has('nvim')
  finish
endif

if index(s:alt_compatible_programs, $TERM_PROGRAM) >= 0
  finish
endif

if has("gui_running")
  if has("gui_macvim")
    set macmeta
  end

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
    exec "set <M-".a:key.">=\e".a:key
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
