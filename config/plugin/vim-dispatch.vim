autocmd FileType ruby
      \ if !exists('b:rails_root') && !exists('b:start') |
      \   let b:start = executable('pry') ? 'pry -r %:p:S' : 'irb -r %:p:S' |
      \ endif |
      \ if exists('b:rails_root') || exists('b:dispatch') |
      " \ elseif expand('%') =~# '_test\.rb$' |
      " \   let b:dispatch = 'testrb %' |
      \ elseif expand('%') =~# '_spec\.rb$' |
      \   let b:dispatch = get(b:, 'dispatch', 'rspec %:s/$/\=exists("l#") ? ":".l# : ""/') |
      \ elseif join(getline(max([line('$')-8,1]), '$'), "\n") =~# '\$0\>' |
      \   let b:dispatch = 'ruby %' |
      \ elseif !exists('b:dispatch') |
      \   let b:dispatch = 'ruby -wc %' |
      \ endif
