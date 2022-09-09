let g:ale_set_quickfix = 0
let g:ale_set_loclist = 0

let g:ale_linters = {
      \   'java': [],
      \   'scala': [],
      \   'clojure': [],
      \   'python': ['flake8', 'pylint',],
      \   'vim': ['vint',],
      \   'go': ['gofmt',]
      \}

let g:ale_fixers = {
      \   '*': ['remove_trailing_lines', 'trim_whitespace'],
      \   'json': ['fixjson', 'jq', 'remove_trailing_lines', 'trim_whitespace'],
      \   'ruby': ['rubocop'],
      \   'python': ['black', 'isort', 'remove_trailing_lines', 'trim_whitespace'],
      \   'sh': ['shfmt', ],
      \   'md': ['prettier', ],
      \   'go': ['gofmt', ]
      \}

let g:ale_dockerfile_hadolint_use_docker = 'yes'
let g:ale_ruby_rubocop_auto_correct_all  = 1

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

let g:ale_virtualtext_cursor             = 2
let g:ale_virtualtext_prefix             = ' ◉  '

highlight! link ALEVirtualTextError ALEErrorSign
highlight! link ALEVirtualTextWarning ALEWarningSign

nmap ]a <Plug>(ale_next_wrap)
nmap [a <Plug>(ale_previous_wrap)

nmap <leader>ff <Plug>(ale_fix)

if has('nvim')
  autocmd VimEnter * lua vim.diagnostic.disable()
endif

au BufRead,BufNewFile */.github/*/*.y{,a}ml
    \ let b:ale_linters = {'yaml': ['actionlint']}
