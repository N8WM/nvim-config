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
        config = function()
            local cmp = require("cmp")
            local compare = require("cmp.config.compare")

            ---@diagnostic disable-next-line: deprecated
            local unpack = table.unpack or unpack
            local has_words_before = function()
                if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
                    return false
                end
                local line, col = unpack(vim.api.nvim_win_get_cursor(0))
                return col ~= 0
                    and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match("^%s*$") == nil
            end

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
                mapping = cmp.mapping.preset.insert({
                    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-e>"] = cmp.mapping.abort(),
                    ["<CR>"] = cmp.mapping.confirm({ select = false }),
                    ["<Tab>"] = vim.schedule_wrap(function(fallback)
                        if cmp.visible() and has_words_before() then
                            cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
                        else
                            fallback()
                        end
                    end),
                }),
                sources = cmp.config.sources({
                    -- { name = "nvim_lsp_signature_help" },
                    { name = "copilot",    priority = 8 },
                    { name = "nvim_lsp",   priority = 8 },
                    { name = "luasnip",    priority = 7 },
                    { name = "buffer",     priority = 7 },                                  -- first for locality sorting?
                    { name = "spell",      keyword_length = 3, priority = 5, keyword_pattern = [[\w\+]] },
                    { name = "dictionary", keyword_length = 3, priority = 5, keyword_pattern = [[\w\+]] }, -- from uga-rosa/cmp-dictionary plug
                    -- { name = 'rg'},
                    { name = "nvim_lua",   priority = 5 },
                    { name = "path" },
                    { name = "fuzzy_path", priority = 4 }, -- from tzacher
                    { name = "calc",       priority = 3 },
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

            -- Disable cmp for certain filetypes
            vim.api.nvim_create_autocmd("FileType", {
                pattern = {"markdown", "text"},
                callback = function()
                    require'cmp'.setup.buffer { enabled = false }
                end,
            })
        end,
    },
}
