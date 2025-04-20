-- Main function is `neotree_title.title()`
-- Returns a formatted string
-- Used in `plugins/bufferline.lua`

local M = {}

--- @class M.strseg
--- @field val string
--- @field icon boolean
--- @field sep string?

--- @param segments M.strseg[]
--- @return integer
local function length(segments)
	local len = 0
	for _, v in ipairs(segments) do
		if v.icon then
			len = len + 1
		else
			len = len + string.len(v.val)
		end
		if v.sep then
			len = len + string.len(v.sep)
		end
	end
	return len
end

--- @param segments M.strseg[]
--- @return string
local function join(segments)
	local str = ""
	for _, v in ipairs(segments) do
		str = str .. v.val .. (v.sep or "")
	end
	return str
end

--- @return string
function M.title()
	local nvim_icon = ""
	local project_icon = ""
	local service_icons = {
		{ "", vim.uv.fs_stat(vim.uv.cwd() .. "/.git") ~= nil },
		{ "", vim.uv.fs_stat(vim.uv.cwd() .. "/.github") ~= nil },
		{ "", vim.uv.fs_stat(vim.uv.cwd() .. "/.svn") ~= nil },
		{ "", vim.uv.fs_stat(vim.uv.cwd() .. "/Makefile") ~= nil },
		{ "", vim.uv.fs_stat(vim.uv.cwd() .. "/Cargo.toml") ~= nil },
		{ "", vim.uv.fs_stat(vim.uv.cwd() .. "/package.json") ~= nil },
		{ "", os.getenv("VIRTUAL_ENV") ~= nil },
	}

	local padding = 3
	local width_offset = 2 -- I presume this is the window border
	local width = vim.fn.winwidth(require("neo-tree.sources.manager").get_state("filesystem").winid) - width_offset
	local content = { --- @type M.strseg[]
		{ val = project_icon, icon = true, sep = " " },
		{ val = string.upper(vim.fn.fnamemodify(vim.fn.getcwd(), ":t")), icon = false },
	}
	local icons = {} --- @type M.strseg[]
	for _, icon in ipairs(service_icons) do
		if icon[2] then
			local separator = #icons == 0 and "" or " "
			table.insert(icons, 1, { val = icon[1], icon = true, sep = separator })
		end
	end
	local pre_content = { --- @type M.strseg[]
		{ val = nvim_icon, icon = true },
		{ val = string.rep(" ", padding), icon = false },
	}
	local post_content = { --- @type M.strseg[]
		{ val = string.rep(" ", padding), icon = false },
	}
	for _, icon in ipairs(icons) do
		post_content[#post_content + 1] = icon
	end

	--- @param a integer
	--- @param b integer
	--- @return integer
	--- @return integer
	local balance = function(a, b)
		if a < 0 and b > 0 then
			local t = math.min(-a, b)
			return a + t, b - t
		elseif b < 0 and a > 0 then
			local t = math.min(-b, a)
			return a - t, b + t
		end
		return a, b
	end

	local pre_align = math.floor((width - length(content)) / 2.0)
	local post_align = math.ceil((width - length(content)) / 2.0)
	local pre_spaces = pre_align - (length(pre_content))
	local post_spaces = post_align - (length(post_content))
	pre_spaces, post_spaces = balance(pre_spaces, post_spaces)
	local space = pre_spaces + post_spaces -- how much to truncate content
	local pre_padding = { --- @type M.strseg[]
		{ val = string.rep(" ", pre_spaces), icon = false },
	}
	local post_padding = { --- @type M.strseg[]
		{ val = string.rep(" ", post_spaces), icon = false },
	}
	content[2].val = string.sub(
		content[2].val,
		1,
		math.max(1, string.len(content[2].val) + space - (space < 0 and 1 or 0))
	) .. (space < 0 and "…" or "")

	local title = join(pre_content) .. join(pre_padding) .. join(content) .. join(post_padding) .. join(post_content)

	return title
end

return M
