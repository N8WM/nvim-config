local function enable()
    vim.g.lsplines_enabled = true
    vim.diagnostic.config({
        virtual_text = false,
        virtual_lines = {
            only_current_line = true,
            highlight_whole_line = true,
        },
    })
end

local function disable()
    vim.g.lsplines_enabled = false
    vim.diagnostic.config({
        virtual_text = true,
        virtual_lines = false,
    })
end

local function toggle()
    if vim.g.lsplines_enabled then
        disable()
    else
        enable()
    end
end

return {
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    config = function()
        require("lsp_lines").setup()

        disable()

        vim.keymap.set("n", "<Leader>l", toggle, { desc = "Toggle diagnostic display type" })
    end,
}
