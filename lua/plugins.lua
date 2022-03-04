vim.opt.updatetime = 100

local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  use { 'kkoomen/vim-doge', run = ':call doge#install()' }
  use { 'junegunn/goyo.vim' }
  use { 'iamcco/markdown-preview.nvim', opt = true, run = ':call mkdp#util#install()', cmd = 'MarkdownPreview' }
  use { 'mzlogin/vim-markdown-toc',
        ft = 'markdown',
        config = function()
          vim.g.vmt_fence_text = 'TOC'
          vim.g.vmt_fence_closing_text = '/TOC'
          vim.g.vmt_cycle_list_item_markers = 1
          vim.g.vmt_include_headings_before = 1
        end
      }
  use { 'lervag/wiki.vim',
        config = function()
          vim.g.wiki_root               = vim.env.HOME .. '/Documents/wiki'
          vim.g.wiki_filetypes          = {'md', 'wiki'}
          vim.g.wiki_link_extension     = '.md'
          vim.g.wiki_link_target_type   = 'md'
          vim.g.wiki_global_load        = 0
        end
      }


  use {
        'nvim-treesitter/nvim-treesitter',
        disable = true,
        run = ':TSUpdate',
        config = function ()
          vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
          require'nvim-treesitter.configs'.setup {
            indent = {
              enable = true
            },
            highlight = {
              enable = true,
              additional_vim_regex_highlighting = false,
            },
          }
        end
      }
  -- -- run checkhealth telescope before install
  -- use({
  --     "nvim-telescope/telescope.nvim",
  --     config = function ()
  --       vim.cmd([[packadd plenary.nvim]])
  --       vim.cmd([[packadd telescope-project.nvim]])
  --       vim.cmd([[packadd telescope-fzf-native.nvim]])

  --       local telescope = require("telescope")
  --       local actions = require("telescope.actions")
  --       local action_set = require("telescope.actions.set")

  --       telescope.setup({
  --         defaults = {
  --           previewer = false,
  --           prompt_prefix = "⦕ ",
  --           selection_caret = "⤜ ",
  --           entry_prefix = "  ",
  --           file_sorter = require("telescope.sorters").get_generic_sorter,
  --           generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
  --           file_ignore_patterns = { ".git/", "node_modules" },
  --           layout_strategy = 'vertical',
  --           layout_config = {
  --             height = 0.8,
  --             prompt_position = "bottom",
  --           },
  --           -- border = {},
  --           set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
  --           -- Developer configurations: Not meant for general override
  --           buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
  --           mappings = {
  --             i = {
  --               ["<esc>"] = actions.close,
  --             },
  --           },
  --         },
  --         pickers = {
  --           find_files = {
  --             hidden = true,
  --             attach_mappings = function(_)
  --               action_set.select:enhance({
  --                 post = function()
  --                   vim.cmd(":normal! zx")
  --                 end,
  --               })
  --               return true
  --             end,
  --           },
  --         },
  --         extensions = {
  --           fzf = {
  --             fuzzy = true,
  --             override_generic_sorter = true, -- override the generic sorter
  --             override_file_sorter = true, -- override the file sorter
  --             case_mode = "smart_case", -- or "ignore_case" or "respect_case"
  --           },
  --           project = {
  --             base_dirs = {},
  --             max_depth = 4,
  --             hidden_files = true,
  --           },
  --         },
  --       })
  --       telescope.load_extension("fzf")
  --       telescope.load_extension("project")
  --     end,
  --     requires = {
  --       { "nvim-lua/plenary.nvim" },
  --       { "nvim-telescope/telescope-project.nvim", opt = true },
  --       {
  --         "nvim-telescope/telescope-fzf-native.nvim",
  --         opt = true,
  --         run = "make",
  --       },
  --     },
  --   })

  use { 'junegunn/fzf.vim',
        config = function ()
          vim.env.FZF_DEFAULT_OPTS = '--reverse'

          vim.g.fzf_buffers_jump   = 1
          vim.g.fzf_history_dir    = '~/.local/share/fzf-history'
          if vim.env.TMUX then
            vim.g.fzf_layout = { tmux = '-p90%,60%' }
          else
            -- disable popup in favor of location window
            vim.g.fzf_layout = { down = '60%' }

            vim.g.fzf_layout = { window = { width = 0.9, height = 0.8 } }
          end
          vim.g['fzf_preview_window'] = {'down:60%:+{2}-/2'}
        end,
        requires = {
          { 'junegunn/fzf', run = ':call fzf#install()', }
        }
      }

  use { 'justinmk/vim-sneak', config = function() vim.g['sneak#label'] = 1 end }
  use { 'kyazdani42/nvim-tree.lua',
        requires = {
          'kyazdani42/nvim-web-devicons', -- optional, for file icon
        },
        config = function()
          require'nvim-tree'.setup {
            auto_close = true,
            view = {
              mappings = {
                list = {
                  {key= {"<CR>", "o", "<2-LeftMouse>", 'l' },action= "edit" },
                  {key= {"-", "h"},                          action= "dir_up"},
                }
              }
            }
          }
        end
    }
  use { 'mhinz/vim-startify',
      config = function ()
        vim.g.startify_change_to_dir             = 0
        vim.g.startify_relative_path             = 1
        vim.g.startify_files_number              = 5
        vim.g.startify_session_delete_buffers    = 1
        vim.g.startify_session_persistence       = 1
        vim.g.startify_session_before_save       = {
            'echo "Cleaning up before saving.."',
            'silent! NvimTreeClose'
        }
        vim.g.startify_lists                     = {
          { type = 'sessions',            header = {'   Sessions'            }},
          { type = 'bookmarks',           header = {'   Bookmarks'           }},
          { type = vim.fn['GitModified'], header = {'   Git Modified'        }},
          { type = vim.fn['GitUntracked'],header = {'   Git Untracked'       }},
          { type = vim.fn['GitStaged'],   header = {'   Git Staged'          }},
          { type = 'dir',                 header = {'   MRU'..vim.fn.getcwd()}},
          { type = 'files',               header = {'   MRU'                 }},
          { type = 'commands',            header = {'   Commands'            }},
        }
        vim.g.startify_bookmarks = {
          '~/.vimrc',
          '~/.vim/vimrc.bundles',
          '~/.zshrc',
        }
        vim.g.startify_commands = {
          { w = {'笔记列表', 'WikiIndex'  }},
          { p = {'搜索项目', 'Pg'         }},
          { c = {'查看提交', 'Commits'    }},
          { u = {'插件更新', 'PlugUpdate' }},
          { i = {'插件安装', 'PlugInstall'}},
        }
      end
    }


  -- project
  use { 'airblade/vim-rooter',
        config = function()
          -- 当处于非项目下时保持和 autochdir 相同行为
          vim.g.rooter_change_directory_for_non_project_files = 'current'
          vim.g.rooter_cd_cmd = 'lcd'
          vim.g.rooter_resolve_links = 1
        end
      }

  use { 'preservim/tagbar', cmd = 'TagbarToggle' }
  use { 'tpope/vim-fugitive' }

  use {
    'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('gitsigns').setup {
        current_line_blame = true,
      }
    end
  }

  -- complete
  use {
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
    'hrsh7th/cmp-buffer',
    'quangnguyen30192/cmp-nvim-tags',
    requires = {
      { 'hrsh7th/nvim-cmp' }
    }
  }

  -- lsp
  use {
    'hrsh7th/cmp-nvim-lsp',
    requires = {
      { 'neovim/nvim-lspconfig' },
      { 'hrsh7th/nvim-cmp' }
    }
  }
  use {
        'williamboman/nvim-lsp-installer',
        requires = {
          { 'neovim/nvim-lspconfig' },
        }
      }
  use { 'ojroques/nvim-lspfuzzy',
        requires = {
          { 'junegunn/fzf' },
          { 'junegunn/fzf.vim'},  -- to enable preview (optional)
        },
      }

  -- ruby
  use { 'tpope/vim-bundler', 'tpope/vim-rails', opt = true, ft = 'ruby' }

  -- schema
  use { 'vlime/vlime', rtp = 'vim/', ft = { 'scheme' } }
  use { 'kovisoft/paredit', ft = { 'clojure', 'scheme' } }

  use { 'tpope/vim-dispatch', opt = true, cmd = {'Dispatch', 'Make', 'Focus', 'Start'} }
  use 'ludovicchabant/vim-gutentags'
  use 'sheerun/vim-polyglot'
  use 'asins/vim-dict'
  use 'tpope/vim-rsi'
  use 'tpope/vim-commentary'
  use 'tpope/vim-endwise'
  use 'svermeulen/vim-cutlass'
  use 'nathom/filetype.nvim'

  -- 美化
  use { 'kyazdani42/nvim-web-devicons' }
  -- use {
  --   'sonph/onehalf',
  --   rtp = 'vim',
  --   config = function()
  --     vim.cmd [[colorscheme onehalfdark]]
  --   end,
  --   event = 'VimEnter',
  -- }
  use { 'olimorris/onedarkpro.nvim',
    config = function ()
      require('onedarkpro').load()
      vim.cmd [[colorscheme onedarkpro]]
    end
  }
  -- use { 'mhartington/oceanic-next',
  --   config = function ()
  --     vim.cmd [[colorscheme OceanicNext]]
  --   end
  -- }
  -- use { 'marko-cerovac/material.nvim',
  --   config = function ()
  --     vim.cmd 'colorscheme material'
  --   end
  -- }
  --
  if packer_bootstrap then
    require('packer').sync()
  end
end)

