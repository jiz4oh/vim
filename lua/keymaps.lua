local function global_map(mode, lhs, rhs, opts)
  opts = vim.tbl_extend('force', {noremap = true, silent = true}, opts or {})
  vim.api.nvim_set_keymap(mode, lhs, rhs, opts)
end

local function local_map(mode, lhs, rhs, opts)
  opts = vim.tbl_extend('force', {noremap = true, silent = true}, opts or {})
  vim.api.nvim_buf_set_keymap(0, mode, lhs, rhs, opts)
end

global_map('n', 'c', "d")
global_map('x', 'c', "d")
global_map('n', 'cc', "dd")
global_map('n', 'C', "D")

-- LSP
global_map('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
global_map('n', 'gs', '<cmd>lua vim.lsp.buf.document_symbol()<CR>')
global_map('n', 'gS', '<cmd>lua vim.lsp.buf.workspace_symbol()<CR>')
global_map('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>')
global_map('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
global_map('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>')
global_map('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>')
global_map('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>')
global_map('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>')
global_map('n', '<leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>')

-- Navigation
global_map('n', ']c', "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'", {expr=true})
global_map('n', '[c', "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'", {expr=true})
global_map('',  'f', "<Plug>Sneak_s", {noremap=false})
global_map('',  'F', "<Plug>Sneak_S", {noremap=false})

global_map('n', '<C-n>',     ':NvimTreeToggle<CR>')
global_map('n', '<leader>n', ':NvimTreeFindFileToggle<CR>')
global_map('n', '<leader>r', ':NvimTreeRefresh<CR>')

global_map('',  '<F3>',      ':TagbarToggle<CR>')
global_map('!', '<F3>',      ':TagbarToggle<CR>')

-- Git
global_map('n', '<leader>hs', ':Gitsigns stage_hunk<CR>')
global_map('v', '<leader>hs', ':Gitsigns stage_hunk<CR>')
global_map('n', '<leader>hr', ':Gitsigns reset_hunk<CR>')
global_map('v', '<leader>hr', ':Gitsigns reset_hunk<CR>')
global_map('n', '<leader>hS', '<cmd>Gitsigns stage_buffer<CR>')
global_map('n', '<leader>hu', '<cmd>Gitsigns undo_stage_hunk<CR>')
global_map('n', '<leader>hR', '<cmd>Gitsigns reset_buffer<CR>')
global_map('n', '<leader>hp', '<cmd>Gitsigns preview_hunk<CR>')
global_map('n', '<leader>hb', '<cmd>lua require"gitsigns".blame_line{full=true}<CR>')
global_map('n', '<leader>tb', '<cmd>Gitsigns toggle_current_line_blame<CR>')
global_map('n', '<leader>hd', '<cmd>Gitsigns diffthis<CR>')
global_map('n', '<leader>hD', '<cmd>lua require"gitsigns".diffthis("~")<CR>')
global_map('n', '<leader>td', '<cmd>Gitsigns toggle_deleted<CR>')
global_map('n', '<leader>gw', ':<C-U>Gwrite<cr>')
global_map('n', '<leader>gc', ':<C-U>Git commit<cr>')
global_map('n', '<leader>gr', ':<C-U>Gread<cr>')
global_map('n', '<leader>gf', ':<C-U>Gvdiffsplit<cr>')
global_map('n', '<leader>gb', ':<C-U>Git blame<cr>')
global_map('n', '<leader>gl', ':<C-U>Git log<cr>')
global_map('n', '<leader>gs', ':<C-U>Git<cr>')

-- Text object
global_map('o', 'ih', ':<C-U>Gitsigns select_hunk<CR>')
global_map('x', 'ih', ':<C-U>Gitsigns select_hunk<CR>')
