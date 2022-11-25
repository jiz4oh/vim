augroup vim-dispatch-autocmd
  autocmd!
  
  autocmd FileType vim let b:start = 'vim -E' | let b:dispatch = ':source %:p'
  autocmd BufReadPost *
      \ if getline(1) =~# '^#!' |
      \   let b:dispatch =
      \       matchstr(getline(1), '#!\%(/usr/bin/env \+\)\=\zs.*') . ' %:p:S' |
      \   let b:start = '-wait=always ' . b:dispatch |
      \ endif
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

xnoremap <silent><buffer> `<CR> :Dispatch<cr>
xnoremap <silent><buffer> g'<CR> :Spawn<cr>
