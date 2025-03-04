return {
    {
        "romgrk/barbar.nvim",
        version = "^1.0.0", -- optional: only update when a new 1.x version is released
        dependencies = {
            "lewis6991/gitsigns.nvim", -- OPTIONAL: for git status
            "nvim-tree/nvim-web-devicons", -- OPTIONAL: for file icons
        },
        opts = {
            sidebar_filetypes = {
                ["neo-tree"] = {text = "Kmicic's Neovim"}
            }
        },
    }
}
