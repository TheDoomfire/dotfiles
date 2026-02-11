return {
	"epwalsh/obsidian.nvim",
	version = "*",
	lazy = true,
	ft = "markdown",
	dependencies = {
		"nvim-lua/plenary.nvim",
		-- "nvim-telescope/telescope.nvim",
		-- "nvim-telescope/telescope-media-files.nvim",
	},
	config = function()
		require("obsidian").setup({
			workspaces = {
				{
					name = "notes",
					path = "~/Documents/Vaults/notes",
				},
			},
			completion = {
				-- Set to false to disable the completion.
				nvim_cmp = true,

				-- Trigger compeltion at 2 chars.
				min_chars = 2,

				-- Where to put new notes. Valid options are
				--  * "current_dir" - put new notes in same directory as the current buffer.
				--  * "notes_subdir" - put new notes in the default notes subdirectory.
				new_notes_location = "current_dir",
			},
		})
	end,
}
