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
        local keybinds = require("custom.keybinds").bufferline

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

		keybinds()
	end,
}
