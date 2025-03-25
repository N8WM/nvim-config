-- Remember position of cursor
vim.api.nvim_create_autocmd("BufReadPost", {
	pattern = "*",
	callback = function()
		if vim.fn.line("'\"") > 0 and vim.fn.line("'\"") <= vim.fn.line("$") then
			vim.cmd('normal! g`"')
		end
	end,
})

-- Remember undo history
vim.o.undodir = os.getenv("HOME") .. "/.vim/backup"
vim.o.undofile = true
vim.o.undoreload = 10000
