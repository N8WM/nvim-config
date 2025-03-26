-- File-specific spacing
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "css", "html", "xml", "javascript", "tex", "yaml", "toml", "markdown" },
	callback = function()
		local bufnr = vim.api.nvim_get_current_buf()
		vim.api.nvim_buf_set_option(bufnr, "tabstop", 2)
		vim.api.nvim_buf_set_option(bufnr, "softtabstop", 2)
		vim.api.nvim_buf_set_option(bufnr, "shiftwidth", 2)
	end,
})
