local M = {}

M.tools = {
    -- Language Servers (LSP)
    lsp = {
        "astro",
        "stylelint_lsp",
        "stylelint-language-server",
        "ruff",
        "html",
        "lua_ls",
        "ts_ls",
        "pyright",
        "cssls",
        "jinja_lsp",
        "bash-language-server",
    },
    -- Linters
    linter = {
        "eslint_d",
        "shellcheck",
    },
    -- Formatters
    formatter = {
        "shfmt",
        "prettier",
    },
}

-- Create a flattened list for Mason to consume
M.ensure_installed = {}
for _, category in pairs(M.tools) do
    for _, tool in ipairs(category) do
        -- Move this line INSIDE the inner loop
        table.insert(M.ensure_installed, tool)
    end
end

return M
