return {
	"iamcco/markdown-preview.nvim",
	cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
	ft = { "markdown" },
	build = ":call mkdp#util#install()",
	config = function()
		vim.api.nvim_create_autocmd("FileType", {
			pattern = "markdown",
			callback = function()
				vim.keymap.set("n", "<leader>s", function()
                    vim.cmd("MarkdownPreviewToggle")
                end, {
					silent = true,
					desc = "Preview markdown in browser",
					buffer = true, -- makes the keymap local to the markdown buffer
				})
			end,
		})
	end,
}
