vim.cmd([[
    set number
    set encoding=utf-8
    set clipboard+=unnamedplus
    set termguicolors
    colorscheme srcery
]])

vim.opt.tabstop     = 4
vim.opt.shiftwidth  = 4
vim.bo.softtabstop  = 4
vim.opt.expandtab   = true
vim.opt.smarttab    = true

vim.opt.cursorline = true

require('lualine').setup {
    options = {
        icons_enabled           = false,
        globalstatus            = true,
        theme                   = 'srcery',
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
}

require('colorizer').setup {
    filetypes = {'*'},
    user_default_options = {
        RGB         = true,
        RRGGBB      = true,
        RRGGBBAA    = true,
        names       = false
    }
}
