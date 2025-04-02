vim.g.mapleader = " " -- LEADER KEY: <SPACE>
vim.o.filetype = "on"
vim.o.syntax = "on"
vim.o.cursorline = true
vim.o.expandtab = true
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.autoindent = true
vim.o.smartindent = true
vim.o.number = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.incsearch = true
vim.o.hlsearch = true
vim.o.showcmd = true
vim.o.showmode = true
vim.o.scrolloff = 1
vim.o.wildmenu = true
vim.o.wildmode = "list:longest"
vim.o.wildignore = "*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx"
vim.o.conceallevel = 0

vim.o.pumheight = 10
vim.o.pumblend = 0 -- 20
vim.o.winblend = 0 -- 10
vim.o.guicursor = "i:block-blinkon1"
-- vim.o.textwidth = 80

vim.o.wrap = true
vim.o.linebreak = true
vim.o.showbreak = "↪ "

-- Fold settings
vim.o.foldmethod = "expr"
vim.o.foldexpr = "nvim_treesitter#foldexpr()"
vim.o.foldlevel = 99 -- Open all folds by default

vim.o.updatetime = 300
vim.o.shortmess = vim.o.shortmess .. "c"

-- What should be treated as an editable text file?
vim.g.txt_files = { "markdown", "text" }
-- What text files should not be affected by this?
vim.g.txt_files_blacklist = { "neo-tree", "help", "man", "qf", "TelescopePrompt", "terminal" }
-- What filetypes should only have two spaces per tab?
vim.g.two_space_tab_fts = { "css", "html", "xml", "javascript", "tex", "yaml", "toml", "markdown", "json" }
