-- TODO:
-- Use vim.opt for everything instead of vim.cmd?

vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
-- vim.cmd("set softtabstop=2")
vim.cmd("set softtabstop=4")
-- vim.cmd("set shiftwidth=2")
vim.cmd("set shiftwidth=4")
vim.cmd("set number")
vim.cmd("set relativenumber")
vim.cmd("set mouse=a")
vim.cmd("set autoindent")
vim.cmd("set smarttab")
vim.cmd("set encoding=UTF-8")
vim.cmd("set clipboard=unnamedplus")

-- vim.opt.showtabline = 2 -- Always show tabline
-- -- Show line numbers in the tabline
-- vim.o.tabline = "%!v:lua.require'util'.tabline()"

-- Keeps X lines above/below the cursor, so I aren't always looking at the very bottom of the screen.
vim.opt.scrolloff = 8 -- Not sure if this is a good idea

vim.opt.spell = true
vim.g.mapleader = " "

vim.g.maplocalleader = " "
--  - Folding -
-- vim.opt.foldmethod = "syntax"
vim.o.foldcolumn = "1" -- '0' is not bad
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true

--  SEARCH
vim.opt.ignorecase = true -- Case-insensitive searching
vim.opt.smartcase = true -- If typed an uppercase letter, it becomes case-sensitive automatically.
vim.opt.incsearch = true -- Highlights the search pattern as you type it
-- vim.opt.hlsearch = false -- Don't keep highlights after search is done

-- UI
vim.opt.cursorline = true         -- Highlight the line the cursor is on
