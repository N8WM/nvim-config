return {
    "echasnovski/mini.nvim",
    version = "*",
    config = function()
        require("mini.move").setup()

        require("mini.comment").setup({
            mappings = {
                comment = '<C-/>',
                comment_line = '<C-/>',
                comment_visual = '<C-/>',
                textobject = 'gc',
            },
        })

        local map = require("mini.map")
        map.setup({
            symbols = {
                encode = map.gen_encode_symbols.dot("4x2")
            },
            integrations = {
                map.gen_integration.builtin_search(),
                map.gen_integration.diagnostic(),
            },
        })
        vim.keymap.set("n", "<CR>", map.toggle, {})
    end,
}
