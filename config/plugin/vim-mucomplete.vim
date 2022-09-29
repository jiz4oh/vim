set complete-=i complete-=t
let g:peekaboo_ins_prefix = '<c-x>'

let g:mucomplete#enable_auto_at_startup = 0
let g:mucomplete#no_mappings            = 1

let g:mucomplete#completion_delay       = 300
let g:mucomplete#reopen_immediately     = 0
let g:mucomplete#cycle_with_trigger     = 1

let g:mucomplete#chains                 = {
      \ 'default' : { 'default': ['path', 'omni', 'c-n', 'incl', 'tags', 'uspl'],
	    \               '.*comment.*': ['uspl']
      \ },
      \ 'vim'     : ['path', 'cmd', 'keyn']
      \ }

if has('patch-8.0.0283')
  inoremap <expr> <cr> pumvisible() ? "<c-y><cr>" : "<cr>"
else
  imap <expr> <cr> pumvisible() ? "<c-y><plug>(MUcompleteCR)"
	                              : "<plug>(MUcompleteCR)"
endif
