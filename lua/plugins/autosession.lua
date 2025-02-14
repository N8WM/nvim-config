return {
	{
		"rmagatti/auto-session",
		dependencies = {
			"nvim-telescope/telescope.nvim",
		},
		config = function()
            local function close_ftree()
                vim.cmd("Neotree close")
            end

            local function open_ftree()
                vim.cmd("Neotree show")
            end

			require("auto-session").setup({
				auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
				close_unsupported_windows = true,
                log_level = "error",
                pre_save_cmds = {close_ftree},
                post_save_cmds = {open_ftree},
                post_open_cmds = {open_ftree},
                post_restore_cmds = {open_ftree},
                cwd_change_handling = {
                    restore_upcoming_session = true,
                    pre_cwd_changed_hook = close_ftree,
                    post_cwd_changed_hook = open_ftree,
                },
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
