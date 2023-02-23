let g:NERDTreeGitStatusUseNerdFonts = get(g:, 'enable_nerd_font', 0)

let NERDTreeMinimalMenu      = 1 " https://github.com/preservim/nerdtree/issues/1321
let NERDTreeMinimalUI        = 1 " 最小化显示，不显示问号
let NERDTreeDirArrows        = 1
let NERDChristmasTree        = 1
" 如果使用vim-plug的话，加上这一句可以避免光标在nerdtree
" 中的时候进行插件升级而导致nerdtree崩溃
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeQuitOnOpen       = 1
" 进入目录自动将workspace更改为此目录
let g:NERDTreeChDirMode      = 2
let g:NERDTreeUseTCD         = 1

"remove e mapping
let g:NERDTreeMapOpenExpl         = ''
let g:NERDTreeMapOpenSplit        = "<C-X>"
let g:NERDTreeMapOpenVSplit       = "<C-V>"
let g:NERDTreeMapOpenRecursively  = 'L'
let g:NERDTreeMapCloseChildren    = 'H'
" 回到上一级目录
let g:NERDTreeMapUpdirKeepOpen    = '<backspace>'

augroup nerd_loader
  autocmd!
  autocmd VimEnter * silent! autocmd! FileExplorer
  autocmd BufEnter,BufNew *
        \  if isdirectory(expand('<amatch>'))
        \|   call plug#load('nerdtree')
        \|   execute 'autocmd! nerd_loader'
        \| endif

  " If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
  autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
      \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif
augroup END

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

" Function to open the file or NERDTree or netrw.
"   Returns: 1 if either file explorer was opened; otherwise, 0.
function! s:OpenFileOrExplorer(...)
  let edit_cmd = a:2 ? 'edit!' : 'edit'
  
  if a:0 == 0 || a:1 == ''
    " open NERDTree if current buffer is not a persisted file
    if empty(expand('%'))
      execute ':NERDTree' . personal#project#find_home()
    else
      " :Edit  "behave like edit
      " :Edit! "behave like edit
      execute edit_cmd
    endif
  elseif filereadable(expand(a:1))
    " :Edit  {file}  "behave like edit
    " :Edit! {file}  "behave like edit
    execute edit_cmd . ' ' . expand(a:1)
    return 0
  elseif a:1 =~? '^\(scp\|ftp\)://' " Add other protocols as needed.
    execute 'Vexplore '. a:1
  elseif isdirectory(expand(a:1))
    " :Edit {dir} " open NERDTree
    execute 'NERDTree '. expand(a:1)
  else
    return 0
  endif
  return 1
endfunction

function! s:nerdtreeinit() abort
  nnoremap <silent><buffer> h             :<C-u>call <SID>nerdtree_h()<CR>
  nnoremap <silent><buffer> l             :<C-u>call <SID>nerdtree_l()<CR>
  nnoremap <silent><buffer> <Left>        :<C-u>call <SID>nerdtree_h()<CR>
  nnoremap <silent><buffer> <Right>       :<C-u>call <SID>nerdtree_l()<CR>
  nnoremap <silent><buffer> <C-N>         :<C-u>call NERDTreeAddNode()<CR>
  nnoremap <silent><buffer> dd            :<C-u>call NERDTreeDeleteNode()<CR>
  nnoremap <silent><buffer> <CR>          :<C-u>call <SID>nerdtree_enter()<CR>
  nnoremap <silent><buffer> <Home>        :call cursor(2, 1)<cr>
  nnoremap <silent><buffer> <End>         :call cursor(line('$'), 1)<cr>
  nnoremap <silent><buffer> <leader>ef    :wincmd w <CR>:NERDTreeFind<CR>
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

function! s:nerdtree_enter() abort
  let path = g:NERDTreeFileNode.GetSelected().path.str()
  if isdirectory(path)
    silent! exe 'NERDTree' g:NERDTreeFileNode.GetSelected().path.str()
  else
    call g:NERDTreeKeyMap.Invoke('o')
  endif
endfunction

nnoremap <silent><expr> <leader>ep ':NERDTree ' . personal#project#find_home() . '<cr>'
" Navigation
nmap  <silent> <leader>ee :NERDTreeToggle<CR>
nmap  <silent> <leader>ef :NERDTreeFind<CR>
nmap  <silent> <special> <F2> :NERDTreeToggle<CR>

" Command to call the OpenFileOrExplorer function.
command! -n=? -complete=file -bar -bang E    :call <SID>OpenFileOrExplorer('<args>', <bang>0)
command! -n=? -complete=file -bar -bang Edit :call <SID>OpenFileOrExplorer('<args>', <bang>0)

map! <silent> <special> <F2> <esc>:<c-u>NERDTreeToggle<CR>
