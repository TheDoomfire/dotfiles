local K = require("util.keymap")
-- Instead of using vim.keymap.set, use this function to set the leader key

-- function K.Map(mode, lhs, rhs, opts)
--     local options = { noremap = true, silent = true }
--     if opts then
--         options = vim.tbl_extend("force", options, opts)
--     end
--     vim.keymap.set(mode, lhs, rhs, options)
-- end

vim.g.mapleader = " "

-- Replaces so everything after line 8 uses Map
-- 8,$s/Map/Map/g

-- Some (possibly) sources:
-- https://www.reddit.com/r/vim/comments/kn0cpp/key_mappings_everyone_uses/

-- local function smart_rename()
--     local bufnr = vim.api.nvim_get_current_buf()
--     local clients = vim.lsp.get_clients({ bufnr = bufnr })
--
--     local has_rename = false
--     for _, client in ipairs(clients) do
--         if client.supports_method and client:supports_method("textDocument/rename", bufnr) then
--             has_rename = true
--             break
--         end
--     end
--
--     local word = vim.fn.expand("<cword>")
--
--     if has_rename then
--         return ":IncRename " .. word .. vim.api.nvim_replace_termcodes("<C-w>", true, true, true)
--     else
--         vim.notify("No LSP rename capability, falling back to :%s", vim.log.levels.WARN)
--         -- -- build a substitute command pre-filled with the word, cursor left in the replacement slot
--         -- -- [[:%s/\<<C-r><C-w>\>//g<Left><Left>]],
--         -- local cmd = ":%s/\\<<C-r>" .. word .. "\\>//g<Left><Left>"
--         -- -- local cmd = ":%s/\\<" .. word .. "\\>//g"
--         -- local left = vim.api.nvim_replace_termcodes(string.rep("<Left>", 3), true, true, true)
--         -- return cmd .. left
--         local left = vim.api.nvim_replace_termcodes("<Left><Left>", true, true, true)
--         return ":%s/\\<" .. word .. "\\>//g" .. left
--     end
-- end

-- Renames using LSP if available, otherwise falls back to :%s
local function smart_rename()
    local bufnr = vim.api.nvim_get_current_buf()

    local clients = vim.lsp.get_clients({ bufnr = bufnr, method = "textDocument/rename" })
    local has_rename = #clients > 0

    local word = vim.fn.expand("<cword>")

    if has_rename then
        return ":IncRename " .. word .. vim.api.nvim_replace_termcodes("<C-w>", true, true, true)
    else
        vim.notify("No LSP rename support, falling back to :%s", vim.log.levels.WARN)
        return vim.api.nvim_replace_termcodes(":%s/\\<" .. word .. "\\>/", true, false, true)
    end
end

        -- function()
        --     return ":IncRename " .. vim.fn.expand("<cword>") .. vim.api.nvim_replace_termcodes("<C-w>", true, true, true)
        -- end,

-- =============================================================================
-- NORMAL MODE MAPPINGS
-- =============================================================================

local normal_mode_maps = { -- "n" is the mode
    { "<Esc>",      "<cmd>nohlsearch<CR>" },
    -- { "<Leader>r",  [[:%s/\<<C-r><C-w>\>//g<Left><Left>]], { desc = "Search and [r]eplace word under cursor" } },
    -- { "<Leader>r",  vim.lsp.buf.rename, { desc = "Search and [r]eplace word under cursor" } },
    -- { "<leader>s",  [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Search and [s]ubstitute word under cursor" } },
    -- {'<Leader>s', [[:<C-U>%substitute/\</g<Left><Left>]], { silent = false }},
    {
        "<Leader>r",
        smart_rename,
        { expr = true, desc = "LSP instant [r]ename" },
    },
    {
        "<Leader>s",
        function()
            -- This passes the word, leaving the command open at the very end
            return ":IncRename " .. vim.fn.expand("<cword>")
        end,
        { expr = true, desc = "LSP append [s]uffix to word" },
    },
    {'<Leader>S', [[:<C-U>%substitute/\<<C-R><C-W>\>//g<Left><Left>]], { silent = false, desc="[S]ubstitute word under cursor (global)"}}, -- Like r?
    { "<leader>gf", vim.lsp.buf.format, { desc = "[g]o [f]ormat" } },
    {'<Leader>h', ':nohlsearch<CR>', { silent = true, desc = '[h]old search' }}, -- Can maybe use: vim.cmd.nohlsearch  instead of :nohlsearch
    { "gd", vim.lsp.buf.definition, { desc = "[g]o to [d]efinition" } },
    { "K", vim.lsp.buf.hover, { desc = "[K]now" } },
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
    { "<C-a>", "ggVG", { desc = "Select all" } },
    -- Buffers
    {'<leader>bp', ':bprevious<CR>', { desc = '[b]uffer [p]revious' }},
    {'<leader>bn', ':bnext<CR>', { desc = '[b]uffer [n]ext' }},
    {'<leader>bt', '<C-^>', { desc = '[b]uffer [t]oggle' }},
}

-- Swap windows with Shift + Arrow Keys
-- TODO: perhaps have them just work with <C-w>Left/Right/Up/Down
vim.api.nvim_set_keymap("n", "<S-Left>", "<C-w>H", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<S-Right>", "<C-w>L", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<S-Down>", "<C-w>J", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<S-Up>", "<C-w>K", { noremap = true, silent = true })

K.map("n", "K", vim.lsp.buf.hover, { desc = "LSP Hover Documentation" })
K.map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "LSP Code Actions" })
K.map("v", "<leader>ca", vim.lsp.buf.code_action, { desc = "LSP Visual Code Actions" })
-- K.map({ "v", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})



-- vim.keymap.set("v", "<leader>ca", function()
--     local start_mark = vim.api.nvim_buf_get_mark(0, "<")
--     local end_mark = vim.api.nvim_buf_get_mark(0, ">")
--     vim.lsp.buf.code_action({
--         range = {
--             start = { line = start_mark[1] - 1, character = start_mark[2] },
--             ["end"] = { line = end_mark[1] - 1, character = end_mark[2] + 1 },
--         },
--     })
-- end, { desc = "Code action (range)" })

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
    { '<Leader>s', [[:substitute/\</g<Left><Left>]], { silent = false, desc="[s]ubstitute in selection" }},
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

K.bulk_map(all_maps)

-- for mode, mappings in pairs(all_maps) do
--     for _, m in ipairs(mappings) do
--         K.map(mode, m[1], m[2], m[3])
--     end
-- end
