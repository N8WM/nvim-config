local M = {}

local function map_many(mappings, default_opts)
    default_opts = default_opts or { noremap = true, silent = true }
    for _, mapping in ipairs(mappings) do
        local mode, lhs, rhs, opts = require("custom.helpers.util").unpack(mapping)
        opts = vim.tbl_extend("force", default_opts, opts or {})
        vim.keymap.set(mode, lhs, rhs, opts)
    end
end

---------------------------------------------------------------------------------

-- Always bound
function M.general()
    local tw = require("custom.contextual_prefs.two_space_tab_fts").set_buf_tab_width

    map_many({
        { { "n", "v", "i" }, "<M-Up>", "<Esc><C-w><Up>", { desc = "Focus window above" } },
        { { "n", "v", "i" }, "<M-Down>", "<Esc><C-w><Down>", { desc = "Focus window below" } },
        { { "n", "v", "i" }, "<M-Left>", "<Esc><C-w><Left>", { desc = "Focus window left" } },
        { { "n", "v", "i" }, "<M-Right>", "<Esc><C-w><Right>", { desc = "Focus window right" } },
        { { "n", "v", "i" }, "<M-Tab>", "<Esc><C-w>w", { desc = "Next window" } },
        { { "n", "v", "i" }, "<M-S-Tab>", "<Esc><C-w>W", { desc = "Previous window" } },
        { "n", "<leader>2", function() tw(2) end, { desc = "Buf tab width = 2" } },
        { "n", "<leader>4", function() tw(4) end, { desc = "Buf tab width = 4" } },
        { { "n", "v", "i" }, "<C-c>", "<Esc>gg0vG$\"+y<Esc>", { desc = "Copy contents of file" } },
    })
end

---------------------------------------------------------------------------------

function M.text_files()
    map_many({
        { "n", "j", "gj", { desc = "Move down a visual line" } },
        { "n", "k", "gk", { desc = "Move up a visual line" } },
        { { "n", "v" }, "<Down>", "gj", { desc = "Move down a visual line" } },
        { { "n", "v" }, "<Up>", "gk", { desc = "Move up a visual line" } },
        { "i", "<Down>", "<C-o>gj", { desc = "Move down a visual line" } },
        { "i", "<Up>", "<C-o>gk", { desc = "Move up a visual line" } },
    }, { buffer = true, noremap = true, silent = true })
end

function M.spell_checker(suggestions_cb, choose_first_cb)
    map_many({
        { { "n", "i" }, "<C-k>", suggestions_cb, { desc = "Show spelling suggestions" } },
        { { "n", "i" }, "<C-S-k>", choose_first_cb, { desc = "Choose first spelling suggestion" } },
    }, { buffer = true, noremap = true, silent = true })
end

function M.diagnostics(toggle_diagnostics)
    map_many({
        { "n", "<leader>d", toggle_diagnostics, { desc = "Toggle diagnostics" } },
    })
end

---------------------------------------------------------------------------------

function M.get_completion_map()
    local cmp_bindings = require("custom.helpers.completions").get_cmp_bindings()
    return {
        ["<C-b>"] = cmp_bindings.scrollback,
        ["<C-f>"] = cmp_bindings.scrollforward,
        ["<C-Space>"] = cmp_bindings.complete,
        ["<C-e>"] = cmp_bindings.abort,
        ["<CR>"] = cmp_bindings.confirm,
        ["<Tab>"] = cmp_bindings.next,

        -- Close CMP window if cursor moves horizontally
        ["<Left>"] = cmp_bindings.close,
        ["<Right>"] = cmp_bindings.close,
    }
end

---------------------------------------------------------------------------------

function M.bufferline()
    map_many({
        { "n", "<Tab>", ":BufferLineCycleNext<CR>", { desc = "Move to the next buffer" } },
        { "n", "<S-Tab>", ":BufferLineCyclePrev<CR>", { desc = "Move to the previous buffer" } },
        { "n", "<leader><Tab>", ":BufferLineMoveNext<CR>", { desc = "Move the active buffer to the next position" } },
        { "n", "<leader><S-Tab>", ":BufferLineMovePrev<CR>", { desc = "Move the active buffer to the previous position" } },
    })
end


return M
