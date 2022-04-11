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
let g:NERDTreeMapOpenRecursively  = 'L'
let g:NERDTreeMapCloseChildren    = 'H'
" 回到上一级目录
let g:NERDTreeMapUpdirKeepOpen    = '<backspace>'

" copy from https://github.com/SpaceVim/SpaceVim/blob/master/config/plugins/nerdtree.vim
augroup nerdtree_zvim
  autocmd!
  " Exit Vim if NERDTree is the only window remaining in the only tab.
  autocmd BufEnter *
        \ if (winnr('$') == 1 && exists('b:NERDTree')
        \ && b:NERDTree.isTabTree())
        \|   q
        \| endif
  autocmd FileType nerdtree call s:nerdtreeinit()
augroup END

function! s:nerdtreeinit() abort
  nnoremap <silent><buffer> h  :<C-u>call <SID>nerdtree_h()<CR>
  nnoremap <silent><buffer> l  :<C-u>call <SID>nerdtree_l()<CR>
  nnoremap <silent><buffer> <Left>  :<C-u>call <SID>nerdtree_h()<CR>
  nnoremap <silent><buffer> <Right>  :<C-u>call <SID>nerdtree_l()<CR>
  nnoremap <silent><buffer> N  :<C-u>call NERDTreeAddNode()<CR>
  nnoremap <silent><buffer> d  :<C-u>call NERDTreeDeleteNode()<CR>
  nnoremap <silent><buffer> . :<C-u>call <SID>nerdtree_dot()<CR>
  nnoremap <silent><buffer> <C-Home> :<C-u>NERDTreeCWD<CR>
  nnoremap <silent><buffer> <CR> :<C-u>call <SID>nerdtree_enter()<CR>
  nnoremap <silent><buffer> <Home> :call cursor(2, 1)<cr>
  nnoremap <silent><buffer> <End>  :call cursor(line('$'), 1)<cr>
endfunction

function! s:nerdtree_h() abort
  if !empty(g:NERDTree.ForCurrentTab()) && g:NERDTree.ForCurrentTab().getRoot().path.str()
        \ ==# g:NERDTreeFileNode.GetSelected().path.getParent().str()
    silent! exe 'NERDTree' g:NERDTreeFileNode.GetSelected().path.getParent().getParent().str()
  else
    call g:NERDTreeKeyMap.Invoke('p')
    call g:NERDTreeKeyMap.Invoke('o')
  endif
endfunction

function! s:nerdtree_l() abort
  let path = g:NERDTreeFileNode.GetSelected().path.str()
  if isdirectory(path)
    if matchstr(getline('.'), 'S') ==# g:NERDTreeDirArrowCollapsible
      normal! gj
    else
      call g:NERDTreeKeyMap.Invoke('o')
      normal! gj
    endif
  else
    call g:NERDTreeKeyMap.Invoke('o')
  endif
endfunction

function! s:nerdtree_dot() abort
  call g:NERDTreeKeyMap.Invoke('I')
endfunction

function! s:nerdtree_enter() abort
  let path = g:NERDTreeFileNode.GetSelected().path.str()
  if isdirectory(path)
    silent! exe 'NERDTree' g:NERDTreeFileNode.GetSelected().path.str()
  else
    call g:NERDTreeKeyMap.Invoke('o')
  endif
endfunction

" Navigation
map  <expr> <leader>e g:NERDTree.IsOpen() ? ":NERDTreeClose\<CR>" : ":NERDTreeMirror\<CR>:NERDTreeFind\<CR>"
map  <F1> :NERDTreeToggle<CR>
map! <F1> :NERDTreeToggle<CR>
