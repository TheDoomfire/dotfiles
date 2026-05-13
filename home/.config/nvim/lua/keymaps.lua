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

-- =============================================================================
-- NORMAL MODE MAPPINGS
-- =============================================================================

local normal_mode_maps = { -- "n" is the mode
    { "<Esc>",      "<cmd>nohlsearch<CR>" },
    { "<Leader>r",  [[:%s/\<<C-r><C-w>\>//g<Left><Left>]] },
    { "<leader>gf", vim.lsp.buf.format,                                    {} },
    { "<leader>rn", vim.lsp.buf.rename },
    { "<leader>s",  [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]] },
    { "<leader>rn", vim.lsp.buf.rename,                                    { desc = "LSP Rename" } },
    { "gd",         vim.lsp.buf.definition,                                {} },
    { "K",          vim.lsp.buf.hover,                                     {} },
    --     {"<A-S-Down>", ":m .+1<CR>==", { desc = "Move line down" }},
    --     {"<A-S-Up>", ":m .-2<CR>==", { desc = "Move line up" }},
    --     {"<A-S-Down>", ":m .<CR>", { desc = "Copy line down" }},
    --     {"<A-S-Up>", ":m .-1<CR>", { desc = "Copy line up" }},
    { "<A-j>",      ":m .+1<CR>==",                                        { desc = "Move line down" } },
    { "<A-Down>",   ":m .+1<CR>==",                                        { desc = "Move line down" } },
    { "<A-k>",      ":m .-2<CR>==",                                        { desc = "Move line up" } },
    { "<A-Up>",     ":m .-2<CR>==",                                        { desc = "Move line up" } },
    --     {"<A-Up>", ":m .-2<cr>==", { noremap = true, silent = true, desc = "Move line up" }},
    --     {"<A-Down>", ":m .+1<cr>==", { noremap = true, silent = true, desc = "Move line down" }},
    --     {"<A-Down>", ":m .+1<CR>==", { desc = "Move line down" }},
    --     {"<A-Up>", ":m .-2<CR>==", { desc = "Move line up" }},
    { "<C-Right>",  ":vertical resize +2<CR>" },
    { "<C-Left>",   ":vertical resize -2<CR>" },
    { "<C-Down>",   ":resize +2<CR>" },
    { "<C-Up>",     ":resize -2<CR>" },
    --     {"<C-c>", "ciw"},
    { "yc", "yygccp", { remap = true, desc = "Duplicate a line and comment out the first line" } },
    { "<C-a>", "ggVG", { desc = "Select all with Alt+a" } },
}

-- Swap windows with Shift + Arrow Keys
-- TODO: perhaps have them just work with <C-w>Left/Right/Up/Down
vim.api.nvim_set_keymap("n", "<S-Left>", "<C-w>H", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<S-Right>", "<C-w>L", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<S-Down>", "<C-w>J", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<S-Up>", "<C-w>K", { noremap = true, silent = true })

Map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})

-- =============================================================================
-- VISUAL MODE MAPPINGS
-- =============================================================================

local visual_mode_maps = { -- "v" is the mode
    { "<leader>s", [[y:%s/<C-r>0/<C-r>0/gI<Left><Left><Left>]], { desc = "Multiline edit" } },
    { "<Tab>",     ">gv",                                       { desc = "Indent with Tab" } },
    { "<S-Tab>",   "<gv",                                       { desc = "Outdent with Tab" } },
}

-- =============================================================================
-- VISUAL SELECTION
-- =============================================================================

local visual_selection_maps = { -- "x" is the mode
    { "<A-Up>",    ":m '<-2<CR>gv=gv", { desc = "Move block up" } },
    { "<A-k>",     ":m '<-2<CR>gv=gv", { desc = "Move block up" } },
    { "<A-Down>",  ":m '>+1<CR>gv=gv", { desc = "Move block down" } },
    { "<A-j>",     ":m '>+1<CR>gv=gv", { desc = "Move block down" } },
    { "<leader>/", 'y/\\V<C-r>"<CR>',  { noremap = true, silent = true } },
}

-- =============================================================================
-- INSERT MODE
-- =============================================================================

local insert_mode_maps = { -- "i" is the mode
    { "<A-j>",    "<Esc>:m .+1<CR>==gi", { desc = "Move line down" } },
    { "<A-Down>", "<Esc>:m .+1<CR>==gi", { desc = "Move line down" } },
    { "<A-k>",    "<Esc>:m .-2<CR>==gi", { desc = "Move line up" } },
    { "<A-Up>",   "<Esc>:m .-2<CR>==gi", { desc = "Move line up" } },
    --     {"<S-Tab>", "<C-d>", { desc = "Outdent line" }},
    --     {"<Tab>", "<C-t>", { desc = "Indent line" }},
}

-- =============================================================================
-- TERMINAL
-- =============================================================================

local terminal_maps = { -- "t" is the mode
    { "<C-Up>",    "<cmd>resize -2<CR>" },
    { "<C-Down>",  "<cmd>resize +2<CR>" },
    { "<C-Left>",  "<cmd>vertical resize -2<CR>" },
    { "<C-Right>", "<cmd>vertical resize +2<CR>" },
    { "<Esc>", [[<C-\><C-n>]], { desc = 'Exit terminal mode' }},
}

-- =============================================================================
-- CREATE MAPPINGS
-- =============================================================================

local all_maps = {
    n = normal_mode_maps,
    v = visual_mode_maps,
    x = visual_selection_maps,
    i = insert_mode_maps,
    t = terminal_maps,
}

for mode, mappings in pairs(all_maps) do
    for _, m in ipairs(mappings) do
        Map(mode, m[1], m[2], m[3])
    end
end
