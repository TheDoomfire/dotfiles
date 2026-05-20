local ls = require("luasnip")
local s = ls.snippet -- Snippet Constructor
local t = ls.text_node -- Plain Text Block
local i = ls.insert_node -- Interactive Jump Point
local f = ls.function_node -- Functional (runs Lua code dynamically)

-- Fetch the current date/time in various formats
local function get_date(format)
	return function()
		return os.date(format)
	end
end

-- Get the correct comment based on the filetype
local function get_comment_string()
	-- Fallback to a hash if something goes completely sideways
	local comment = vim.bo.commentstring or "# %s"

	-- Strip out the '%s' placeholder Neovim uses internally (e.g., '// %s' becomes '// ')
	comment = comment:gsub("%%s", "")

	-- Trim any trailing whitespace so we don't accidentally double-space it
	return comment:gsub("%s+$", "") .. " "
end

-- These are all just test snippets to get started.

-- NOTE: Ideas:
-- https://github.com/rafamadriz/friendly-snippets/tree/main/snippets

return {
	-----------------------------------------------------------------------------
	-- 1. Date & Time Snippets (Dynamic)
	-----------------------------------------------------------------------------

	-- Trigger: ymd -> 2026-05-16 (Standard ISO Date)
	s("ymd", f(get_date("%Y-%m-%d"))),

	-- Trigger: hms -> 01:07:08 (Current Timestamp)
	s("hms", f(get_date("%H:%M:%S"))),

	-- Trigger: dlog -> Saturday, May 16, 2026 (Great for journaling/dev logs)
	s("dlog", f(get_date("%A, %B %d, %Y"))),

	-----------------------------------------------------------------------------
	-- 2. Developer Comment Tags (Uniform across languages)
	-----------------------------------------------------------------------------

	-- Trigger: todo -> [Comment] TODO: [your message]
	s("todo", {
		f(get_comment_string),
		t("TODO: "),
		i(1, "Fix this implementation"),
		i(0),
	}),

	-- Trigger: fixme -> [Comment] FIXME: [your message]
	s("fixme", {
		f(get_comment_string),
		t("FIXME: "),
		i(1, "This breaks on edge cases"),
		i(0),
	}),

	-- Trigger: note -> [Comment] NOTE: [your message]
	s("note", {
		f(get_comment_string),
		t("NOTE: "),
		i(1, "Reasoning behind this approach"),
		i(0),
	}),

	-----------------------------------------------------------------------------
	-- 3. Text & Layout Utilities
	-----------------------------------------------------------------------------

	-- Trigger: uuid -> Generates a random placeholder UUIDv4 string
	s(
		"uuid",
		f(function()
			local template = "xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx"
			return string.gsub(template, "[xy]", function(c)
				local v = (c == "x") and math.random(0, 0xf) or math.random(8, 0xb)
				return string.format("%x", v)
			end)
		end)
	),

	-- Trigger: lorem -> Injects a clean line of Lorem Ipsum for UI layout testing
	s(
		"lorem",
		t(
			"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
		)
	),
}
