local function open_float(scope)
	if vim.g.saved_float_bufnr and vim.api.nvim_buf_is_valid(vim.g.saved_float_bufnr) then
		return
	end
	local opts = {
		scope = scope,
		focusable = false,
		close_events = {
			"CursorMoved",
			"CursorMovedI",
			"BufHidden",
			"InsertCharPre",
			"WinLeave",
		},
	}
	local float_bufnr, winid = vim.diagnostic.open_float(opts)
	vim.g.saved_float_bufnr = float_bufnr
	vim.g.saved_winid = winid
end

local function close_float()
	if vim.g.saved_winid and vim.api.nvim_win_is_valid(vim.g.saved_winid) then
		vim.api.nvim_win_close(vim.g.saved_winid, true)
		vim.g.saved_float_bufnr = nil
		vim.g.saved_winid = nil
	end
end

local function lsp_hover()
	vim.lsp.buf.hover()
	close_float()
end

local function enable_open_float()
	if not vim.g.open_float_cmd then
		vim.api.nvim_create_autocmd({ "CursorHold" }, {
			pattern = "*",
			callback = function()
				for _, winid in pairs(vim.api.nvim_tabpage_list_wins(0)) do
					if vim.api.nvim_win_get_config(winid).zindex then
						return
					end
				end
				open_float("cursor")
			end,
		})
	end
	vim.g.open_float_cmd = true
end

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
		pcall(vim.api.nvim_del_keymap, "n", "K")
		vim.keymap.set("n", "K", lsp_hover, { desc = "View documentation" })
	end,
	map_error_float = function(_, _)
		vim.keymap.set("n", "<leader>k", function()
			open_float("line")
		end, { desc = "View diagnostic message" })
	end,
	enable_error_float = function(_, _)
		enable_open_float()
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

	-- Language Specific Plugins
	{ "cordx56/rustowl", dependencies = { "neovim/nvim-lspconfig" } },
}
