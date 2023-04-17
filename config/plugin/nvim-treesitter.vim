lua<<EOF
  vim.opt.foldmethod = 'expr'
  vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'

  require'nvim-treesitter.configs'.setup {
    auto_install = true,

    ensure_installed = {
      "vim",
      "html",
      "css",
      "tsx",
      "javascript",
      "json",
      "lua",
      "toml",
      "yaml",
      "ruby",
      "go",
      "bash",
    },
    indent = {
      enable = true
    },
    -- hightlight caused bug with rails.vim that gf is not working as expected
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },
  }
EOF
