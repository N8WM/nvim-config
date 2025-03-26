---@diagnostic disable: undefined-global

-- Lazy-independent
require("custom.options")
require("custom.cxt_prefs")
require("custom.session_basics")
require("custom.window_navigation")
require("custom.diagnostics")

-- Lazy itself
require("custom.lazy_setup")

-- Lazy-dependent
require("custom.spellchecker")
