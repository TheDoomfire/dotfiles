return {
  "nvimtools/none-ls.nvim",
  dependencies = {
    "nvimtools/none-ls-extras.nvim",
  },
  config = function()
    local null_ls = require("null-ls")
    -- local helpers = require("null-ls.helpers")
    -- local none_ls = require("none-ls")

    null_ls.setup({
      sources = {
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.prettier,
        require("none-ls.formatting.ruff"),
        --null_ls.builtins.formatting.djlint,

        null_ls.builtins.diagnostics.stylelint.with({
          filetypes = { "css", "scss", "less", "astro" },
          extra_args = { "--config", "stylelint.config.mjs" },
        }),

        -- null_ls.builtins.code_actions.stylelint.with({
        --     filetypes = { "css", "scss", "less", "astro" },
        -- }),

        -- null_ls.builtins.code_actions.stylelint,

        null_ls.builtins.formatting.stylelint.with({
          filetypes = { "css", "scss", "less", "astro" },
        }),

        -- DIAGNOSTICS
        require("none-ls.diagnostics.eslint_d"),
        require("none-ls.diagnostics.ruff"),

        -- CODE ACTIONS
        -- null_ls.builtins.code_actions.gitsigns, -- Git conflict resolution
        require("none-ls.code_actions.eslint_d"),
        --require("none-ls.code_actions.ruff"),

        -- HOVER
        null_ls.builtins.hover.dictionary, -- Word definitions
        null_ls.builtins.hover.printenv, -- Environment variable info

        -- COMPLETION
        null_ls.builtins.completion.spell,
      },
      -- Set up format on save
      on_attach = function(client, bufnr)
        -- if client.supports_method("textDocument/formatting") then
        if client:supports_method("textDocument/formatting") then
          vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            callback = function()
              -- vim.cmd("silent! undojoin")
              -- vim.lsp.buf.format({ bufnr = bufnr })
            end,
          })
        end

        -- Code actions
        vim.keymap.set(
          "n",
          "<leader>ca",
          vim.lsp.buf.code_action,
          { buffer = bufnr, desc = "Code actions" } -- buffer = bufnr makes it buffer-local
        )
        vim.keymap.set("n", "<leader>af", function()
          vim.lsp.buf.code_action({ apply = true }) -- Auto-apply first fix
        end, { buffer = bufnr, desc = "Auto-fix" })

        -- Hover keymap (standard Neovim LSP binding)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, {
          buffer = bufnr, -- Buffer-local
          desc = "Show hover documentation/actions",
        })
      end,
      debug = true,
    })

    -- Fallback if format on save is not working.
    vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
    -- TODO: Add format when leaving window or quit. To have a auto formatting.
  end,
}
