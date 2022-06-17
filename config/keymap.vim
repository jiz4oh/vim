vnoremap <silent> // :<C-u>execute '/'.personal#functions#escape_for_regexp(personal#functions#selected())<CR>
vnoremap <silent> ?? :<C-u>execute '?'.personal#functions#escape_for_regexp(personal#functions#selected())<CR>

