-- Text file preferences
local exclude = {"neo-tree", "help", "man", "qf", "TelescopePrompt", "terminal"}

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "markdown", "text" },
	callback = function()
        local in_exclude_list = vim.tbl_contains(exclude, vim.bo.filetype)
        local has_no_name = vim.fn.expand("%:t") == ""
        if in_exclude_list or has_no_name then
            return
        end

		vim.wo.showbreak = "NONE"
		vim.opt_local.whichwrap:append("<,>")
		vim.keymap.set("i", "<Left>", "<C-o>h", { buffer = true, desc = "Insert-mode left with wrap" })
		vim.keymap.set("i", "<Right>", "<C-o>l", { buffer = true, desc = "Insert-mode right with wrap" })
		vim.keymap.set("n", "j", "gj", { buffer = true, desc = "Move down a visual line" })
		vim.keymap.set("n", "k", "gk", { buffer = true, desc = "Move up a visual line" })
		vim.keymap.set({ "n", "v" }, "<Down>", "gj", { buffer = true, desc = "Move down a visual line" })
		vim.keymap.set({ "n", "v" }, "<Up>", "gk", { buffer = true, desc = "Move up a visual line" })
		vim.keymap.set("i", "<Down>", "<C-o>gj", { buffer = true, desc = "Move down a visual line" })
		vim.keymap.set("i", "<Up>", "<C-o>gk", { buffer = true, desc = "Move up a visual line" })
	end,
})
