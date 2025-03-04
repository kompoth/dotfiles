return { 
    {
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
            require("lspconfig").pylsp.setup {
                pylsp = {
                    pylsp_mypy = {
                        enabled = true,
                    },
                }
            }
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
    },
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require('gitsigns').setup({
                signcolumn = true,
                current_line_blame = true,
                signs = {
                    add          = { text = "+" },
                    change       = { text = "~" },
                    delete       = { text = "-" },
                    topdelete    = { text = "-" },
                    changedelete = { text = "~" },
                    untracked    = { text = "┆" },
                },
                signs_staged = {
                    add          = { text = "+" },
                    change       = { text = "~" },
                    delete       = { text = "-" },
                    topdelete    = { text = "-" },
                    changedelete = { text = "~" },
                    untracked    = { text = "┆" },
                },
                on_attach = function(bufnr)
                    local gitsigns = require("gitsigns")

                    local function map(mode, l, r, opts)
                        opts = opts or {}
                        opts.buffer = bufnr
                        vim.keymap.set(mode, l, r, opts)
                    end

                    -- Actions
                    map("n", "<leader>gs", gitsigns.stage_hunk)
                    map("n", "<leader>gS", gitsigns.stage_buffer)
                    map("v", "<leader>gs", function() gitsigns.stage_hunk {vim.fn.line("."), vim.fn.line("v")} end)
                end
            })
        end
    },
    {
        "rbong/vim-flog",
        lazy = true,
        cmd = { "Flog", "Flogsplit", "Floggit" },
        dependencies = {
            "tpope/vim-fugitive",
        },
    },
    -- {
    --     "folke/trouble.nvim",
    --     opts = {},
    --     cmd = "Trouble",
    -- },
}
