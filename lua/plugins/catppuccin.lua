local flavor = "mocha"

return {
	"catppuccin/nvim",
	lazy = false,
	name = "catppuccin",
	priority = 1000,
	config = function()
		require("catppuccin").setup({
			flavour = flavor,
			integrations = {
				bufferline = true,
				cmp = true,
				gitsigns = true,
				neotree = true,
				noice = true,
				treesitter = true,
				notify = true,
				mini = {
					enabled = true,
				},
				which_key = true,
			},
            highlight_overrides = {
                all = function(colors)
                    return {
                        NeoTreeNormal = { bg = colors.base },
                        NeoTreeNormalNC = { bg = colors.base },
                        NeoTreeEndOfBuffer = { bg = colors.base, fg = colors.base },
                        NeoTreeWinSeparator = { fg = colors.crust },

                        NeoTreeGitAdded = { fg = colors.green },
                        NeoTreeGitConflict = { fg = colors.red },
                        NeoTreeGitDeleted = { fg = colors.mauve },
                        NeoTreeGitIgnored = { fg = colors.overlay0 },
                        NeoTreeGitModified = { fg = colors.yellow },
                        NeoTreeGitUntracked = { fg = colors.sapphire },
                    }
                end
            }
		})
		vim.cmd.colorscheme("catppuccin")
	end,
}
