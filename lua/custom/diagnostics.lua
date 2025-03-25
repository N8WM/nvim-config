vim.diagnostic.config({
	float = { border = "rounded" },
	virtual_text = false,
	signs = true,
})

-- Define a function to toggle diagnostics
local function toggleDiagnostics()
	if vim.g.diagnostics_visible == nil then
		vim.g.diagnostics_visible = true
	end

	if vim.g.diagnostics_visible then
		vim.diagnostic.disable(0)
		vim.g.diagnostics_visible = false
		print("Diagnostics hidden")
	else
		vim.diagnostic.enable(0)
		vim.g.diagnostics_visible = true
		print("Diagnostics revealed")
	end
end

-- Set up a key mapping to toggle diagnostics
vim.keymap.set("n", "<leader>d", toggleDiagnostics, {
	noremap = true,
	silent = true,
	desc = "Toggle diagnostics",
})
