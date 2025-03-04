return {
    "neovim/nvim-lspconfig",
    tag = "v0.1.8",
    config = function()
        require("lspconfig").pylsp.setup {
            pylsp = {
                pylsp_mypy = {
                    enabled = true,
                },
            }
        }
    end
}
