return {
    "ellisonleao/gruvbox.nvim",
    config = function()
        require("gruvbox").setup({
            contrast = "hard",
            overrides = {
                -- gitsigns.nvim
	            SignColumn              = {link = "Normal"},
                GitSignsAdd             = {fg = "#fe8019", bg = ""},
                GitSignsChange          = {fg = "#458588", bg = ""},
                GitSignsDelete          = {fg = "#cc241d", bg = ""},
                GitSignsStagedAdd       = {fg = "#7c6f64", bg = ""},
                GitSignsStagedChange    = {fg = "#7c6f64", bg = ""},
                GitSignsStagedDelete    = {fg = "#7c6f64", bg = ""},
                -- NeoTreeGitAdded         = {fg = "#fe8019"},     
                -- NeoTreeGitConflict      = {fg = "#cc241d"},
                -- NeoTreeGitDeleted       = {fg = "#cc241d"},        
                -- NeoTreeGitIgnored       = {fg = "#7c6f64"},        
                -- NeoTreeGitModified       = {fg = "#458588"}, 
                -- NeoTreeGitUnstaged      = {fg = "#458588"},
                -- NeoTreeGitUntracked     = {fg = "#fe8019"}
                -- NeoTreeGitStaged 
            }
        })
        vim.cmd("colorscheme gruvbox")
    end
}
