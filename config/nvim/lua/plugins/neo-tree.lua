return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim"
    },
    config = function()
        require("neo-tree").setup({
            default_component_configs = {
                name = {
                    use_git_status_colors = true,
                },
                git_status = {
                    symbols = {
                        -- Change type
                        added = "",    -- redundant due to color indication
                        modified = "", -- redundant due to color indication
                        deleted = "", -- this can only be used in the git_status source
                        renamed = "", -- this can only be used in the git_status source
                        -- Status type
                        untracked = "",
                        ignored = "",
                        unstaged = ""  ,
                        staged = "",
                    }
                }
            }
        })
    end
 }
