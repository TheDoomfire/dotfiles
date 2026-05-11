-- File tree when I press "Ctrl+n"
return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		"MunifTanjim/nui.nvim",
		-- FIXME: Can't be installed.
		--{ "3rd/image.nvim", opts = {} }, -- Optional image support in preview window: See `# Preview Mode` for more information
	},
	lazy = false,
	config = function()
		-- Define footer text
		-- TODO: make this show at bottom of neotree.
		-- local footer_text = {
		-- 	"────────────────────────────",
		-- 	" ? - Help",
		-- 	" Shift+h - Show hidden files ",
		-- 	" s - Open in split ",
		-- }
		require("neo-tree").setup({
			follow_current_file = true,
            sources = { "filesystem", "buffers" }, -- Shows them in tabview.
			source_selector = {
				winbar = true, -- Show source tabs in the winbar
				content_layout = "start", -- Start content after the source tabs
				sources = {
					{ source = "filesystem", display_name = "󰉓󰉓Files" },
					-- { source = "buffers", display_name = "󰈙 Buffers" },
				},
			},
			filesystem = {
				visible = true,
				follow_current_file = {
enable = true,
        },
				-- show_hidden = false,
				--hide_dotfiles = false,
				----hide_gitignored = false,
			},
			buffers = {
				follow_current_file = {
enable = true,
        },
				show_unloaded = true,
			},
		})

		-- Create a toggle function
		local function toggle_neotree()
			if vim.bo.filetype == "neo-tree" then
				vim.cmd("Neotree close")
			else
				-- vim.cmd("Neotree filesystem reveal left")
				vim.cmd("Neotree reveal")
			end
		end

		-- Map the toggle function to a key
		-- FIXME: C-n is in conflix with visual-multi.
		-- vim.keymap.set("n", "<C-n>", ":Neotree filesystem reveal left<CR>", {})
		vim.keymap.set("n", "<C-n>", toggle_neotree, {})
	end,
}
