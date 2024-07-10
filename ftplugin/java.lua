local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = vim.fn.expand("~/.local/share/nvim/jdtls/") .. project_name

local config = {
	cmd = {
		vim.fn.expand("~/.local/share/nvim/mason/bin/jdtls"),
		"-data",
		workspace_dir,
	},
	root_dir = vim.fs.root(0, { ".git", "mvnw", "gradlew" }),
	on_attach = Generate_on_attach({
		Attachable.map_code_actions,
		Attachable.map_definition,
		Attachable.map_implementation,
		Attachable.map_references,
		Attachable.map_rename,
	}),
}

require("jdtls").start_or_attach(config)
