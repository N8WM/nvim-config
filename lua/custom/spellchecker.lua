local cmp = require("cmp")

-- Helper function for spellcheck keybinds
local function end_word_cursor()
	vim.cmd("startinsert")
	local col_org = vim.fn.col(".")
	vim.cmd.normal("hh")
	local cword = vim.fn.expand("<cword>")
	local col = vim.fn.col(".")
	local one_letter_word_first = #cword == 1 and col == 1
	local started_at_3 = col_org == 3
	local char_is_cword = vim.fn.getline("."):sub(col, col) == cword
	if not (one_letter_word_first and char_is_cword) or started_at_3 then
		vim.cmd.normal("e")
	end
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Right>", true, false, true), "n", false)
end

-- Enabling spellcheck and completion binding
vim.api.nvim_create_autocmd("FileType", {
	pattern = vim.g.txt_files,
	callback = function()
		if require("custom.helpers.filetypes").txt_file_is_blacklisted() then
			return
		end

		-- Enable spellcheck
		vim.opt_local.spell = true
		vim.opt_local.spelllang = "en_us"

		-- Manual spell suggestion trigger
		local function show_suggestions()
			end_word_cursor()

			vim.schedule(function()
				cmp.complete({ config = { enabled = true } })
			end)
		end

		-- Choose first suggestion
		local function choose_first()
			local original_cursor = vim.api.nvim_win_get_cursor(0)
			vim.cmd.normal("z=1")
			local line = vim.fn.getline(original_cursor[1])
			local new_col = math.min(original_cursor[2], #line)
			vim.api.nvim_win_set_cursor(0, { original_cursor[1], new_col })
		end

		require("custom.keybinds").spell_checker(show_suggestions, choose_first)
	end,
})

-- Override completions for spellchecked files
for _, ft in ipairs(vim.g.txt_files) do
	cmp.setup.filetype(ft, {
		sources = cmp.config.sources({
			enabled = false,
			window = {
				completion = cmp.config.window.bordered(),
				documentation = cmp.config.window.bordered(),
			},
			mapping = cmp.mapping.preset.insert(require("custom.keybinds").get_completion_map()),
			sources = cmp.config.sources({
				{ name = "calc", priority = 9 },
				{ name = "custom_spell", priority = 8, option = { keep_all_entries = true } },
				{ name = "luasnip", priority = 7 },
			}),
		}),
	})
end
