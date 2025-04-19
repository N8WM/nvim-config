return {
	"echasnovski/mini.nvim",
	version = "*",
	config = function()
		require("mini.move").setup()

		local map = require("mini.map")
		map.setup({
			symbols = {
				encode = map.gen_encode_symbols.dot("4x2"),
			},
			integrations = {
				map.gen_integration.builtin_search(),
				map.gen_integration.diagnostic(),
			},
		})
		vim.keymap.set("n", "<CR>", map.toggle, { desc = "Toggle minimap" })
	end,
}
