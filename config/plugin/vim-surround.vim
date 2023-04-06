augroup vim-surround-augroup
  autocmd! 

  function! s:surround_rb() abort
    " i
    let b:surround_105 = "if \1if: \1 \r end" |
    " u
    let b:surround_117 = "unless \1unless: \1 \r end" |
    " w
    let b:surround_119 = "while \1while: \1 do \r end" |
    " e
    let b:surround_101 = "\r\nend" |
    " <C-E>
    let b:surround_5 = "\r\nend" |
    " E
    let b:surround_69 = "\1expr: \1\rend" |
    " m
    let b:surround_109 = "module \r end" |
    " d
    let b:surround_100 = "do\n \r end"
  endfunction

  autocmd FileType ruby call s:surround_rb()

  function! s:surround_erb() abort
    " -
    let b:surround_45 = "<% \r %>" |
    " =
    let b:surround_61 = "<%= \r %>" |
    " t
    let b:surround_116 = "<%=t '\r' %>" |
    " #
    let b:surround_35 = "<%=# \r %>" |
    " surround area with <% <foo> (...) do %> <% end %>
    " i
    let b:surround_105 = "<% if \1<% if: \1 %> \r <% end %>" |
    " u
    let b:surround_117 = "<% unless \1<% unless: \1 %> \r <% end %>" |
    " w
    let b:surround_119 = "<% while \1<% while: \1 do %> \r <% end %>" |
    " e
    let b:surround_101 = "<% \r %>\n<% end %>" |
    " <C-E>
    let b:surround_5 = "<% \r %>\n<% end %>" |
    " E
    let b:surround_69 = "\1expr: \1\rend" |
    " d
    let b:surround_100 = "<% do %> \r <% end %>"
  endfunction

  autocmd FileType eruby call s:surround_erb()

  function! s:surround_python() abort
    let b:surround_{char2nr("v")} = "{{ \r }}"
    let b:surround_{char2nr("{")} = "{{ \r }}"
    let b:surround_{char2nr("%")} = "{% \r %}"
    let b:surround_{char2nr("b")} = "{% block \1block name: \1 %}\r{% endblock \1\1 %}"
    let b:surround_{char2nr("i")} = "{% if \1condition: \1 %}\r{% endif %}"
    let b:surround_{char2nr("w")} = "{% with \1with: \1 %}\r{% endwith %}"
    let b:surround_{char2nr("f")} = "{% for \1for loop: \1 %}\r{% endfor %}"
    let b:surround_{char2nr("c")} = "{% comment %}\r{% endcomment %}"
  endfunction

  autocmd FileType python call s:surround_python()
augroup END


