-- Set default encoding
vim.opt.encoding="utf-8"
-- Make line numbers default
vim.opt.number = true
-- Sync clipboard between OS and Neovim.
vim.opt.clipboard = 'unnamedplus'
-- Highlight current line number
vim.opt.cursorline = true
vim.opt.cursorlineopt = 'number'
-- Case-insensitive searching UNLESS \C or capital in search
vim.opt.ignorecase = true
vim.opt.smartcase = true
-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'
-- Set colorscheme 
vim.g.material_style = "darker"
require('material').setup({
    contrast = {
        floating_windows = true
    },
    high_visibility = {
        darker = true
    },
})
vim.cmd('colorscheme material')


-- Setup fancy status line
require('lualine').setup({
    options = {
        icons_enabled           = false,
        globalstatus            = true,
        section_separators      = '',
        component_separators    = '',
        sections = {
            lualine_a = {'mode'},
            lualine_b = {'branch', 'diff', 'diagnostics'},
            lualine_c = {'filename'},
            lualine_x = {'encoding', 'fileformat', 'filetype'},
            lualine_y = {'progress'},
            lualine_z = {'location'}
        }
    }
})

-- Show hex colors (termguicolors must be enabled)
--require('colorizer').setup({
--    filetypes = {'*'},
--    user_default_options = {
--        RGB         = true,
--        RRGGBB      = true,
--        RRGGBBAA    = true,
--        names       = false
--    }
--})

-- Git diff and merge view
require("diffview").setup({
    use_icons = false
})

-- Start Python LSP
require('lspconfig').pylsp.setup({})
-- For Python-specific config see ftplugin/python.lua
