return {
	{
		"rmagatti/auto-session",
		dependencies = {
			"nvim-telescope/telescope.nvim",
		},
		config = function()
			require("auto-session").setup({
				auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
				close_unsupported_windows = true,
			})
			vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
			vim.keymap.set(
				"n",
				"<C-s>",
				require("auto-session.session-lens").search_session,
				{ noremap = true, desc = "Search for a session" }
			)
		end,
	},
}
