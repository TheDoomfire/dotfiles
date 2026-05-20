local M = {}

M.tools = {
	-- Language Servers (LSP)
	lsp = {
		"astro",
		"stylelint_lsp",
		"stylelint-language-server",
		"ruff",
        "basedpyright",
		"html",
		"lua_ls",
		"ts_ls",
		"pyright",
		"cssls",
		"jinja_lsp",
		"bash-language-server",
	},
	-- Linters
	linter = {
		"eslint_d",
		"shellcheck",
	},
	-- Formatters
	formatter = {
		"shfmt",
		"prettier",
	},
}

M.palette = {
    rosewater = "#f5e0dc",
	flamingo = "#f2cdcd",
	pink = "#f5c2e7",
	mauve = "#cba6f7",
	red = "#f38ba8",
	maroon = "#eba0ac",
	peach = "#fab387",
	yellow = "#f9e2af",
	green = "#a6e3a1",
	teal = "#94e2d5",
	sky = "#89dceb",
	sapphire = "#74c7ec",
	blue = "#89b4fa",
	lavender = "#b4befe",
	text = "#cdd6f4",
	subtext1 = "#bac2de",
	subtext0 = "#a6adc8",
	overlay2 = "#9399b2",
	overlay1 = "#7f849c",
	overlay0 = "#6c7086",
	surface2 = "#585b70",
	surface1 = "#45475a",
	surface0 = "#313244",
	base = "#1e1e2e",
	mantle = "#181825",
	crust = "#11111b",
}

M.ui = {
	-- -- State colors
	-- error = M.palette.red,
	-- warn = M.palette.orange,
	-- hint = M.palette.blue,
	-- success = M.palette.green,
	--
	-- -- UI Elements
	-- accent = M.palette.purple,
	-- border = M.palette.grey,
	-- active = M.palette.fg,
	-- inactive = M.palette.grey,

	-- Specifically for your Tab/Bufferline
	tab_number = M.palette.subtext1,
	tab_dimmed_txt = M.palette.subtext0,
    tab_selected = M.palette.maroon,
    tab_active_num = M.palette.maroon,
}

-- Create a flattened list for Mason to consume
M.ensure_installed = {}
for _, category in pairs(M.tools) do
	for _, tool in ipairs(category) do
		-- Move this line INSIDE the inner loop
		table.insert(M.ensure_installed, tool)
	end
end

return M
