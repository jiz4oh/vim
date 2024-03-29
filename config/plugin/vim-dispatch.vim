augroup vim-dispatch-autocmd
  autocmd!
  
  autocmd BufNewFile,BufRead Dockerfile* let b:dispatch = 'docker build %:p:h -t %:p:h:t:gs/.*/\L&/:S'
  autocmd FileType mysql,sql let b:start = ':DB'
  autocmd BufReadPost *
      \ if getline(1) =~# '^#!' |
      \   let b:dispatch = get(b:, 'dispatch',
      \       matchstr(getline(1), '#!\%(/usr/bin/env \+\)\=\zs.*') . ' %:p:S' ) |
      \   let b:start = get(b:, 'start', '-wait=always ' . b:dispatch) |
      \ endif
  autocmd FileType python let b:dispatch = 'python -m py_compile %:p:S'

  if executable('ipython')
    autocmd FileType python let b:start = 'ipython'
  else
    autocmd FileType python let b:start = 'python'
  endif

  autocmd FileType ruby
        \ if !exists('b:rails_root') && !exists('b:start') |
        \   let b:start = 'irb -r %:p:S' |
        \ endif |
        \ if exists('b:rails_root') || exists('b:dispatch') |
        \ elseif expand('%') =~# '_spec\.rb$' |
        \   let b:dispatch = get(b:, 'dispatch', 'rspec %:s/$/\=exists("l#") ? ":".l# : ""/') |
        \ elseif join(getline(max([line('$')-8,1]), '$'), "\n") =~# '\$0\>' |
        \   let b:dispatch = 'ruby %' |
        \ elseif !exists('b:dispatch') |
        \   let b:dispatch = 'ruby -wc %' |
        \ endif
augroup END

xnoremap `!                :Dispatch!
xnoremap `<CR>             :Dispatch<cr>
xnoremap m<CR>             :Make<cr>
xnoremap g'!               :Spawn!
xnoremap g'<CR>            :Spawn<cr>
nnoremap <leader>t'<space> :tab Start<space>
nnoremap <leader>t'<CR>    :tab Start<cr>

if !exists('g:dispatch_compilers')
  let g:dispatch_compilers = {}
endif

let g:dispatch_compilers = {
      \}
