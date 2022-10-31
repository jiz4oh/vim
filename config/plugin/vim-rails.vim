let g:rails_vim_enter         = 0

" rails decorator
let g:rails_projections = {
      \  "app/admin/*.rb": {
      \    "command": "admin",
      \    "affinity": "model",
      \    "alternate": "app/models/{}.rb",
      \    "template": "ActiveAdmin.register {} do\nend"
      \  },
      \  "app/controllers/*_controller_decorator.rb": {
      \    "command":  "controller_decorator",
      \    "affinity": "controller",
      \    "alternate": "app/controllers/{}.rb",
      \    "template": [
      \      "class {camelcase|capitalize|colons}ControllerDecorator",
      \      "\tdef self.prepended(base)",
      \      "\t\tbase.class_eval do",
      \      "\t\tend",
      \      "\tend",
      \      "",
      \      "\t{camelcase|capitalize|colons}Controller.prepend self",
      \      "end"
      \    ],
      \    "type": "controller"
      \  },
      \  "app/controllers/concerns/*_decorator.rb": {
      \    "affinity": "controller",
      \    "template": [
      \      "module {camelcase|capitalize|colons}",
      \      "\tinclude ActiveSupport::Concern",
      \      "end"
      \    ],
      \    "type": "controller"
      \  },
      \  "app/helpers/*_helper_decorator.rb": {
      \    "affinity": "controller",
      \    "template": ["module {camelcase|capitalize|colons}Helper", "end"],
      \    "type": "helper"
      \  },
      \  "app/models/*_decorator.rb": {
      \    "command":  "model_decorator",
      \    "affinity": "model",
      \    "alternate": "app/models/{}.rb",
      \    "template": [
      \      "class {camelcase|capitalize|colons}Decorator",
      \      "\tdef self.prepended(base)",
      \      "\t\tbase.class_eval do",
      \      "\t\tend",
      \      "\tend",
      \      "",
      \      "\t{camelcase|capitalize|colons}.prepend self",
      \      "end"
      \    ],
      \    "type": "model"
      \  },
      \  "app/models/concerns/*_decorator.rb": {
      \    "affinity": "model",
      \    "template": [
      \      "module {camelcase|capitalize|colons}",
      \      "\tinclude ActiveSupport::Concern",
      \      "end"
      \    ],
      \    "type": "model"
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
