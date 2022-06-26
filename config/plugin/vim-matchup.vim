let g:matchup_delim_noskips              = 1
" enable Parallel transmutation
let g:matchup_transmute_enabled          = 1

if has('nvim') || has('patch-8.1.1406')
  let g:matchup_matchparen_offscreen = {
        \'method': 'popup',
        \'fullwidth': 1
        \}
endif
