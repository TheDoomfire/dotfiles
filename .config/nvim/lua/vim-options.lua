vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.cmd("set number")
vim.cmd("set relativenumber")
vim.cmd("set mouse=a")
vim.cmd("set autoindent")
vim.cmd("set smarttab")
vim.cmd("set encoding=UTF-8")
vim.cmd("set clipboard=unnamedplus")
vim.opt.spell = true
vim.g.mapleader = " "
vim.g.maplocalleader = " "

--  - Folding -
-- vim.opt.foldmethod = "syntax"
vim.o.foldcolumn = '1' -- '0' is not bad
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true
