let g:rails_vim_enter         = 0

" rails decorator
let g:rails_projections = {
      \  "app/admin/*.rb": {
      \    "command": "admin",
      \    "affinity": "model",
      \    "alternate": "app/models/{}.rb",
      \    "template": "ActiveAdmin.register {} do\nend"
      \  },
      \}

" autocmd FileType ruby
"       \ vnoremap <silent> <buffer> dr :<C-u>execute ":Runner ". shellescape(substitute(personal#functions#selected(), '#{', '\#{', 'g')) . ""<CR>

autocmd FileType ruby
      \ if !empty(rails#app())|call <SID>setup_zepl()|endif

autocmd User Rails call <SID>setup_rails()

function! s:setup_rails() abort
  nnoremap <silent><buffer> `<CR> :Rails<cr>
  xnoremap <silent><buffer> `<CR> :Rails<cr>
endfunction

function! s:setup_zepl() abort
  if empty(get(b:, 'start', ''))
    let b:repl_config = { 'cmd': 'rails console' }
  endif

  nnoremap <silent><buffer> <leader>rl :ReplSend reload!<cr>
endfunction

function! s:ac() abort
  let pre = &confirm
  try
    set confirm
    A
  finally
    let &confirm = pre
  endtry
endfunction

command! AC :call <SID>ac()
