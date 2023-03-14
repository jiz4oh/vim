if has('nvim')
  let g:slime_target = "neovim"
elseif has('terminal') && exists(':terminal') == 2 && has('patch-8.1.1')
  let g:slime_target = "vimterminal"
endif

let g:slime_no_mappings = 1
xmap <silent> gz <Plug>SlimeRegionSend
nmap <silent> gz <Plug>SlimeMotionSend
nmap <silent> gzz <Plug>SlimeLineSend

" https://github.com/pry/pry/issues/1524#issuecomment-237309299
" https://github.com/pry/pry/issues/1524#issuecomment-276117072
" so that I can paste multiple lines in pry/ruby like
" foo
"  .bar
"  .baz
function! g:_EscapeText_ruby(text)
  return ["(\n", a:text, ")\n"]
endfunction

if g:slime_target ==# 'vimterminal'
  function! g:SlimeOverrideSend(config, text)
    let bufnr = str2nr(get(a:config,'bufnr',''))
    if len(term_getstatus(bufnr))==0
      echoerr 'Invalid terminal. Use :SlimeConfig to select a terminal'
      return
    endif

    call term_sendkeys(bufnr,a:text)
  endfunction
endif
