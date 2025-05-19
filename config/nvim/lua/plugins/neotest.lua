return {
    "nvim-neotest/neotest", 
    dependencies = {
        "nvim-neotest/nvim-nio",
        "nvim-lua/plenary.nvim",
        "antoinemadec/FixCursorHold.nvim",
        "nvim-treesitter/nvim-treesitter",
        "nvim-neotest/neotest-python",
    },
    config = function()
        require("neotest").setup({
            output = { open_on_run = true },
            adapters = {
                require("neotest-python")({
                    log_level = vim.log.levels.DEBUG,
                    runner = "pytest",
                }),
            }
        })
    end,
}
