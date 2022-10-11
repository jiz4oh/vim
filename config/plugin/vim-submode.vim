" " https://ddrscott.github.io/blog/2016/making-a-window-submode/ {{{
" " A message will appear in the message line when you're in a submode
" " and stay there until the mode has existed.
" let g:submode_always_show_submode = 1

" let g:submode_keep_leaving_key = 1
" " We're taking over the default <C-w> setting. Don't worry we'll do
" " our best to put back the default functionality.
" call submode#enter_with('window', 'n', '', '<c-w><leader>')

" " Note: <C-c> will also get you out to the mode without this mapping.
" " Note: <C-[> also behaves as <ESC>
" call submode#leave_with('window', 'n', '', '<ESC>')

" " Go through symbols. Sadly, '|', not supported in submode plugin.
" for key in ['=','_']
"   call submode#map('window', 'n', '', key, '<C-w>' . key)
" endfor

" " <lowercase-pipe> sets the width to 80 columns, pipe (<S-\>) by default
" " maximizes the width.
" call submode#map('window', 'n', '', '\', ':vertical resize 80<CR>')

" " Resize faster
" call submode#map('window', 'n', '', '+', '3<C-w>+')
" call submode#map('window', 'n', '', '-', '3<C-w>-')
" call submode#map('window', 'n', '', '<', '10<C-w><')
" call submode#map('window', 'n', '', '>', '10<C-w>>')
" " }}}
