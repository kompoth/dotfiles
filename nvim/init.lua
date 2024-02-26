vim.cmd([[
set number
set encoding=utf-8
colorscheme srcery
]])

require('lualine').setup {
	options = {
		icons_enabled = false,
		globalstatus = true,
		theme = 'srcery',
		section_separators = '',
		component_separators = '',
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
