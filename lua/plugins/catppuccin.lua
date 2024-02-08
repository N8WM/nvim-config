return {
	"catppuccin/nvim",
	lazy = false,
	name = "catppuccin",
	priority = 1000,
	config = function()
		vim.cmd.colorscheme("catppuccin")
        require("catppuccin").setup({
            flavour = "mocha",
            integrations = {
                cmp = true,
                gitsigns = true,
                nvimtree = true,
                treesitter = true,
                notify = true,
                mini = {
                    enabled = true,
                },
            }
        })

        -- Neotree colors
        local colors = require("catppuccin.palettes").get_palette "mocha"

        vim.api.nvim_set_hl(0, 'NeoTreeGitAdded', { fg = colors.green })
        vim.api.nvim_set_hl(0, 'NeoTreeGitConflict', { fg = colors.red })
        vim.api.nvim_set_hl(0, 'NeoTreeGitDeleted', { fg = colors.mauve })
        vim.api.nvim_set_hl(0, 'NeoTreeGitIgnored', { fg = colors.overlay0 })
        vim.api.nvim_set_hl(0, 'NeoTreeGitModified', { fg = colors.yellow })
        vim.api.nvim_set_hl(0, 'NeoTreeGitUntracked', { fg = colors.sapphire })
	end,
}
