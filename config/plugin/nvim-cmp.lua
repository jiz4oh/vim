local cmp = require('cmp')

-- default config
-- https://github.com/hrsh7th/nvim-cmp/blob/main/lua/cmp/config/default.lua
cmp.setup({
  mapping = cmp.mapping.preset.insert({
    ['<M-n>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<M-p>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          if vim.fn.pumvisible() == 1 then
            cmp.complete()
          else
            cmp.select_next_item()
          end
        else
          fallback()
        end
      end, {"i","s","c",}),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          if vim.fn.pumvisible() == 1 then
            cmp.complete()
          else
            cmp.select_prev_item()
          end
        else
          fallback()
        end
      end, {"i","s","c",}),
  }),
  sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      -- { name = 'vsnip' }, -- For vsnip users.
      -- { name = 'luasnip' }, -- For luasnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
      { name = 'cmp_tabnine' },
    }, {
      { name = 'buffer' },
      { name = 'tags' },
    }),
  snippet = {
    -- We recommend using *actual* snippet engine.
    -- It's a simple implementation so it might not work in some of the cases.
    expand = function(args)
      local line_num, col = unpack(vim.api.nvim_win_get_cursor(0))
      local line_text = vim.api.nvim_buf_get_lines(0, line_num - 1, line_num, true)[1]
      local indent = string.match(line_text, '^%s*')
      local replace = vim.split(args.body, '\n', true)
      local surround = string.match(line_text, '%S.*') or ''
      local surround_end = surround:sub(col)

      replace[1] = surround:sub(0, col - 1)..replace[1]
      replace[#replace] = replace[#replace]..(#surround_end > 1 and ' ' or '')..surround_end
      if indent ~= '' then
        for i, line in ipairs(replace) do
         replace[i] = indent..line
        end
      end

      vim.api.nvim_buf_set_lines(0, line_num - 1, line_num, true, replace)
    end,
  }
})

for _, cmd_type in ipairs({'/', '?', '@'}) do
  cmp.setup.cmdline(cmd_type, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' },
      { name = 'cmdline_history' },
    },
  })
end

cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'cmdline' },
    { name = 'path' },
  })
})

for _, file_type in ipairs({ 'sql', 'mysql', 'plsql'}) do
  cmp.setup.filetype(file_type, {
    sources = cmp.config.sources({
      { name = 'vim-dadbod-completion' },
    })
  })
end
