-- return {
-- 	"moll/vim-bbye",
-- 	config = function()
-- 		vim.keymap.set("n", "<c-x>", ":Bdelete<CR>", {
--             silent = true,
--             desc = "Close the active buffer"
--         })
-- 	end,
-- }
return {
	"famiu/bufdelete.nvim",
	config = function()
		vim.keymap.set("n", "<C-x>", ":Bdelete<CR>", { silent = true, desc = "Close the active buffer" })
	end,
}
