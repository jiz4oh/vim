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

vnoremap <silent> <F6> :<C-u>execute ":Runner ". shellescape(substitute(personal#functions#selected(), '#{', '\#{', 'g')) . ""<CR>

