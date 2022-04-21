vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'

require'nvim-treesitter.configs'.setup {
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
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}
