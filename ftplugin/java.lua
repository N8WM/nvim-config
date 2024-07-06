local config = {
	cmd = { vim.fn.expand("~/.local/share/nvim/mason/bin/jdtls") },
	root_dir = vim.fs.dirname(vim.fs.find({ ".gradlew", ".git", "mvnw" }, { upward = true })[1]),
	on_attach = Generate_on_attach({
		Attachable.map_code_actions,
		Attachable.map_definition,
		Attachable.map_implementation,
		Attachable.map_references,
		Attachable.map_rename,
	}),
}

require("jdtls").start_or_attach(config)
