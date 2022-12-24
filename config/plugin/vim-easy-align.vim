" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" In normal mode, press bar (|) to select table and align it
au FileType markdown noremap <Bar> vip:EasyAlign*<Bar><Enter>
