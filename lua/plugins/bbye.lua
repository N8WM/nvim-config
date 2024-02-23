return {
	"moll/vim-bbye",
	config = function()
		vim.keymap.set("n", "<c-x>", ":Bdelete<CR>", { silent = true })
	end,
}
