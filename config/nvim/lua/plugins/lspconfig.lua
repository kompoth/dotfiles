return {
    "neovim/nvim-lspconfig",
    config = function()
        local lspconfig = require("lspconfig")
        local capabilities = require("cmp_nvim_lsp").default_capabilities()
        
        -- Enable Ruff server
        lspconfig.ruff.setup {}

        -- Enable ty server
        -- vim.lsp.enable("ty")

        -- Enable pylsp
        lspconfig.pylsp.setup {
            capabilities = capabilities,
            cmd = {"pylsp", "-vv", "--log-file", "/tmp/pylsp.log"},
            settings = {
                pylsp = {
                    plugins = {
                        jedi_completion = { enabled = true },
                        jedi_hover = { enabled = true },
                        jedi_references = { enabled = true },
                        jedi_signature_help = { enabled = true },
                        jedi_symbols = { enabled = true, all_scopes = true },

                        -- Disable linters and formatters
                        pyflakes = { enabled = false },
                        pycodestyle = { enabled = false },
                        pydocstyle = { enabled = false },
                        mccabe = { enabled = false },
                        yapf = { enabled = false },
                        autopep8 = { enabled = false },

                        -- For type checking 
                        pylsp_mypy = {enabled = true},

                        -- My experimental plugin
                        starkiller = {
                            enabled = true,
                            aliases = {
                                numpy = "np",
                                ["matplotlib.pyplot"] = "plt",
                            }
                        }
                    }
                }
            }
        }
    end
}
