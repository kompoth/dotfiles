vim.opt.encoding="utf-8"
vim.opt.number = true
vim.opt.wrap = false
vim.opt.clipboard = "unnamedplus"
vim.opt.cursorline = true
vim.opt.cursorlineopt = "number"
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = "yes"

-- Indents
vim.opt.tabstop = 4
vim.opt.smartindent = true
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.softtabstop = 4

vim.lsp.set_log_level("debug")

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require("config.lazy")

-- When all plugins are configured, start neo-tree
vim.cmd("Neotree")

-- This configuration is set only when any LSP is attached to the buffer
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = function(ev)
        -- Buffer local mappings
        local opts = { buffer = ev.buf }
        
        -- Go to the definition of the symbol (return with CTRL-I)
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        
        -- Show a hover window with symbol"s docs
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
         
        -- Rename the symbol inside current buffer 
        vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
        
        -- Show symbol usage in the project
        vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
        
        -- Show signature help
        vim.keymap.set("n", "gs", vim.lsp.buf.signature_help, opts)
        
        -- Show diagnostics message
        vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, opts)

        -- Go to next diagnostics message
        vim.keymap.set("n", "<space>n", vim.diagnostic.goto_next, opts)
        
        -- Format the whole buffer (in normal mode) or the selection (in visual mode) 
        vim.keymap.set({"n", "v"}, "<space>f", vim.lsp.buf.format, opts)

        -- Show code actions menu
        vim.keymap.set({ "v", "n" }, "<leader>ca", require("actions-preview").code_actions)

        -- Run tests
        vim.keymap.set({ "n" }, "<leader>tr", require("neotest").run.run)
        local test_file = function()
            require("neotest").run.run(vim.fn.expand("%"))
        end
        vim.keymap.set({ "n" }, "<leader>tR", test_file)

        -- Show test summary window 
        vim.keymap.set({ "n" }, "<leader>tS", require("neotest").summary.open)
    end
})

vim.api.nvim_set_hl(0, "StatusLineNC", {})
