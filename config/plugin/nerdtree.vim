let g:NERDTreeGitStatusIndicatorMapCustom = {
  \ "Modified"  : "✹",
  \ "Staged"    : "✚",
  \ "Untracked" : "✭",
  \ "Renamed"   : "➜",
  \ "Unmerged"  : "═",
  \ "Deleted"   : "✖",
  \ "Dirty"     : "✗",
  \ "Clean"     : "✔︎",
  \ 'Ignored'   : '☒',
  \ "Unknown"   : "?"
  \ }

let NERDTreeMinimalUI = 1 " 最小化显示，不显示问号
let NERDTreeDirArrows = 1
let NERDChristmasTree = 1
" 如果使用vim-plug的话，加上这一句可以避免光标在nerdtree
" 中的时候进行插件升级而导致nerdtree崩溃
let NERDTreeAutoDeleteBuffer = 1
" 进入目录自动将workspace更改为此目录
let g:NERDTreeChDirMode = 2

"remove e mapping
let g:NERDTreeMapOpenExpl         = ''
let g:NERDTreeMapOpenSplit        = "<C-X>"
let g:NERDTreeMapOpenVSplit       = "<C-V>"
let g:NERDTreeMapActivateNode     = 'l'
let g:NERDTreeMapPreview          = 'gp'
let g:NERDTreeMapOpenRecursively  = 'L'
let g:NERDTreeMapCloseDir         = 'h'
let g:NERDTreeMapCloseChildren    = 'H'
let g:NERDTreeMapToggleHidden     = '.'
" 回到上一级目录
let g:NERDTreeMapUpdirKeepOpen    = '<backspace>'

function! s:NERDTreeCustomCROpen(node) abort
  let l:newRoot = a:node.GetSelected()

  if l:newRoot.path.isDirectory
    call b:NERDTree.changeRoot(l:newRoot)
  else
    call l:newRoot.activate({'reuse': 'all', 'where': 'p'})
  endif
endfunction

augroup nerdtree_group
  " Exit Vim if NERDTree is the only window remaining in the only tab.
  autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

  autocmd FileType nerdtree nmap <buffer> <CR> bb
  if exists('*NERDTreeAddKeyMap')
    autocmd VimEnter * call NERDTreeAddKeyMap({
        \ 'key': 'bb',
        \ 'callback': function('<SID>NERDTreeCustomCROpen'),
        \ 'quickhelpText': 'go to dir and change cwd to it or open a file',
        \ 'scope': 'Node',
        \ 'override': 1,
        \ })
  endif
augroup END

" Navigation
map  <expr> <leader>e g:NERDTree.IsOpen() ? ":NERDTreeClose\<CR>" : ":NERDTreeMirror\<CR>:NERDTreeFind\<CR>"
map  <F1> :NERDTreeToggle<CR>
map! <F1> :NERDTreeToggle<CR>
