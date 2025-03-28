-- Text file preferences
vim.api.nvim_create_autocmd("FileType", {
	pattern = vim.g.txt_files,
	callback = function()
		if require("custom.helpers.filetypes").txt_file_is_blacklisted() then
			return
		end

		vim.wo.showbreak = "NONE"
		require("custom.keybinds").text_files()
	end,
})
