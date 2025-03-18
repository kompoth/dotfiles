return {
    "neovim/nvim-lspconfig",
    tag = "v0.1.8",
    config = function()
        local lspconfig = require("lspconfig")
        
        lspconfig.pylsp.setup {
            cmd = {"pylsp", "-vv", "--log-file", "/tmp/pylsp.log"},
            settings = {
                pylsp = {
                    plugins = {
                        -- enabled by default but still
                        pylsp_mypy = {enabled = true},
                        ruff = {enabled = true},
                        -- my experimental plugin
                        starkiller = {enabled = true},
                    }
                }
            }
        }
    end
}
