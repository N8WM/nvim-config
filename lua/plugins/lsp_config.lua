Attachable = {
	map_rename = function(_, _)
		vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename symbol under cursor" })
	end,
	map_code_actions = function(_, _)
		vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "View code actions" })
	end,
	map_definition = function(_, _)
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "View definition" })
	end,
	map_implementation = function(_, _)
		vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "View implementation" })
	end,
	map_references = function(_, _)
		vim.keymap.set("n", "gr", require("telescope.builtin").lsp_references, { desc = "View references" })
	end,
	map_hover = function(_, _)
		vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "View documentation" })
	end,
}

function Generate_on_attach(attachments)
	return function(client, bufnr)
		for _, func in pairs(attachments) do
			func(client, bufnr)
		end
	end
end

return {
	{
		"mfussenegger/nvim-jdtls",
	},
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"angularls",
					"arduino_language_server",
					"bashls",
					"clangd",
					"omnisharp",
					"cmake",
					"cssls",
					"dockerls",
					"eslint",
					"fortls",
					"html",
					"jsonls",
					"tsserver",
					"texlab",
					"lua_ls",
					"marksman",
					"pyright",
					"rust_analyzer",
					"vimls",
					"lemminx",
					"yamlls",
					"jdtls",
					"slint_lsp",
					"sqlls",
				},
				automatic_installation = true,
			})
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			require("mason-lspconfig").setup_handlers({
				-- The first entry (without a key) will be the default handler
				-- and will be called for each installed server that doesn't have
				-- a dedicated handler.
				function(server_name) -- default handler (optional)
					require("lspconfig")[server_name].setup({
						on_attach = Generate_on_attach(Attachable),
						capabilities = capabilities,
					})
				end,

				["jdtls"] = function() end,

				-- ["pyright"] = function()
				-- 	lspconfig.pyright.setup({
				-- 		on_attach = generate_on_attach(attachable),
				-- 		capabilities = capabilities,
				-- 	})
				-- end,
				-- ["ruff_lsp"] = function()
				-- 	lspconfig.ruff_lsp.setup({
				-- 		on_attach = generate_on_attach({
				-- 			attachable.map_code_actions,
				-- 		}),
				-- 		capabilities = capabilities,
				-- 		init_options = {
				-- 			settings = {
				-- 				args = {
				-- 					"--ignore",
				-- 					"D100",
				-- 				},
				-- 			},
				-- 		},
				-- 	})
				-- end,

				-- ["lua_ls"] = function()
				--     lspconfig.lua_ls.setup({...})
				-- end
			})
		end,
	},
	{ "neovim/nvim-lspconfig" },
	{
		"nvimtools/none-ls.nvim",
		config = function()
			vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
		end,
	},
	{
		"jay-babu/mason-null-ls.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			"nvimtools/none-ls.nvim",
		},

		config = function()
			local null_ls = require("null-ls")
			local sfignore = "CP02,RF04"

			null_ls.setup({
				sources = {
					null_ls.builtins.diagnostics.sqlfluff.with({
						extra_args = { "--dialect", "mysql", "--exclude-rules", sfignore },
					}),
					null_ls.builtins.formatting.sqlfluff.with({
						extra_args = { "--dialect", "mysql", "--exclude-rules", sfignore },
					}),
				},
			})
			require("mason-null-ls").setup({
				ensure_installed = {
					-- formatting
					"stylua",
					"prettierd",
					"isort",
					"black",
					"pyright",
					-- diagnostics
					"eslint_d",
					"sqlfluff",
				},
				automatic_installation = true,
				handlers = {},
			})
		end,
	},
}
