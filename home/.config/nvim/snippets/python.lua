local ls = require("luasnip")
local s = ls.snippet -- Snippet Constructor
local t = ls.text_node -- Plain Text Block
local i = ls.insert_node -- Interactive Jump Point
-- local f = ls.function_node -- Functional (runs Lua code dynamically)

-- These are all just test snippets to get started.

return {
	-- 1. Standard Iteration Loop
	-- Trigger: fori -> for item in iterable:
	s("fori", {
		-- Node 1: Variable name, Node 2: The collection
		t("for "),
		i(1, "item"),
		t(" in "),
		i(2, "iterable"),
		t({ ":", "    " }),
		-- Node 0: The final resting point inside the loop
		i(0, "pass"),
	}),

	-- 2. Range/Index Loop
	-- Trigger: forr -> for i in range(10):
	s("forr", {
		t("for "),
		i(1, "i"),
		t(" in range("),
		i(2, "10"),
		t({ "):", "    " }),
		i(0),
	}),

	-- 3. Enumerate/Key-Value Loop
	-- Trigger: fore -> for idx, item in enumerate(iterable):
	s("fore", {
		t("for "),
		i(1, "idx"),
		t(", "),
		i(2, "item"),
		t(" in enumerate("),
		i(3, "iterable"),
		t({ "):", "    " }),
		i(0),
	}),
}
