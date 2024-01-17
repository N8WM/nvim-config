local on_attach = function(_, _)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, {})
    vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})

    vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, {})
    vim.keymap.set("n", "gr", require("telescope.builtin").lsp_references, {})
    vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
end

return {
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
                },
            })
            local capabilities = require('cmp_nvim_lsp').default_capabilities()
            require("mason-lspconfig").setup_handlers({
                -- The first entry (without a key) will be the default handler
                -- and will be called for each installed server that doesn't have
                -- a dedicated handler.
                function(server_name) -- default handler (optional)
                    require("lspconfig")[server_name].setup({
                        on_attach = on_attach,
                        capabilities = capabilities,
                    })
                end,

                -- ["lua_ls"] = function()
                --     local lspconfig = require("lspconfig")
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
            require("mason-null-ls").setup({
                ensure_installed = {
                    -- formatting
                    "stylua",
                    "prettierd",
                    "isort",
                    "black",
                    -- diagnostics
                    "eslint_d",
                },
                automatic_installation = true,
                handlers = {},
            })
            null_ls.setup({
                sources = {
                    -- Anything not supported by mason.
                },
            })
        end,
    },
}
