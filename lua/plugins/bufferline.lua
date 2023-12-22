return {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
        local current_dir_full_path = vim.fn.getcwd()
        local current_dir_name = vim.fn.fnamemodify(current_dir_full_path, ':t')

        vim.opt.termguicolors = true

        require('bufferline').setup({
            options = {
                diagnostics = "nvim_lsp",
                separator_style = "padded_slant",
                offsets = {
                    {
                        filetype = "neo-tree",
                        text = current_dir_name,
                        highlight = "Directory",
                        separator = true
                    }
                }
            }
        })
    end
}
