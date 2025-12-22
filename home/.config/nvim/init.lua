--if not (vim.uv or vim.loop).fs_stat(lazypath) then
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	--local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"--branch=stable",
		--lazyrepo,
		"https://github.com/folke/lazy.nvim.git",
		lazypath,
	})
	--if vim.v.shell_error ~= 0 then
	--  vim.api.nvim_echo({
	--    { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
	--   { out, "WarningMsg" },
	--    { "\nPress any key to exit..." },
	--  }, true, {})
	--  vim.fn.getchar()
	--  os.exit(1)
	--en
end
vim.opt.rtp:prepend(lazypath)
--lazypath
-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
-- vim.g.mapleader = " "
-- vim.g.maplocalleader = "\\"

-- FROM FILES INSIDE OF LUA FOLDER
-- Load the auto-pull module on startup
-- vim.api.nvim_create_autocmd("VimEnter", {
-- 	pattern = "*",
-- 	callback = function()
-- 		require("auto-pull").auto_pull()
-- 	end,
-- 	once = true, -- Only run once per Neovim instance
-- })

require("vim-options")

-- require("commands")
-- Load all command files (same pattern as plugins)
local command_files = vim.fn.globpath(vim.fn.stdpath("config") .. "/lua/commands", "*.lua", true, true)
for _, file in ipairs(command_files) do
	local module = "commands." .. vim.fn.fnamemodify(file, ":t:r")
	pcall(require, module) -- Load safely
end
require("lazy").setup("plugins")

require("keymaps")
