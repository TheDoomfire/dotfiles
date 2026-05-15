return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		local config = require("nvim-treesitter.configs")
		config.setup({
			ensure_installed = {
				"html",
				"jinja",
				"lua",
				"vim",
				"vimdoc",
				"markdown",
				"markdown_inline",
				"bash",
			},
			sync_install = false,
			auto_install = true,
			highlight = {
				enable = true,
				-- disable = { "markdown", "markdown_inline" },
			},
			indent = { enable = true },
		})
	end,
}
