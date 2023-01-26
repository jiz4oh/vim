nmap <silent> '<CR> :botright Start<CR>
nmap <silent><expr> <leader><CR> ':botright ' . (exists(':Console') == 2 ? 'Console' : 'Start') . '<CR>'
nmap <expr> <leader>! ':botright ' . (exists(':Console') == 2 ? 'Console!' : 'Start!')

