return {
    "neovim/nvim-lspconfig",
    tag = "v0.1.8",
    config = function()
        local lspconfig = require("lspconfig")
        
        lspconfig.util.on_setup = lspconfig.util.add_hook_before(
            lspconfig.util.on_setup,
            function(config)
                if config.name == "pylsp" then
                    config.cmd = {"pylsp", "--log-file", "/home/kmicic/pylsp.log", "-vv"}
                end
            end
        )

        lspconfig.pylsp.setup {
            settings = {
                pylsp = {
                    plugins = {
                        -- enabled by default but still
                        pylsp_mypy = {enabled = true},
                        ruff = {enabled = true},
                        -- my experimental plugin
                        -- pylsp_skill = {enabled = true},
                    }
                }
            }
        }
    end
}
