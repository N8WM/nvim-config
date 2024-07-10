return {
	--"github/copilot.vim"
	"zbirenbaum/copilot.lua",
	cmd = "Copilot",
	event = "InsertEnter",
	config = function()

		require("copilot").setup({
			panel = {
				enabled = true,
				auto_refresh = false,
				keymap = {
					jump_prev = "[[",
					jump_next = "]]",
					accept = "<CR>",
					refresh = "gr",
					open = "<M-CR>",
				},
				layout = {
					position = "bottom", -- | top | left | right
					ratio = 0.4,
				},
			},
			suggestion = {
				enabled = true,
				auto_trigger = false,
				debounce = 75,
				keymap = {
					accept = "<M-l>",
					accept_word = false,
					accept_line = false,
					next = "<M-]>",
					prev = "<M-[>",
					dismiss = "<C-]>",
				},
			},
			filetypes = {
				yaml = false,
				markdown = false,
				help = false,
				gitcommit = false,
				gitrebase = false,
				hgcommit = false,
				svn = false,
				cvs = false,
				["."] = false,
			},
			copilot_node_command = "node", -- Node.js version must be > 18.x
			server_opts_overrides = {},
		})

        local enabled = false
        vim.cmd("Copilot disable")

        local function toggle_copilot()
            if enabled then
                enabled = false
                vim.cmd("Copilot disable")
                print("Copilot completions disabled")
            else
                enabled = true
                vim.cmd("Copilot enable")
                print("Copilot completions enabled")
            end
        end

        vim.keymap.set("n", "<leader>ct", toggle_copilot, { noremap = true, desc = "Toggle Copilot" })

	end,
}
