-- File-specific spacing
local M = {}

function M.set_buf_tab_width(width)
	local bufnr = vim.api.nvim_get_current_buf()
	vim.api.nvim_buf_set_option(bufnr, "tabstop", width)
	vim.api.nvim_buf_set_option(bufnr, "softtabstop", width)
	vim.api.nvim_buf_set_option(bufnr, "shiftwidth", width)
end

function M.auto_two_tab_width()
	vim.api.nvim_create_autocmd("FileType", {
		pattern = vim.g.two_space_tab_fts,
		callback = function()
			local bufnr = vim.api.nvim_get_current_buf()
			vim.api.nvim_buf_set_option(bufnr, "tabstop", 2)
			vim.api.nvim_buf_set_option(bufnr, "softtabstop", 2)
			vim.api.nvim_buf_set_option(bufnr, "shiftwidth", 2)
		end,
	})
end

return M
