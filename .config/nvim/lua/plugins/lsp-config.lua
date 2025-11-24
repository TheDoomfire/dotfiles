return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    opts = {
      auto_install = true,
    },
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      --Enable (broadcasting) snippet capability for completion
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      --capabilities.textDocument.completion.completionItem.snippetSupport = true

      local lspconfig = require("lspconfig")
      lspconfig.lua_ls.setup({
        capabilities = capabilities,
      })
      lspconfig.jinja_lsp.setup({
        capabilities = capabilities,
        -- filetypes = { "jinja", "jinja.html", "njk", "nunjucks" },
        filetypes = { "html", "jinja", "njk" },
        init_options = {
            enableEmmet = true
          }
        -- settings = {
        --   jinja_lsp = {
        --     enableEmmet = true, -- Enable Emmet for HTML in Jinja files
        --     jinjaPaths = {},
        --     jinjaTriggerCharacters = { ".", "[" },
        --   },
        -- },
      })

      lspconfig.ts_ls.setup({
        capabilities = capabilities,
      })

      -- lspconfig.html.setup({
      --   capabilities = capabilities,
      --   filetypes = {
      --     "html",
      --     "jinja",
      --     "jinja.html",
      --     "njk",
      --     "nunjucks",
      --   },
      --   init_options = {
      --     configurationSection = { "html", "css", "javascript" },
      --     embeddedLanguages = {
      --       css = true,
      --       javascript = true,
      --     },
      --   },
      -- })
      

      lspconfig.astro.setup({
   capabilities = capabilities,
   -- on_attach = on_attach,
   filetypes = { "astro" },
  })

      --code style, warnings, autofix
      lspconfig.stylelint_lsp.setup({
        filetypes = {
          "css",
          "scss",
          "less",
          "astro",
          "vue",
          "svelte",
          "html"  -- sometimes needed for astro
        },
        settings = {
          -- stylelintplus = {
            autoFixOnSave = true,
            autoFixOnFormat = true,
            -- Add these for better astro support
            configFile = "stylelint.config.mjs",
            validateOnType = true,
          -- }
        }
      })

      -- autocomplete, hover info
      lspconfig.cssls.setup({})

      lspconfig.pyright.setup({
        capabilities = capabilities,
        settings = {
          pyright = {
            -- Using Ruff's import organizer
            disableOrganizeImports = true,
          },
          python = {
            analysis = {
              -- Ignore all files for analysis to exclusively use Ruff for linting
              ignore = { "*" },
            },
          },
        },
      })
      lspconfig.ruff.setup({})
      vim.filetype.add({
        extension = {
          -- njk = "jinja.html",
          njk = "html",
        },
      })
      -- Add diagnostic filters for template tags
      vim.lsp.handlers["textDocument/publishDiagnostics"] =
          vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
            -- Filter out errors about template syntax
            filters = {
              function(diagnostic)
                return not (diagnostic.message:find("DOCTYPE") or diagnostic.message:find("tag"))
              end,
            },
          })
      vim.diagnostic.config({
        virtual_text = true,
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
      })

      vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
      vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
    end,
  },
}
