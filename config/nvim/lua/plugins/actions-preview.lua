return {
    "aznhe21/actions-preview.nvim",
    dependencies = {
        {"nvim-telescope/telescope.nvim"},
    },
    config = function()
        local hl = require("actions-preview.highlight")

        require("actions-preview").setup({
            backend = { "telescope" },  
            telescope = {
                sorting_strategy = "ascending",
                layout_strategy = "vertical",
                layout_config = {
                    width = 0.8,
                    height = 0.9,
                    prompt_position = "top",
                    preview_cutoff = 20,
                    preview_height = function(_, _, max_lines)
                        return max_lines - 15
                    end,
                },
            },
            highlight_command = {
                hl.delta(
                    "delta --no-gitconfig --side-by-side --hunk-header-style omit --file-style omit"
                ),
            },
        })
    end,
}
