return {
    "neovim/nvim-lspconfig",
    config = function()
        local lspconfig = require("lspconfig")
        
        lspconfig.ruff.setup{}

        lspconfig.pylsp.setup {
            cmd = {"pylsp", "-vv", "--log-file", "/tmp/pylsp.log"},
            settings = {
                pylsp = {
                    plugins = {
                        -- For type checking 
                        pylsp_mypy = {enabled = true},

                        -- Keeping ruff-pylsp to shutdowm default plugins
                        ruff = {enabled = false},
                        
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
