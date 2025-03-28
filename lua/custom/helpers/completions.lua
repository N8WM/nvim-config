local M = {}

local has_words_before = function()
	if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
		return false
	end
	local line, col = require("custom.helpers.util").unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match("^%s*$") == nil
end

function M.get_cmp_bindings()
    local cmp = require("cmp")
	return {
		scrollback = cmp.mapping.scroll_docs(-4),
		scrollforward = cmp.mapping.scroll_docs(4),
		complete = cmp.mapping.complete(),
		abort = cmp.mapping.abort(),
		confirm = cmp.mapping.confirm({ select = false }),
		next = vim.schedule_wrap(function(fallback)
			if cmp.visible() and has_words_before() then
				cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
			else
				fallback()
			end
		end),
		close = cmp.mapping({
			i = function(fallback)
				cmp.abort()
				fallback()
			end,
		}),
	}
end

return M
