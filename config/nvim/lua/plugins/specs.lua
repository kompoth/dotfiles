return { 
    {
        'ellisonleao/gruvbox.nvim',
        config = function()
            require('gruvbox').setup({
                contrast = 'hard'
            })
            vim.cmd("colorscheme gruvbox")
        end
    },
    {
        'nvim-lualine/lualine.nvim',
        config = function()
            require('lualine').setup({
                options = {
                    icons_enabled        = false,
                    globalstatus         = true,
                    section_separators   = '',
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
            })
        end
    },
    {
        'NvChad/nvim-colorizer.lua',
        config = function()
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
        end
    },
    {
        'neovim/nvim-lspconfig',
        tag = 'v0.1.8',
        config = function()
            require('lspconfig').pylsp.setup({})
        end
    },
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim"
        }
    },
    {
        'lervag/wiki.vim',
        config = function()
            vim.g.wiki_root = '~/Documents/vimwiki'
        end
    }
}
