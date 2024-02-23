return {
	"akinsho/toggleterm.nvim",
	version = "*",
	config = function()
		require("toggleterm").setup({
			open_mapping = [[<c-\>]],
			hide_numbers = true,
			highlights = {
				FloatBorder = {
					guifg = "#4b5263",
				},
			},
			direction = "float",
			shade_terminals = true,
			auto_scroll = true,
			float_opts = {
				border = "curved",
				title_pos = "center",
			},
		})
	end,
}
