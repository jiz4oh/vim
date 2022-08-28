nnoremap <silent> <leader> :WhichKey '<Space>'<CR>
vnoremap <silent> <leader> :<c-u>WhichKeyVisual '<Space>'<CR>

let g:which_key_map = {}

let g:which_key_map['/'] = 'clear highlight'
let g:which_key_map[' '] = {
      \ 'name' : '+Easymotion ' ,
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
      \ 'name' : '+lsp',
      \ }
endif

let g:which_key_map['e'] = {
      \ 'name' : '+explorer',
      \ 'e': 'open file explorer',
      \ 'p': 'open file explorer of project root',
      \ 'f': 'open file explorer and locate current buffer',
      \ 'd': 'open db connector',
      \ 'q': 'open quickfix list',
      \ 't': 'open tagbar',
      \ 'g': 'open fugitive',
      \ }

let g:which_key_map['f'] = {
      \ 'name' : '+format/fix',
      \ 'f': 'fix by ale',
      \ }


let g:which_key_map['g'] = {
      \ 'name' : '+git/version-control',
      \ 'g': 'open fugitive',
      \ 'd': 'perform a vimdiff against the current buffer',
      \ 'b': 'run git-blame on the current file',
      \ 'l': 'load the commit history into the location list',
      \ 'v': 'open commit history of current buffer',
      \ 'V': 'open commit history',
      \ }

let g:which_key_map['h'] = {
      \ 'name' : '+hunk',
      \ 'p' : ['<Plug>(GitGutterPreviewHunk)', 'preview hunk'],
      \ 's' : ['<Plug>(GitGutterStageHunk)',   'stage hunk'],
      \ 'u' : ['<Plug>(GitGutterUndoHunk)',    'undo hunk'],
      \ }

let g:which_key_map['s'] = {
      \ 'name' : '+search',
      \ ' ': 'search with ripgrep',
      \ 'g': 'search in gems',
      \ 'p': 'search in project',
      \ 't': 'search <cword> in tags',
      \ 'w': 'search in cwd',
      \ 'b': 'search lines in the current buffer',
      \ }

let g:which_key_map['w'] = {
      \ 'name' : '+wiki',
      \ 'l' : {
        \   'name' : '+wiki-link',
        \ }
      \ }

let g:which_key_map['t'] = {
      \ 'name' : '+terminal',
      \ 't' : 'open terminal horizontal',
      \ 'v' : 'open terminal vertical',
      \ }

let g:which_key_map_visual = {}

let g:which_key_map_visual['h'] = {
      \ 'name' : '+hunk',
      \ 's' : ['<Plug>(GitGutterStageHunk)',   'stage hunk'],
      \ }

let g:which_key_map_visual['g'] = {
      \ 'name' : '+git/version-control',
      \ 'b': 'run git-blame on the current file',
      \ 'l': 'load the commit history into the location list',
      \ 'v': 'open commit history of selected lines',
      \ }

let g:which_key_map_visual['s'] = {
      \ 'name' : '+search',
      \ ' ': 'search selected with ripgrep',
      \ 'g': 'search selected in gems',
      \ 'p': 'search selected in project',
      \ 'w': 'search selected in cwd',
      \ }

call which_key#register('<Space>', "g:which_key_map", 'n')
call which_key#register('<Space>', "g:which_key_map_visual", 'v')

