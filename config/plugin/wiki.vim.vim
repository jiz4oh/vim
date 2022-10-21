let g:wiki_filetypes          = ['md', 'wiki']
let g:wiki_link_extension     = '.md'
let g:wiki_link_target_type   = 'md'
let g:wiki_global_load        = 0

let g:wiki_journal = {
      \ 'name': 'journal',
      \ 'frequency': 'daily',
      \ 'date_format': {
      \   'daily' : '%Y/%m/%d',
      \   'weekly' : '%Y/week_%V',
      \   'monthly' : '%Y/%m/summary',
      \ },
      \ 'index_use_journal_scheme': v:true,
      \}

let g:wiki_map_text_to_link = 'MyTextToLink'
function MyTextToLink(text) abort
  return [substitute(tolower(a:text), '\s\+', '-', 'g'), a:text]
endfunction

if exists('g:notes_root')
  let g:wiki_root = g:notes_root
endif

