return {
	"akinsho/bufferline.nvim",
	version = "*",
	dependencies = "nvim-tree/nvim-web-devicons",
    after = "catppuccin",
	config = function()
		local bufferline = require("bufferline")
        local highlights = require("catppuccin.groups.integrations.bufferline").get()
        local catppuccin = require("catppuccin.palettes").get_palette(vim.g.catppuccin_flavor)
        local title_text = require("custom.neotree_title").title

        highlights.indicator_selected = { fg = "#64a4ff" }
        highlights.offset_separator = { fg = catppuccin.base, bg = catppuccin.crust }

		bufferline.setup({
            highlights = highlights,
			options = {
				diagnostics = "nvim_lsp",
				separator_style = "thin",
				offsets = {
					{
						filetype = "neo-tree",
                        text = title_text,
						separator = "▌",
                        text_align = "left",
                        highlight = "Normal"
					},
				},
				-- style_preset = bufferline.style_preset.default,
			},
		})

		vim.keymap.set("n", "<Tab>", ":BufferLineCycleNext<CR>", {
			silent = true,
			desc = "Move to the next buffer",
		})
		vim.keymap.set("n", "<S-Tab>", ":BufferLineCyclePrev<CR>", {
			silent = true,
			desc = "Move to the previous buffer",
		})
		vim.keymap.set("n", "<leader><Tab>", ":BufferLineMoveNext<CR>", {
			silent = true,
			desc = "Move the active buffer to the next position",
		})
		vim.keymap.set("n", "<leader><S-Tab>", ":BufferLineMovePrev<CR>", {
			silent = true,
			desc = "Move the active buffer to the previous position",
		})
	end,
}
