return {
	{
		"hrsh7th/cmp-nvim-lsp",
	},
	{
		"L3MON4D3/LuaSnip",
		dependencies = {
			"saadparwaiz1/cmp_luasnip",
			"rafamadriz/friendly-snippets",
		},
	},
	{
		"zbirenbaum/copilot-cmp",
		config = function()
			require("copilot_cmp").setup()
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-calc",
			"uga-rosa/cmp-dictionary",
		},
		config = function()
			local cmp = require("cmp")
			local compare = require("cmp.config.compare")

			require("luasnip.loaders.from_vscode").lazy_load()

			cmp.setup({
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				formatting = {
					format = function(_, vim_item)
						local max_abbr_width = 30
						local max_menu_width = 30
						if string.len(vim_item.abbr) > max_abbr_width then
							vim_item.abbr = string.sub(vim_item.abbr, 1, max_abbr_width) .. "..."
						end
						if vim_item.menu and string.len(vim_item.menu) > max_menu_width then
							vim_item.menu = string.sub(vim_item.menu, 1, max_menu_width) .. "..."
						end
						return vim_item
					end,
				},
				mapping = cmp.mapping.preset.insert(require("custom.keybinds").get_completion_map()),
				sources = cmp.config.sources({
					-- { name = "nvim_lsp_signature_help" },
					{ name = "copilot", priority = 8, group_index = 2 },
					{ name = "nvim_lsp", priority = 7, group_index = 2 },
					{ name = "luasnip", priority = 7, group_index = 2 },
					{ name = "buffer", priority = 6 }, -- first for locality sorting?
					{ name = "custom_spell", keyword_length = 3, priority = 5, keyword_pattern = [[\w\+]] },
					{ name = "dictionary", keyword_length = 3, priority = 5, keyword_pattern = [[\w\+]] }, -- from uga-rosa/cmp-dictionary plug
					-- { name = 'rg'},
					{ name = "nvim_lua", priority = 5 },
					{ name = "path", priority = 4},
					{ name = "fuzzy_path", priority = 4 }, -- from tzacher
					{ name = "calc", priority = 3 },
					-- { name = 'vsnip' },
				}),
				sorting = {
					priority_weight = 1.0,
					comparators = {
						require("copilot_cmp.comparators").prioritize,
						-- compare.score_offset, -- not good at all
						compare.locality,
						compare.recently_used,
						compare.score, -- based on :  score = score + ((#sources - (source_index - 1)) * sorting.priority_weight)
						compare.offset,
						compare.order,
						-- compare.scopes, -- what?
						-- compare.sort_text,
						-- compare.exact,
						-- compare.kind,
						-- compare.length, -- useless
					},
				},
			})

			-- Disable cmp for certain filetypes: HANDLED IN <init.lua>

            cmp.register_source("custom_spell", require("custom.spell").new())
		end,
	},
}
