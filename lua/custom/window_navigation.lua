vim.keymap.set({ "n", "v", "i" }, "<M-Up>", "<Esc><C-w><Up>", { noremap = true, desc = "Focus window above" })
vim.keymap.set({ "n", "v", "i" }, "<M-Down>", "<Esc><C-w><Down>", { noremap = true, desc = "Focus window below" })
vim.keymap.set({ "n", "v", "i" }, "<M-Left>", "<Esc><C-w><Left>", { noremap = true, desc = "Focus window left" })
vim.keymap.set({ "n", "v", "i" }, "<M-Right>", "<Esc><C-w><Right>", { noremap = true, desc = "Focus window right" })

vim.keymap.set({ "n", "v", "i" }, "<M-Tab>", "<Esc><C-w>w", { noremap = true, desc = "Next window" })
vim.keymap.set({ "n", "v", "i" }, "<M-S-Tab>", "<Esc><C-w>W", { noremap = true, desc = "Previous window" })
