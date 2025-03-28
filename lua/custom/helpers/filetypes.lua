local M = {}

function M.txt_file_is_blacklisted()
	local in_blacklist = vim.tbl_contains(vim.g.txt_files_blacklist, vim.bo.filetype)
	local has_no_name = vim.fn.expand("%:t") == ""
	return in_blacklist or has_no_name
end

return M
