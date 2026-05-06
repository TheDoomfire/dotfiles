function Map(mode, lhs, rhs, opts)
    local options = { noremap = true, silent = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.keymap.set(mode, lhs, rhs, options)
end
vim.g.mapleader = " "

-- Copy/Paste
--vim.keymap.set("v", "<leader>y", '"+y', { noremap = true })
--vim.keymap.set("n", "<leader>p", '"+p', { noremap = true })

-- BUILT-IN

-- From the Vim wiki: https://bit.ly/4eLAARp
-- Search and replace word under the cursor
vim.keymap.set("n", "<Leader>r", [[:%s/\<<C-r><C-w>\>//g<Left><Left>]])

-- Duplicate a line and comment out the first line
vim.keymap.set("n", "yc", "yygccp", { remap = true })

-- Copy word.
-- vim.keymap.set("n", "<C-c>", "ciw")

-- Search within visual selection
--vim.keymap.set("x", "/", "<Esc>/\\%V")

-- Search for visually selected text with */# (like normal * but for visual selections)
--vim.keymap.set("x", "<leader>/", [["y/<C-R>y<CR>]])
vim.keymap.set("x", "<leader>/", 'y/\\V<C-r>"<CR>', { noremap = true, silent = true })

-- Select all with Alt+a.
vim.keymap.set("n", "<C-a>", "ggVG", { noremap = true, desc = "Select all" })

-- Re size windows
Map("n", "<C-Up>", ":resize -2<CR>")
Map("n", "<C-Down>", ":resize +2<CR>")
Map("n", "<C-Left>", ":vertical resize -2<CR>")
Map("n", "<C-Right>", ":vertical resize +2<CR>")

-- terminal
Map("t", "<C-Up>", "<cmd>resize -2<CR>")
Map("t", "<C-Down>", "<cmd>resize +2<CR>")
Map("t", "<C-Left>", "<cmd>vertical resize -2<CR>")
Map("t", "<C-Right>", "<cmd>vertical resize +2<CR>")
-- Move lines with Alt+Up/Down
-- vim.keymap.set("n", "<A-Up>", ":m .-2<CR>==", { desc = "Move line up" })
-- vim.keymap.set("n", "<A-Down>", ":m .+1<CR>==", { desc = "Move line down" })
-- vim.keymap.set("v", "<A-Up>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })
-- vim.keymap.set("v", "<A-Down>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })


-- vim.keymap.set("n", "<A-Down>", ":m .+1<cr>==", { noremap = true, silent = true, desc = "Move line down" })
-- vim.keymap.set("n", "<A-Up>", ":m .-2<cr>==", { noremap = true, silent = true, desc = "Move line up" })
-- vim.keymap.set(
--   "i",
--   "<A-Up>",
--   "<Esc>:m .+1<cr>==gi",
--   { noremap = true, silent = true, desc = "Move line down (insert mode)" }
-- )
-- vim.keymap.set(
--   "i",
--   "<A-Down>",
--   "<Esc>:m .-2<cr>==gi",
--   { noremap = true, silent = true, desc = "Move line up (insert mode)" }
-- )
-- vim.keymap.set("x", "<A-Up>", ":m '>+1<cr>gv=gv", { noremap = true, silent = true, desc = "Move block down" })
-- vim.keymap.set("x", "<A-Down>", ":m '<-2<cr>gv=gv", { noremap = true, silent = true, desc = "Move block up" })


-- Copy lines with Alt+Shift+Up/Down
-- TODO: Make this work with hjkl keys
-- Normal Mode
Map("n", "<A-Up>", ":m .-2<CR>==", { desc = "Move line up" })
Map("n", "<A-k>", ":m .-2<CR>==", { desc = "Move line up" })
Map("n", "<A-Down>", ":m .+1<CR>==", { desc = "Move line down" })
Map("n", "<A-j>", ":m .+1<CR>==", { desc = "Move line down" })
-- Insert Mode (Uses <Esc> to run command, then gi to return to insert)
Map("i", "<A-Up>", "<Esc>:m .-2<CR>==gi", { desc = "Move line up" })
Map("i", "<A-k>", "<Esc>:m .-2<CR>==gi", { desc = "Move line up" })
Map("i", "<A-Down>", "<Esc>:m .+1<CR>==gi", { desc = "Move line down" })
Map("i", "<A-j>", "<Esc>:m .+1<CR>==gi", { desc = "Move line down" })
-- Visual / Select Mode (x or v)
-- Note: '< refers to the start of the selection, '> refers to the end
Map("x", "<A-Up>", ":m '<-2<CR>gv=gv", { desc = "Move block up" })
Map("x", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move block up" })
Map("x", "<A-Down>", ":m '>+1<CR>gv=gv", { desc = "Move block down" })
Map("x", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move block down" })

-- -- Copy lines with Alt+Shift+Up/Down
-- Map("n", "<A-S-Up>", ":m .-1<CR>", { desc = "Copy line up" })
-- Map("n", "<A-S-Down>", ":m .<CR>", { desc = "Copy line down" })
-- Map("v", "<A-S-Down>", ":m '><CR>gv", { desc = "Copy selection down" })
-- Map("v", "<A-S-Up>", ":m '<-1<CR>gv", { desc = "Copy selection up" })
-- Map("v", "<A-S-Down>", ":m '><CR>gv", { desc = "Copy selection down" })

-- -- Move lines with Alt+Shift+Up/Down (Normal Mode)
-- Map("n", "<A-S-Up>", ":m .-2<CR>==", { desc = "Move line up" })
-- Map("n", "<A-S-Down>", ":m .+1<CR>==", { desc = "Move line down" })
-- -- Move selection with Alt+Shift+Up/Down (Visual Mode)
-- Map("v", "<A-S-Up>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })
-- Map("v", "<A-S-Down>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })

-- Swap windows with Shift + Arrow Keys
-- TODO: perhaps have them just work with <C-w>Left/Right/Up/Down
vim.api.nvim_set_keymap("n", "<S-Left>", "<C-w>H", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<S-Right>", "<C-w>L", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<S-Down>", "<C-w>J", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<S-Up>", "<C-w>K", { noremap = true, silent = true })

-- Indent with Tab in visual mode
Map('v', '<Tab>',   '>gv')
Map('v', '<S-Tab>', '<gv')

-- Clear search highlights when pressing <Esc> in normal mode
Map('n', '<Esc>', '<cmd>nohlsearch<CR>')
