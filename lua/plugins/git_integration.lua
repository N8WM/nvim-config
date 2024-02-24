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

			vim.keymap.set("n", "<leader>gp", gs.preview_hunk, { desc = "Git: preview hunk" })
			vim.keymap.set("n", "<leader>gs", gs.stage_hunk, { desc = "Git: stage hunk" })
			vim.keymap.set("n", "<leader>gr", gs.reset_buffer, { desc = "Git: reset buffer" })
			vim.keymap.set("v", "<leader>gs", function()
				gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
			end, { desc = "Git: stage selection" })
			vim.keymap.set("v", "<leader>gr", function()
				gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
			end, { desc = "Git: reset selection" })
			vim.keymap.set("n", "<leader>gS", gs.stage_buffer, { desc = "Git: stage buffer" })
			vim.keymap.set("n", "<leader>gu", gs.undo_stage_hunk, { desc = "Git: undo stage hunk" })
			vim.keymap.set("n", "<leader>gR", gs.reset_buffer, { desc = "Git: reset buffer" })
			vim.keymap.set("n", "<leader>gp", gs.preview_hunk, { desc = "Git: preview hunk" })
			vim.keymap.set("n", "<leader>gb", gs.toggle_current_line_blame, { desc = "Git: toggle inline blame" })
			vim.keymap.set("n", "<leader>gd", gs.diffthis, { desc = "Git: diff this" })
			vim.keymap.set("n", "<leader>gD", function()
				gs.diffthis("~")
			end, { desc = "Git: diff this against HEAD" })
			vim.keymap.set("n", "<leader>gx", gs.toggle_deleted, { desc = "Git: toggle deleted" })
		end,
	},
}
