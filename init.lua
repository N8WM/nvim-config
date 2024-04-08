---@diagnostic disable: undefined-global
-- Set options
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

-- The following doesn't work for some reason
-- vim.api.nvim_create_autocmd("FileType", {
--     pattern = { "markdown", "tex", "txt", "text", "rst", "vimwiki", "md" },
--     callback = function()
--         vim.wo.showbreak = ""
--     end,
-- })

-- Set autocommands
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "css", "html", "javascript", "tex", "yaml", "markdown" },
    callback = function()
        local bufnr = vim.api.nvim_get_current_buf()
        vim.api.nvim_buf_set_option(bufnr, "tabstop", 2)
        vim.api.nvim_buf_set_option(bufnr, "softtabstop", 2)
        vim.api.nvim_buf_set_option(bufnr, "shiftwidth", 2)
    end,
})

vim.api.nvim_create_autocmd("BufReadPost", {
    pattern = "*",
    callback = function()
        if vim.fn.line("'\"") > 0 and vim.fn.line("'\"") <= vim.fn.line("$") then
            vim.cmd('normal! g`"')
        end
    end,
})

-- Set undo options if version is 7.3 or above
if vim.version().minor >= 3 then
    vim.o.undodir = os.getenv("HOME") .. "/.vim/backup"
    vim.o.undofile = true
    vim.o.undoreload = 10000
end

vim.g.mapleader = " "

vim.keymap.set({ "n", "v", "i" }, "<M-Up>", "<Esc><C-w><Up>", { noremap = true, desc = "Focus window above" })
vim.keymap.set({ "n", "v", "i" }, "<M-Down>", "<Esc><C-w><Down>", { noremap = true, desc = "Focus window below" })
vim.keymap.set({ "n", "v", "i" }, "<M-Left>", "<Esc><C-w><Left>", { noremap = true, desc = "Focus window left" })
vim.keymap.set({ "n", "v", "i" }, "<M-Right>", "<Esc><C-w><Right>", { noremap = true, desc = "Focus window right" })

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins")
