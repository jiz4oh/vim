" lsp
nnoremap gr <cmd>lua vim.lsp.buf.references()<CR>
nnoremap gi <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <leader>D <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <leader>rn <cmd>lua vim.lsp.buf.rename()<CR>
nnoremap gs <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap gS <cmd>lua vim.lsp.buf.workspace_symbol('')<CR>
nnoremap <leader>wa <cmd>lua vim.lsp.buf.add_workleader_folder()<CR>
nnoremap <leader>wr <cmd>lua vim.lsp.buf.remove_workleader_folder()<CR>
nnoremap <leader>wl <cmd>lua print(vim.inspect(vim.lsp.buf.list_workleader_folders()))<CR>
nnoremap [g <cmd>lua vim.diagnostic.goto_prev()<CR>
nnoremap ]g <cmd>lua vim.diagnostic.goto_next()<CR>
nnoremap <leader>f <cmd>lua vim.lsp.buf.formatting()<CR>
