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
		"hrsh7th/nvim-cmp",
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
				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
				}),
				sources = cmp.config.sources({
					-- { name = "nvim_lsp_signature_help" },
					{ name = "cmp_tabnine", priority = 8 },
					{ name = "nvim_lsp", priority = 8 },
					{ name = "luasnip", priority = 7 },
					{ name = "buffer", priority = 7 }, -- first for locality sorting?
					{ name = "spell", keyword_length = 3, priority = 5, keyword_pattern = [[\w\+]] },
					{ name = "dictionary", keyword_length = 3, priority = 5, keyword_pattern = [[\w\+]] }, -- from uga-rosa/cmp-dictionary plug
					-- { name = 'rg'},
					{ name = "nvim_lua", priority = 5 },
					{ name = "path" },
					{ name = "fuzzy_path", priority = 4 }, -- from tzacher
					{ name = "calc", priority = 3 },
					-- { name = 'vsnip' },
				}),
				sorting = {
					priority_weight = 1.0,
					comparators = {
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
		end,
	},
}
