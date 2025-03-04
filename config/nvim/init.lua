vim.opt.encoding="utf-8"
vim.opt.number = true
vim.opt.wrap = false
vim.opt.clipboard = 'unnamedplus'
vim.opt.cursorline = true
vim.opt.cursorlineopt = 'number'
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = 'yes'

-- Indents
vim.opt.tabstop = 4
vim.opt.smartindent = true
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.softtabstop = 4

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require("config.lazy")

-- When all plugins are configured, start neo-tree
vim.cmd("Neotree")

-- This configuration is set only when any LSP is attached to the buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Buffer local mappings
    local opts = { buffer = ev.buf }
    
    -- Go to the definition of the symbol (return with CTRL-I)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)

    -- Show a hover window with symbol's docs
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
     
    -- Rename the symbol inside current buffer 
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    
    -- Show symbol usage in the project
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)

    vim.keymap.set('n', 'gs', vim.lsp.buf.signature_help, opts)
 
    -- Show diagnostics message
    vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
  end
})
