vim.opt.encoding="utf-8"
vim.opt.number = true
vim.opt.wrap = false
vim.opt.clipboard = 'unnamedplus'
vim.opt.cursorline = true
vim.opt.cursorlineopt = 'number'
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = 'yes'

-- Indents
vim.opt.tabstop = 4
vim.opt.smartindent = true
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.softtabstop = 4

-- Setup colorscheme 
require("gruvbox").setup({
	contrast="hard"
})
vim.cmd('colorscheme gruvbox')

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
vim.opt.termguicolors = true
require('colorizer').setup({
    filetypes = {'*'},
    user_default_options = {
        RGB         = true,
        RRGGBB      = true,
        RRGGBBAA    = true,
        names       = false
    }
})

-- Setup split management
require('smart-splits').setup({
	resize_mode = {
		resize_keys = {"<Left>", "<Down>", "<Up>", "<Right>"}
	}
})
vim.keymap.set('n', '<A-Left>', require('smart-splits').resize_left)
vim.keymap.set('n', '<A-Down>', require('smart-splits').resize_down)
vim.keymap.set('n', '<A-Up>', require('smart-splits').resize_up)
vim.keymap.set('n', '<A-Right>', require('smart-splits').resize_right)
vim.keymap.set('n', '<A-p>', require('smart-splits').start_resize_mode)


-- Start Python LSP
require('lspconfig').pylsp.setup({})
-- For Python-specific config see ftplugin/python.lua
