local my_config = require("config")

return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		local config = require("nvim-treesitter.configs")
		config.setup({
			-- ensure_installed = {
			--              "vim",
			--              "lua",
			-- 	"html",
			-- 	"jinja",
			-- 	"vimdoc",
			-- 	"markdown",
			-- 	"markdown_inline",
			-- 	"bash",
			-- },
            ensure_installed = my_config.ensured_installed,
			sync_install = false,
			auto_install = true,
			highlight = {
				enable = true,
                -- disable = { "markdown", "markdown_inline" },
                additional_vim_regex_highlighting = { "markdown" }, -- Otherwise code blocks makes so the entire markdown is not highlighted.

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
