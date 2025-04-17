return {
    "hrsh7th/nvim-cmp",
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
    },
    config = function()
        local cmp = require("cmp")
        
        cmp.setup({
            -- I don't like when completion options appear without a direct command
            completion = {
                autocomplete = false
            },

            -- Use built-in Neovim snippet engine
            snippet = {
                expand = function(args)
                    vim.snippet.expand(args.body)
                end,
            },

            -- Bindings
            mapping = cmp.mapping.preset.insert({
                ['<C-n>'] = cmp.mapping.complete(),
                ['<Tab>'] = cmp.mapping.select_next_item(),
                ['<S-Tab>'] = cmp.mapping.select_prev_item(),
                ['<CR>'] = cmp.mapping.confirm({ select = true }),
            }),

            -- Use completion options from language servers, buffers and path
            sources = cmp.config.sources({
                { name = 'nvim_lsp' }, 
                { name = 'buffer' },
                { name = 'path' },
            })
        })
    end,
}
