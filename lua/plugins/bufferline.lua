return {
	"akinsho/bufferline.nvim",
	version = "*",
	dependencies = "nvim-tree/nvim-web-devicons",
	config = function()
		local current_dir_full_path = vim.fn.getcwd()
		local current_dir_name = vim.fn.fnamemodify(current_dir_full_path, ":t")

		vim.opt.termguicolors = true

		local bufferline = require("bufferline")
		bufferline.setup({
			options = {
				diagnostics = "nvim_lsp",
				separator_style = "thin",
				offsets = {
					{
						filetype = "neo-tree",
						text = current_dir_name,
						highlight = "Directory",
						separator = true,
					},
				},
				style_preset = bufferline.style_preset.minimal,
			},
			highlights = {
				indicator_selected = {
					fg = "#6484ff",
				},
			},
		})

		vim.keymap.set("n", "<Tab>", ":BufferLineCycleNext<CR>", { silent = true })
		vim.keymap.set("n", "<S-Tab>", ":BufferLineCyclePrev<CR>", { silent = true })
		vim.keymap.set("n", "<leader><Tab>", ":BufferLineMoveNext<CR>", { silent = true })
		vim.keymap.set("n", "<leader><S-Tab>", ":BufferLineMovePrev<CR>", { silent = true })
	end,
}
