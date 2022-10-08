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
let g:which_key_map['y']  = 'Yank {motion} to clipboard'
let g:which_key_map['yy'] = 'Yank current line to clipboard'
let g:which_key_map['Y']  = 'Yank from the cursor to the end of line to clipboard'

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
      \ 'c' : ['SClose', 'Close Session and open startify'],
      \}

let g:which_key_map['e'] = {
      \ 'name' : '+Explorer',
      \ 'e': 'open file Explorer',
      \ 'p': 'open file explorer of Project root',
      \ 'f': 'open file explorer and locate current buffer',
      \ 'd': 'open Db connector',
      \ 'q': 'open Quickfix list',
      \ 't': 'open Tagbar',
      \ 'g': 'open fugitive',
      \ 's': 'open Startify',
      \ }

let g:which_key_map['f'] = {
      \ 'name' : '+Format/Fix',
      \ 'f': 'Fix by ale',
      \ 't': 'show one or all warnings',
      \ }


let g:which_key_map['g'] = {
      \ 'name' : '+Git/version-control',
      \ 'g': 'open fugitive',
      \ 'd': 'perform a vimDiff against the current buffer',
      \ 'b': 'run git-Blame on the current file',
      \ 'l': 'open git Log of current buffer',
      \ 'L': 'open git Log',
      \ 'x': 'open the current file, blob, tree, commit, or tag in your browser',
      \ }

let g:which_key_map['h'] = {
      \ 'name' : '+Hunk',
      \ 'p' : ['<Plug>(GitGutterPreviewHunk)', 'Preview Hunk'],
      \ 's' : ['<Plug>(GitGutterStageHunk)',   'Stage Hunk'],
      \ 'u' : ['<Plug>(GitGutterUndoHunk)',    'Undo Hunk'],
      \ }

let g:which_key_map['r'] = {
      \ 'name' : '+Run',
      \ 'r' : 'Run Repl',
      \ 'k' : 'Run repl but Keep focus on current window',
      \ 'l' : 'hot reLoad Repl',
      \ }

let g:which_key_map['s'] = {
      \ 'name' : '+Search',
      \ ' ': 'Search with ripgrep',
      \ '/': 'Search search hisotry',
      \ ':': 'Search command history',
      \ 'd': 'Search Dependencies',
      \ 'l': 'Search Library',
      \ 'g': 'Search in Gems',
      \ 'p': 'Search in Project',
      \ 't': 'Search <cword> in Tags',
      \ 'w': 'Search in cWd',
      \ 'b': 'Search lines in the current Buffer',
      \ 's': 'Search available Sessions',
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
      \ 't' : 'open Terminal horizontal',
      \ 'v' : 'open Terminal Vertical',
      \ }

let g:which_key_map_visual = {}

let g:which_key_map_visual['y'] = 'Yank to clipboard'

let g:which_key_map_visual['h'] = {
      \ 'name' : '+Hunk',
      \ 's' : ['<Plug>(GitGutterStageHunk)',   'Stage Hunk'],
      \ }

let g:which_key_map_visual['g'] = {
      \ 'name' : '+Git/version-control',
      \ 'b': 'run git-Blame on the current file',
      \ 'l': 'open git Log of selected lines',
      \ 'x': 'open the selected lines in your browser',
      \ }

let g:which_key_map_visual['s'] = {
      \ 'name' : '+Search',
      \ ' ': 'Search selected with ripgrep',
      \ 'g': 'Search selected in Gems',
      \ 'p': 'Search selected in Project',
      \ 'w': 'Search selected in cWd',
      \ }

call which_key#register('<Space>', "g:which_key_map", 'n')
call which_key#register('<Space>', "g:which_key_map_visual", 'v')
