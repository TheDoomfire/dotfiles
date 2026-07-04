-- local my_config = require("config")

return {
	"nvim-treesitter/nvim-treesitter",
	branch = "master",
	build = ":TSUpdate",
	config = function()
		local config = require("nvim-treesitter.configs")
		config.setup({

            -- https://github.com/nvim-treesitter/nvim-treesitter/#adding-parsers
			-- ensure_installed = my_config.ensure_installed,
			sync_install = false,
			auto_install = true,
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = { "markdown" },
			},
			indent = { enable = true },
		})
	end,
}
