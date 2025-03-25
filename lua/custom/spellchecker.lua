local enabled_ft = { "markdown", "text" }
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
	pattern = enabled_ft,
	callback = function()
		-- Enable spellcheck
		vim.opt_local.spell = true
		vim.opt_local.spelllang = "en_us"

		-- Manual spell suggestion trigger
		vim.keymap.set({ "n", "i" }, "<C-k>", function()
			end_word_cursor()

			vim.schedule(function()
				cmp.complete({ config = { enabled = true } })
			end)
		end, {
			desc = "Spelling suggestions",
			buffer = true, -- make it local to the current markdown/text buffer
		})
		vim.keymap.set({ "n", "i" }, "<C-S-k>", function()
			local original_cursor = vim.api.nvim_win_get_cursor(0)

			vim.cmd.normal("z=1")

			local line = vim.fn.getline(original_cursor[1])
			local new_col = math.min(original_cursor[2], #line)
			vim.api.nvim_win_set_cursor(0, { original_cursor[1], new_col })
		end, {
			desc = "Choose first spelling suggestion",
			buffer = true, -- make it local to the current buffer if desired
		})
	end,
})

-- Override completions for spellchecked files
for _, ft in ipairs(enabled_ft) do
	cmp.setup.filetype(ft, {
		sources = cmp.config.sources({
			enabled = false,
			window = {
				completion = cmp.config.window.bordered(),
				documentation = cmp.config.window.bordered(),
			},
			mapping = cmp.mapping.preset.insert({
				["<C-b>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<C-Space>"] = cmp.mapping.complete(),
				["<Esc>"] = cmp.mapping.abort(),
				["<CR>"] = cmp.mapping.confirm({ select = false }),
				["<Tab>"] = vim.schedule_wrap(function(fallback)
					if cmp.visible() then
						cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
					else
						fallback()
					end
				end),

				-- Close CMP window if cursor moves horizontally
				["<Left>"] = cmp.mapping({
					i = function(fallback)
						if cmp.visible() then
							cmp.close()
						end
						fallback()
					end,
				}),
				["<Right>"] = cmp.mapping({
					i = function(fallback)
						if cmp.visible() then
							cmp.close()
						end
						fallback()
					end,
				}),
			}),
			sources = cmp.config.sources({
				{ name = "calc", priority = 9 },
				{ name = "spell", priority = 8, option = { keep_all_entries = false } },
				{ name = "luasnip", priority = 7 },
			}),
		}),
	})
end
