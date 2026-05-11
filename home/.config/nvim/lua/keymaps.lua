-- Instead of using vim.keymap.set, use this function to set the leader key
function Map(mode, lhs, rhs, opts)
    local options = { noremap = true, silent = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.keymap.set(mode, lhs, rhs, options)
end
vim.g.mapleader = " "

-- Replaces so everything after line 8 uses Map
-- 8,$s/Map/Map/g

-- TODO:
-- - Make just a couple of arrays that loop through the map function.

-- =============================================================================
-- NORMAL MODE MAPPINGS
-- =============================================================================

-- local normal_mode_maps = {
--     -- Duplicate a line and comment out the first line
--     {"yc", "yygccp", { remap = true }},
-- }

-- Duplicate a line and comment out the first line
Map("n", "yc", "yygccp", { remap = true })

-- Copy word.
-- Map("n", "<C-c>", "ciw")

-- Search within visual selection
--Map("x", "/", "<Esc>/\\%V")

-- Select all with Alt+a.
Map("n", "<C-a>", "ggVG", { noremap = true, desc = "Select all" })

-- Re size windows
Map("n", "<C-Up>", ":resize -2<CR>")
Map("n", "<C-Down>", ":resize +2<CR>")
Map("n", "<C-Left>", ":vertical resize -2<CR>")
Map("n", "<C-Right>", ":vertical resize +2<CR>")

-- Move lines with Alt+Up/Down
-- Map("n", "<A-Up>", ":m .-2<CR>==", { desc = "Move line up" })
-- Map("n", "<A-Down>", ":m .+1<CR>==", { desc = "Move line down" })
-- Map("v", "<A-Up>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })
-- Map("v", "<A-Down>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })


-- Map("n", "<A-Down>", ":m .+1<cr>==", { noremap = true, silent = true, desc = "Move line down" })
-- Map("n", "<A-Up>", ":m .-2<cr>==", { noremap = true, silent = true, desc = "Move line up" })
-- Map(
--   "i",
--   "<A-Up>",
--   "<Esc>:m .+1<cr>==gi",
--   { noremap = true, silent = true, desc = "Move line down (insert mode)" }
-- )
-- Map(
--   "i",
--   "<A-Down>",
--   "<Esc>:m .-2<cr>==gi",
--   { noremap = true, silent = true, desc = "Move line up (insert mode)" }
-- )
-- Map("x", "<A-Up>", ":m '>+1<cr>gv=gv", { noremap = true, silent = true, desc = "Move block down" })
-- Map("x", "<A-Down>", ":m '<-2<cr>gv=gv", { noremap = true, silent = true, desc = "Move block up" })


-- Copy lines with Alt+Shift+Up/Down
-- TODO: Make this work with hjkl keys
-- Normal Mode
Map("n", "<A-Up>", ":m .-2<CR>==", { desc = "Move line up" })
Map("n", "<A-k>", ":m .-2<CR>==", { desc = "Move line up" })
Map("n", "<A-Down>", ":m .+1<CR>==", { desc = "Move line down" })
Map("n", "<A-j>", ":m .+1<CR>==", { desc = "Move line down" })

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

Map("n", "K", vim.lsp.buf.hover, {})
Map("n", "gd", vim.lsp.buf.definition, {})
Map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
Map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "LSP Rename" })


-- Format the file.
Map("n", "<leader>gf", vim.lsp.buf.format, {})
-- TODO: Add format when leaving window or quit. To have a auto formatting.


-- Clear search highlights when pressing <Esc> in normal mode
Map('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- From the Vim wiki: https://bit.ly/4eLAARp
-- Search and replace word under the cursor
Map("n", "<Leader>r", [[:%s/\<<C-r><C-w>\>//g<Left><Left>]])

-- =============================================================================
-- VISUAL MODE MAPPINGS
-- =============================================================================

-- Indent with Tab in visual mode
Map('v', '<Tab>',   '>gv')
Map('v', '<S-Tab>', '<gv')

-- =============================================================================
-- VISUAL SELECTION
-- =============================================================================

-- Visual / Select Mode (x or v)
-- Note: '< refers to the start of the selection, '> refers to the end
Map("x", "<A-Up>", ":m '<-2<CR>gv=gv", { desc = "Move block up" })
Map("x", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move block up" })
Map("x", "<A-Down>", ":m '>+1<CR>gv=gv", { desc = "Move block down" })
Map("x", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move block down" })

-- Search for visually selected text with */# (like normal * but for visual selections)
--Map("x", "<leader>/", [["y/<C-R>y<CR>]])
Map("x", "<leader>/", 'y/\\V<C-r>"<CR>', { noremap = true, silent = true })

-- =============================================================================
-- INSERT MODE
-- =============================================================================

-- -- Indent/Outdent in Insert mode
-- -- ERROR: Cannot use <Tab> for autocomplete.
-- Map("i", "<Tab>", "<C-t>", { desc = "Indent line" })
-- Map("i", "<S-Tab>", "<C-d>", { desc = "Outdent line" })

-- Insert Mode (Uses <Esc> to run command, then gi to return to insert)
Map("i", "<A-Up>", "<Esc>:m .-2<CR>==gi", { desc = "Move line up" })
Map("i", "<A-k>", "<Esc>:m .-2<CR>==gi", { desc = "Move line up" })
Map("i", "<A-Down>", "<Esc>:m .+1<CR>==gi", { desc = "Move line down" })
Map("i", "<A-j>", "<Esc>:m .+1<CR>==gi", { desc = "Move line down" })

-- =============================================================================
-- TERMINAL
-- =============================================================================

Map("t", "<C-Up>", "<cmd>resize -2<CR>")
Map("t", "<C-Down>", "<cmd>resize +2<CR>")
Map("t", "<C-Left>", "<cmd>vertical resize -2<CR>")
Map("t", "<C-Right>", "<cmd>vertical resize +2<CR>")

-- =============================================================================
-- LEADER KEY
-- =============================================================================
