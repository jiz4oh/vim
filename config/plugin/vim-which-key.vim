nnoremap <silent> <leader> :WhichKey '<Space>'<CR>
vnoremap <silent> <leader> :<c-u>WhichKeyVisual '<Space>'<CR>

let g:which_key_map = {}

let g:which_key_map['/'] = 'clear highlight'
let g:which_key_map['1'] = 'tab-1'
let g:which_key_map['2'] = 'tab-2'
let g:which_key_map['3'] = 'tab-3'
let g:which_key_map['4'] = 'tab-4'
let g:which_key_map['5'] = 'tab-5'
let g:which_key_map['6'] = 'tab-6'
let g:which_key_map['7'] = 'tab-7'
let g:which_key_map['8'] = 'tab-8'
let g:which_key_map['9'] = 'tab-9'
let g:which_key_map['y']  = 'yank {motion} to clipboard'
let g:which_key_map['yy'] = 'yank current line to clipboard'
let g:which_key_map['Y']  = 'yank from the cursor to the end of line to clipboard'

let g:which_key_map[' '] = {
      \ 'name' : '+easymotion/tab' ,
      \ 'f' : ['<plug>(easymotion-prefix)f' , 'find {char} to the right'],
      \ 'F' : ['<plug>(easymotion-prefix)F' , 'find {char} to the left'],
      \ 't' : ['<plug>(easymotion-prefix)t' , 'till before the {char} to the right'],
      \ 'T' : ['<plug>(easymotion-prefix)T' , 'till after the {char} to the left'],
      \ 'w' : ['<plug>(easymotion-prefix)w' , 'beginning of word forward'],
      \ 'W' : ['<plug>(easymotion-prefix)W' , 'beginning of WORD forward'],
      \ 'b' : ['<plug>(easymotion-prefix)b' , 'beginning of word backward'],
      \ 'B' : ['<plug>(easymotion-prefix)B' , 'beginning of WORD backward'],
      \ 'e' : ['<plug>(easymotion-prefix)e' , 'end of word forward'],
      \ 'E' : ['<plug>(easymotion-prefix)E' , 'end of WORD forward'],
      \ 'g' : {
        \ 'name' : '+Backwards ' ,
        \ 'e' : ['<plug>(easymotion-prefix)ge' , 'end of word backward'],
        \ 'E' : ['<plug>(easymotion-prefix)gE' , 'end of WORD backward'],
        \ },
      \ 'j' : ['<plug>(easymotion-prefix)j' , 'line downward'],
      \ 'k' : ['<plug>(easymotion-prefix)k' , 'line upward'],
      \ 'n' : ['<plug>(easymotion-prefix)n' , 'jump to latest "/" or "?" forward'],
      \ 'N' : ['<plug>(easymotion-prefix)N' , 'jump to latest "/" or "?" backward.'],
      \ 's' : ['<plug>(easymotion-prefix)s' , 'find(search) {char} forward and backward.'],
      \ }

if has('nvim')
let g:which_key_map['l'] = {
      \ 'name' : '+Lsp',
      \ }
endif

let g:which_key_map['b'] = {
      \ 'name' : '+Buffer',
      \ '1' : 'buffer-1'  ,
      \ '2' : 'buffer-2'  ,
      \ '3' : 'buffer-3'  ,
      \ '4' : 'buffer-4'  ,
      \ '5' : 'buffer-5'  ,
      \ '6' : 'buffer-6'  ,
      \ '7' : 'buffer-7'  ,
      \ '8' : 'buffer-8'  ,
      \ '9' : 'buffer-9'  ,
      \ }

let g:which_key_map['c'] = {
      \ 'name' : '+Close',
      \ 's' : ['SClose', 'close session and open startify'],
      \ 't' : ['UndoableTabclose', 'close tabpage'],
      \}

let g:which_key_map['e'] = {
      \ 'name' : '+Explorer',
      \ 'e': 'open file explorer',
      \ 'p': 'open file explorer of project root',
      \ 'f': 'open file explorer and locate current buffer',
      \ 'd': 'open db connector',
      \ 'q': 'open quickfix list',
      \ 't': 'open tagbar',
      \ 'g': 'open fugitive',
      \ 's': 'open startify',
      \ }

let g:which_key_map['f'] = {
      \ 'name' : '+Format/Fix',
      \ 'f': 'fix by ale',
      \ 't': 'show one or all warnings',
      \ }


let g:which_key_map['g'] = {
      \ 'name' : '+Git/version-control',
      \ 'g': 'open fugitive',
      \ 'd': 'perform a vimdiff against the current buffer',
      \ 'b': 'run git-blame on the current file',
      \ 'l': 'open git log of current buffer',
      \ 'L': 'open git log',
      \ }

let g:which_key_map['h'] = {
      \ 'name' : '+Hunk',
      \ 'p' : ['<Plug>(GitGutterPreviewHunk)', 'preview hunk'],
      \ 's' : ['<Plug>(GitGutterStageHunk)',   'stage hunk'],
      \ 'u' : ['<Plug>(GitGutterUndoHunk)',    'undo hunk'],
      \ }

let g:which_key_map['r'] = {
      \ 'name' : '+Run',
      \ 'r' : 'run repl',
      \ 'k' : 'run repl but keep focus on current window',
      \ 'l' : 'hot reload repl',
      \ }

let g:which_key_map['s'] = {
      \ 'name' : '+Search',
      \ ' ': 'search with ripgrep',
      \ '/': 'search Search hisotry',
      \ ':': 'search Command history',
      \ 'd': 'search Dependencies',
      \ 'l': 'search Library',
      \ 'g': 'search in gems',
      \ 'p': 'search in project',
      \ 't': 'search <cword> in tags',
      \ 'w': 'search in cwd',
      \ 'b': 'search lines in the current buffer',
      \ 's': 'search available Sessions',
      \ }

let g:which_key_map['w'] = {
      \ 'name' : '+Wiki/Window',
      \ '1' : 'window-1'  ,
      \ '2' : 'window-2'  ,
      \ '3' : 'window-3'  ,
      \ '4' : 'window-4'  ,
      \ '5' : 'window-5'  ,
      \ '6' : 'window-6'  ,
      \ '7' : 'window-7'  ,
      \ '8' : 'window-8'  ,
      \ '9' : 'window-9'  ,
      \ 'l' : {
        \   'name' : '+wiki-link',
        \ }
      \ }

let g:which_key_map['t'] = {
      \ 'name' : '+Terminal',
      \ 't' : 'open terminal horizontal',
      \ 'v' : 'open terminal vertical',
      \ }

let g:which_key_map_visual = {}

let g:which_key_map_visual['y'] = 'yank to clipboard'

let g:which_key_map_visual['h'] = {
      \ 'name' : '+Hunk',
      \ 's' : ['<Plug>(GitGutterStageHunk)',   'stage hunk'],
      \ }

let g:which_key_map_visual['g'] = {
      \ 'name' : '+Git/version-control',
      \ 'b': 'run git-blame on the current file',
      \ 'l': 'open git log of selected lines',
      \ }

let g:which_key_map_visual['s'] = {
      \ 'name' : '+Search',
      \ ' ': 'search selected with ripgrep',
      \ 'g': 'search selected in gems',
      \ 'p': 'search selected in project',
      \ 'w': 'search selected in cwd',
      \ }

call which_key#register('<Space>', "g:which_key_map", 'n')
call which_key#register('<Space>', "g:which_key_map_visual", 'v')
