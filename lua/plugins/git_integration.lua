return {
    {
        "tpope/vim-fugitive",
    },
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            local gs = require("gitsigns")
            gs.setup({
                current_line_blame = true,
                current_line_blame_opts = {
                    virt_text = true,
                    virt_text_pos = "eol",
                    delay = 350,
                    ignore_whitespace = false,
                    virt_text_priority = 100,
                },
            })

            vim.keymap.set("n", "<leader>gp", gs.preview_hunk, {})
            vim.keymap.set("n", "<leader>gs", gs.stage_hunk, {})
            vim.keymap.set("n", "<leader>gr", gs.reset_buffer, {})
            vim.keymap.set("v", "<leader>gs", function()
                gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
            end, {})
            vim.keymap.set("v", "<leader>gr", function()
                gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
            end, {})
            vim.keymap.set("n", "<leader>gS", gs.stage_buffer, {})
            vim.keymap.set("n", "<leader>gu", gs.undo_stage_hunk, {})
            vim.keymap.set("n", "<leader>gR", gs.reset_buffer, {})
            vim.keymap.set("n", "<leader>gp", gs.preview_hunk, {})
            vim.keymap.set("n", "<leader>gb", gs.toggle_current_line_blame, {})
            vim.keymap.set("n", "<leader>gd", gs.diffthis, {})
            vim.keymap.set("n", "<leader>gD", function()
                gs.diffthis("~")
            end, {})
            vim.keymap.set("n", "<leader>gx", gs.toggle_deleted, {})
        end,
    },
}
