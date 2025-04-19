return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			local config = require("nvim-treesitter.configs")
			config.setup({
				auto_install = true,
				highlight = { enable = true },
				indent = { enable = true },
			})
		end,
	},

    -- Similar to VS Code's Sticky Scroll, disabled since we have dropbar.nvim
	-- {
	-- 	"nvim-treesitter/nvim-treesitter-context",
	-- 	config = function()
	-- 		require("treesitter-context").setup({
	-- 			enable = true,
	-- 			multiwindow = false,
	-- 			max_lines = 0,
	-- 			min_window_height = 0,
	-- 			line_numbers = true,
	-- 			multiline_threshold = 20,
	-- 			trim_scope = "outer",
	-- 			mode = "cursor",
	-- 			separator = nil,
	-- 			zindex = 20,
	-- 			on_attach = nil,
	-- 		})
	-- 	end,
	-- },
}
