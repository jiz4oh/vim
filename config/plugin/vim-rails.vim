let g:rails_vim_enter         = 0

let g:rails_projections = {
      \  "config/routes.rb": {
      \    "type": "route"
      \  },
      \  "config/routes/*.rb": {
      \    "type": "route"
      \  },
      \  "app/jobs/*_job.rb": {
      \    "affinity": "model",
      \    "template": [
      \      "class {camelcase|capitalize|colons}Job < ApplicationJob",
      \      "end"
      \    ],
      \    "type": "job"
      \  }
      \}

let g:rails_gem_projections = {
    \   "factory_bot": {
    \     "test/factories/*.rb": {
    \       "command":   "factory",
    \       "affinity":  "collection",
    \       "alternate": "app/models/{singular}.rb",
    \       "related":   "db/schema.rb#{}",
    \       "test":      "test/models/{singular}_test.rb",
    \       "template":  "FactoryBot.define do\n  factory :{singular} do\n  end\nend",
    \       "keywords":  "factory sequence"
    \     },
    \     "spec/factories/*.rb": {
    \       "command":   "factory",
    \       "affinity":  "collection",
    \       "alternate": "app/models/{singular}.rb",
    \       "related":   "db/schema.rb#{}",
    \       "test":      "spec/models/{singular}_test.rb",
    \       "template":  "FactoryBot.define do\n  factory :{singular} do\n  end\nend",
    \       "keywords":  "factory sequence"
    \     }
    \   },
    \   "factory_girl": {
    \     "test/factories/*.rb": {
    \       "command":   "factory",
    \       "affinity":  "collection",
    \       "alternate": "app/models/{singular}.rb",
    \       "related":   "db/schema.rb#{}",
    \       "test":      "test/models/{singular}_test.rb",
    \       "template":  "FactoryGirl.define do\n  factory :{singular} do\n  end\nend",
    \       "keywords":  "factory sequence"
    \     },
    \     "spec/factories/*.rb": {
    \       "command":   "factory",
    \       "affinity":  "collection",
    \       "alternate": "app/models/{singular}.rb",
    \       "related":   "db/schema.rb#{}",
    \       "test":      "spec/models/{singular}_test.rb",
    \       "template":  "FactoryGirl.define do\n  factory :{singular} do\n  end\nend",
    \       "keywords":  "factory sequence"
    \     }
    \   },
    \   "settingslogic": {
    \     "config/application.yml": {
    \       "command":   "settings"
    \     }
    \   },
    \   "config": {
    \     "config/settings.yml": {
    \       "command":   "settings"
    \     }
    \   },
    \   "capistrano": {
    \     "config/deploy.rb": {
    \       "command":   "deploy"
    \     }
    \   },
    \   "capybara": {
    \     "spec/features/*_spec.rb": {
    \       "command":   "feature",
    \       "template":  "feature '{underscore|capitalize|blank}' do\n\nend"
    \     }
    \   },
    \   "activeadmin": {
    \     "app/admin/*.rb": {
    \       "command":   "admin",
    \       "affinity":  "model",
    \       "test":      "spec/admin/{}_spec.rb",
    \       "related":   "app/models/{singular}.rb",
    \       "template":  "ActiveAdmin.register {camelcase|capitalize|colons} do\n  config.sort_order = 'created_at_desc'\nend"
    \     }
    \   },
    \   "active_model_serializers": {
    \     "app/serializers/*_serializer.rb": {
    \       "command":   "serializer",
    \       "affinity":  "model",
    \       "test":      "spec/serializers/{}_spec.rb",
    \       "related":   "app/models/{}.rb",
    \       "template":  "class {camelcase|capitalize|colons}Serializer < ActiveModel::Serializer\nend"
    \     }
    \   },
    \   "draper": {
    \     "app/decorators/*_decorator.rb": {
    \       "command":   "decorator",
    \       "affinity":  "model",
    \       "test":      "spec/decorators/{}_spec.rb",
    \       "related":   "app/models/{}.rb",
    \       "template":  "class {camelcase|capitalize|colons}Decorator < Draper::Decorator\n  delegate_all\nend"
    \     }
    \   },
    \   "carrierwave": {
    \     "app/uploaders/*_uploader.rb": {
    \       "command":   "uploader",
    \       "affinity":  "model",
    \       "test":      "spec/uploaders/{}_spec.rb",
    \       "related":   "app/models/{}.rb",
    \       "template":  "class {camelcase|capitalize|colons}Uploader < CarrierWave::Uploader::Base\nend"
    \     }
    \   },
    \   "turnip": {
    \     "spec/acceptance/*.feature": {
    \       "command":   "acceptance"
    \     },
    \     "spec/acceptance/steps/*_steps.rb": {
    \       "command":   "steps",
    \       "template":  "steps_for :{} do\nend"
    \     }
    \   },
    \   "pundit": {
    \     "app/policies/*_policy.rb": {
    \       "command":   "policy",
    \       "affinity":  "model",
    \       "test":      "spec/policies/{}_spec.rb",
    \       "related":   "app/models/{}.rb",
    \       "template":  "class {camelcase|capitalize|colons}Policy < Struct.new(:user, :{})\nend"
    \     }
    \   },
    \   "resque": {
    \     "app/jobs/*_job.rb": {
    \       "command":   "job",
    \       "test":      "spec/jobs/{}_spec.rb",
    \       "template":  "class {camelcase|capitalize|colons}Job\n\n  def self.perform\n  end\nend"
    \     }
    \   },
    \   "sidekiq": {
    \     "app/sidekiq/*_job.rb": {
    \       "command":   "job",
    \       "test":      "spec/sidekiq/{}_job_spec.rb",
    \       "template":  "class {camelcase|capitalize|colons}Job\n  include Sidekiq::Job\n\n  def perform\n  end\nend"
    \     }
    \   },
    \   "ember-rails": {
    \     "app/assets/javascripts/router.js.coffee": {
    \       "command":   "jinitializer"
    \     },
    \     "app/assets/javascripts/models/*.js.coffee": {
    \       "command":   "jmodel",
    \       "alternate": "spec/javascripts/models/{}_spec.js.coffee",
    \       "template":  "App.{camelcase|capitalize|dot} = DS.Model.extend"
    \     },
    \     "app/assets/javascripts/views/*_view.js.coffee": {
    \       "command":   "jview",
    \       "alternate": "spec/javascripts/views/{}_spec.js.coffee",
    \       "template":  "App.{camelcase|capitalize|dot}View = Ember.View.extend"
    \     },
    \     "app/assets/javascripts/controllers/*_controller.js.coffee": {
    \       "command":   "jcontroller",
    \       "alternate": "spec/javascripts/controllers/{}_spec.js.coffee",
    \       "template":  "App.{camelcase|capitalize|dot}Controller = Ember.ObjectController.extend"
    \     },
    \     "app/assets/javascripts/routes/*_route.js.coffee": {
    \       "command":   "jroute",
    \       "alternate": "spec/javascripts/routes/{}_spec.js.coffee",
    \       "template":  "App.{camelcase|capitalize|dot}Route = Ember.Route.extend"
    \     },
    \     "app/assets/javascripts/mixins/*.js.coffee": {
    \       "command":   "jmixin",
    \       "alternate": "spec/javascripts/mixins/{}_spec.js.coffee",
    \       "template":  "App.{camelcase|capitalize|dot} = Ember.Mixin.create"
    \     },
    \     "app/assets/javascripts/templates/*.js.emblem": {
    \       "command":   "jtemplate"
    \     },
    \     "app/assets/javascripts/serializers/*_serializer.js.coffee": {
    \       "command":   "jserializer",
    \       "alternate": "spec/javascripts/serializers/{}_spec.js.coffee",
    \       "template":  "App.{camelcase|capitalize|dot}Serializer = DS.RESTSerializer.extend"
    \     },
    \     "app/assets/javascripts/adapters/*_adapter.js.coffee": {
    \       "command":   "jadapter",
    \       "alternate": "spec/javascripts/adapters/{}_spec.js.coffee",
    \       "template":  "App.{camelcase|capitalize|dot}Adapter = App.ApplicationAdapter.extend"
    \     },
    \     "spec/javascripts/**/*_spec.js.coffee": {
    \       "command":   "jspec",
    \       "alternate": "app/assets/javascripts/{}.coffee"
    \     }
    \   },
    \   "whenever": {
    \     "config/schedule.rb": {
    \       "command":   "schedule"
    \     }
    \   },
    \ }

" autocmd FileType ruby
"       \ vnoremap <silent> <buffer> dr :<C-u>execute ":Runner ". shellescape(substitute(personal#functions#selected(), '#{', '\#{', 'g')) . ""<CR>

autocmd FileType ruby
      \ if !empty(rails#app())|call <SID>setup_zepl()|endif

" autocmd User Rails call <SID>setup_rails()

" function! s:setup_rails() abort
  " nnoremap <silent><buffer> `<CR> :Rails<cr>
  " xnoremap <silent><buffer> `<CR> :Rails<cr>
" endfunction

function! s:setup_zepl() abort
  if empty(get(b:, 'start', ''))
    let b:repl_config = { 'cmd': 'rails console' }
  endif

  nnoremap <silent><buffer> <leader>rl :ReplSend reload!<cr>
endfunction

function! s:ac() abort
  let pre = &confirm
  try
    set confirm
    A
  finally
    let &confirm = pre
  endtry
endfunction

command! AC :call <SID>ac()
