augroup vim_dispatch_improved
  autocmd!
  
  autocmd BufReadPost *
      \ if getline(1) =~# '^#!' |
      \   let b:dispatch =
      \       matchstr(getline(1), '#!\%(/usr/bin/env \+\)\=\zs.*') . ' %:S' |
      \   let b:start = '-wait=always ' . b:dispatch |
      \ endif
  autocmd FileType ruby
        \ if !exists('b:rails_root') && !exists('b:start') |
        \   let b:start = executable('pry') ? 'pry -r %:p:S' : 'irb -r %:p:S' |
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
