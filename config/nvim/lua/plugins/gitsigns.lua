return {
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
}
