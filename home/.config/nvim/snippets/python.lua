local ls = require("luasnip")
local s = ls.snippet -- Snippet Constructor
local t = ls.text_node -- Plain Text Block
local i = ls.insert_node -- Interactive Jump Point
-- local f = ls.function_node -- Functional (runs Lua code dynamically)

-- These are all just test snippets to get started.

-- TODO: Add the snippet names to the config file. So I can reuse them in other languages.

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

    s("pr", {
        t('print("'),   -- Opens the print statement and the first quote
        i(1),           -- The cursor lands here first so you can type inside the quotes
        t('")'),        -- Closes the quote and parentheses
        i(0),           -- The final exit point when you press Tab again
    }),

    s("fun", {
        t("def "),                          -- The definition keyword
        i(1, "function_name"),              -- 1st jump: Highlights this placeholder name
        t("("),                             -- Opens parentheses
        i(2),                               -- 2nd jump: Drops cursor inside the () for arguments
        t("):"),                            -- Closes parentheses and adds the colon
        t({ "", "    " }),                  -- Creates a new line and indents 4 spaces
        i(0, "pass"),                       -- Final jump: Overwrites "pass" when you start coding
    }),


    s("afun", {
        t("async def "),                          -- The definition keyword
        i(1, "function_name"),              -- 1st jump: Highlights this placeholder name
        t("("),                             -- Opens parentheses
        i(2),                               -- 2nd jump: Drops cursor inside the () for arguments
        t("):"),                            -- Closes parentheses and adds the colon
        t({ "", "    " }),                  -- Creates a new line and indents 4 spaces
        i(0, "pass"),                       -- Final jump: Overwrites "pass" when you start coding
    }),

    s("if", {
        t("if "),                           -- Starts the statement
        i(1, "condition"),                  -- 1st jump: Highlights "condition"
        t(":"),                             -- Adds the colon
        t({ "", "    " }),                  -- Drops down a line and inserts 4 spaces
        i(0, "pass"),                       -- Final jump: Highlights "pass" so it wipes when you type
    }),
}
