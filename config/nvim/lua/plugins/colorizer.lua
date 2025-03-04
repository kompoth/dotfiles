return {
    "NvChad/nvim-colorizer.lua",
    config = function()
        vim.opt.termguicolors = true
        require("colorizer").setup({
            filetypes = {"*"},
            user_default_options = {
                RGB         = true,
                RRGGBB      = true,
                RRGGBBAA    = true,
                names       = false
            }
        })
    end
}
