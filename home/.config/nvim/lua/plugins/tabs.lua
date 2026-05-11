local config = require("config")

return {
	"akinsho/bufferline.nvim",
	version = "*",
	dependencies = "nvim-tree/nvim-web-devicons",
	opts = {
		options = {
			numbers = "ordinal", -- This adds the number you want!
			mode = "tabs", -- Set to "tabs" to change the actual tab bar
			show_close_icon = false, -- This removes the "x" icon on the right side of the entire bar
			show_buffer_close_icons = false, -- This removes the "x" icon on each individual tab
		},
        -- :h bufferline-highlights
		highlights = {

			-- The "buffer" group here refers to the inactive tabs
			tab = {
				fg = config.ui.tab_dimmed_txt,
			},

            -- tab_separator = {
            --   fg = '#ffbf00',
            --   bg = '#a67c00',
            -- },

			-- This targets the number specifically in inactive tabs
			numbers = {
				fg = config.ui.tab_number,
				bold = true, -- Bold the number
			},

			-- -- The currently active tab
			-- tab_selected = {
			--     fg = config.ui.tab_selected,
			--     bold = false, -- Keep the text normal weight
			--     italic = true, -- Maybe make the name italic? (Optional)
			-- },

			-- The number on the currently active tab
			numbers_selected = {
				fg = config.ui.tab_active_num,
				bold = true, -- Extra bold for the active number
			},
		},
	},
}
