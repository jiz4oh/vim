let g:ale_set_quickfix = 0
let g:ale_set_loclist = 0

let g:ale_linters = {
      \   'java': [],
      \   'scala': [],
      \   'clojure': [],
      \   'python': ['flake8', 'pylint', 'ruff'],
      \   'ruby': ['ruby', 'rubocop', 'solargraph'],
      \   'vim': ['vint',],
      \   'go': ['gofmt',]
      \}

let g:ale_fixers = {
      \   '*': ['remove_trailing_lines', 'trim_whitespace', 'autocorrect'],
      \   'json': ['fixjson', 'jq', 'autocorrect', 'remove_trailing_lines', 'trim_whitespace'],
      \   'yaml': ['prettier', 'autocorrect'],
      \   'javascript': ['prettier-eslint', 'remove_trailing_lines', 'trim_whitespace', 'autocorrect'],
      \   'html': ['prettier-eslint'],
      \   'css': ['stylelint'],
      \   'scss': ['stylelint'],
      \   'sass': ['stylelint'],
      \   'python': ['ruff', 'black', 'isort', 'remove_trailing_lines', 'trim_whitespace'],
      \   'ruby': ['rubocop'],
      \   'sh': ['shfmt', ],
      \   'md': ['prettier', 'autocorrect'],
      \   'go': ['gofmt', ],
      \   'eruby': ['erblint', 'remove_trailing_lines', 'trim_whitespace']
      \}

let g:ale_use_global_executables = 1

let g:ale_dockerfile_hadolint_use_docker = 'yes'

let g:ale_lint_on_text_changed           = 'always'
let g:ale_lint_delay                     = 750

let g:ale_disable_lsp                    = 1
let g:ale_detail_to_floating_preview     = 1

let g:ale_sign_info                      = "I"
let g:ale_sign_warning                   = "W"
let g:ale_sign_error                     = "E"
let g:ale_echo_msg_warning_str           = 'W'
let g:ale_echo_msg_error_str             = 'E'
let g:ale_echo_msg_format                = '[%severity%] [%linter%] %s'

let g:ale_virtualtext_cursor             = 1
let g:ale_virtualtext_prefix             = '  ◉ '

highlight! link ALEVirtualTextError Comment
highlight! link ALEVirtualTextWarning Comment

function! s:toggle_virtualtext_cursor() abort
  if g:ale_virtualtext_cursor == 1
    let g:ale_virtualtext_cursor = 2
    ALEDisableBuffer | ALEEnableBuffer
    echomsg 'all warnings be shown'
  else
    let g:ale_virtualtext_cursor = 1
    ALEDisableBuffer | ALEEnableBuffer
    echomsg 'message will be shown when a cursor is near a warning or error'
  endif
endfunction

function! s:activate_ale_by_projectionist() abort
  for [_root, options] in projectionist#query('ale')
    if type(options) == type({})
      for [name, value] in items(options)
        call setbufvar(bufnr(), 'ale_' . name, value)
      endfor
    endif
  endfor
endfunction

nmap ]a <Plug>(ale_next_wrap)
nmap [a <Plug>(ale_previous_wrap)

nmap <leader>ff <Plug>(ale_fix)

nmap <silent> <leader>ft :call <SID>toggle_virtualtext_cursor()<cr>

augroup ale_augroup
  autocmd!

  if has('nvim')
    autocmd VimEnter * lua vim.diagnostic.disable()
  endif

  autocmd User ProjectionistActivate call s:activate_ale_by_projectionist()
augroup END
