if has('nvim')
  let g:slime_target = "neovim"
elseif has('terminal') && exists(':terminal') == 2 && has('patch-8.1.1')
  let g:slime_target = "vimterminal"
endif

let g:slime_no_mappings = 1
xmap <silent> gz <Plug>SlimeRegionSend
nmap <silent> gz <Plug>SlimeMotionSend
nmap <silent> gzz <Plug>SlimeLineSend
