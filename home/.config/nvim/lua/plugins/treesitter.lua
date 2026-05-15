return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		local config = require("nvim-treesitter.configs")
		config.setup({
			ensure_installed = {
                "vim",
                "lua",
				"html",
				"jinja",
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
                additional_vim_regex_highlighting = { "markdown" },
                -- disable = function(lang, buf)
                --     return false  -- highlight all
                -- end,
			},
			indent = { enable = true },
            -- injections = {
            --     markdown = {
            --         enable = false,
            --     },
            -- },
		})
	end,
}
