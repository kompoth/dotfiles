-- Fixes weird indent behaviour after opening parenthesis 
vim.g.pyindent_open_paren = vim.bo.shiftwidth

-- Don't show virtual text with diagnostics
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = false,
    signs = true,
    update_in_insert = false,
    underline = true,
  }
)

-- This configuration is set only when any LSP is attached to the buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
    vim.cmd('set completeopt-=preview')

    -- Buffer local mappings.
    local opts = { buffer = ev.buf }
    -- Go to the definition of the symbol (return with CTRL-I)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    -- Show a hover window with symbol's docs
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    -- LSP workspace folders management
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    -- Rename the symbol inside current buffer 
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    -- Show symbol usage in the project
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    
    -- Show diagnostics message
    vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
  end
})
