return { 
    {
        "ellisonleao/gruvbox.nvim",
        config = function()
            require("gruvbox").setup({
                contrast = "hard"
            })
            vim.cmd("colorscheme gruvbox")
        end
    },
    {
        "nvim-lualine/lualine.nvim",
        config = function()
            require("lualine").setup({
                options = {
                    icons_enabled        = false,
                    globalstatus         = true,
                    section_separators   = "",
                    component_separators = "",
                    sections = {
                        lualine_a = {"mode"},
                        lualine_b = {"branch", "diff", "diagnostics"},
                        lualine_c = {"filename"},
                        lualine_x = {"encoding", "fileformat", "filetype"},
                        lualine_y = {"progress"},
                        lualine_z = {"location"}
                    }
                }
            })
        end
    },
    {
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
    },
    {
        "neovim/nvim-lspconfig",
        tag = "v0.1.8",
        config = function()
            require("lspconfig").pylsp.setup {}
        end
    },
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim"
        },
        opts = {
            close_if_last_window = true
        }
    },
    {
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
}
