local source = {}

function source.new()
	return setmetatable({}, { __index = source })
end

-- Only enable this source if spell checking is active.
function source:is_available()
	return vim.wo.spell
end

-- The keyword pattern here is kept the same as cmp-spell’s default.
function source:get_keyword_pattern()
	return [[\K\+]]
end

-- Build candidates using the raw output of spellsuggest().
local function candidates(input)
	local items = {}
	-- Call spellsuggest with just the input; Vim will handle max suggestions
	-- and capitalization based on the input (e.g. capitalized if needed).
	local entries = vim.fn.spellsuggest(input)
	for k, v in ipairs(entries) do
		items[k] = {
			label = v,
			-- Use the input word as filterText so that all suggestions are always shown.
			filterText = input,
			-- Create a sortText so that items remain in the order provided.
			sortText = string.format("%03d", k),
		}
	end
	return items
end

-- The complete() function passes the list of candidates to cmp.
function source:complete(params, callback)
	local input = string.sub(params.context.cursor_before_line, params.offset)
	callback({ items = candidates(input), isIncomplete = false })
end

function source:get_debug_name()
	return "custom_spell"
end

return source
