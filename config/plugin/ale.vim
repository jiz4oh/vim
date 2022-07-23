let g:ale_disable_lsp                = 1

let g:ale_detail_to_floating_preview = 1

let g:ale_sign_info                  = "I"
let g:ale_sign_warning               = "W"
let g:ale_sign_error                 = "E"
let g:ale_echo_msg_warning_str       = 'W'
let g:ale_echo_msg_error_str         = 'E'
let g:ale_echo_msg_format            = '[%linter%] [%severity%] %s'

let g:ale_virtualtext_cursor         = 1
let g:ale_virtualtext_prefix         = ' ◉  '

highlight! link ALEVirtualTextError ALEErrorSign
highlight! link ALEVirtualTextWarning ALEWarningSign
