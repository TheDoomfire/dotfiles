local my_config = require("config")

return {
    {
        "mason-org/mason.nvim",
        config = function()
            require("mason").setup()
        end,
    },
    {
        "mason-org/mason-lspconfig.nvim",
    },
    {
        -- Used to install all lsp/linters/formatters etc.
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        config = function()
            require("mason-tool-installer").setup({
                ensure_installed = my_config.ensure_installed,
            })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            --Enable (broadcasting) snippet capability for completion
            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            --capabilities.textDocument.completion.completionItem.snippetSupport = true

            vim.lsp.config("*", { capabilities = capabilities })

            vim.lsp.config("lua_ls", {})

            vim.lsp.config("jinja_lsp", {
                filetypes = { "html", "jinja", "njk" },
                init_options = {
                    enableEmmet = true,
                },
            })

            vim.lsp.config("ts_ls", {})

            vim.lsp.config("astro", {
                filetypes = { "astro" },
                init_options = {
                    typescript = {
                        tsdk = vim.fn.stdpath("data")
                            .. "/mason/packages/typescript-language-server/node_modules/typescript/lib",
                    },
                },
            })

            -- vim.lsp.config('stylelint-language-server', {
            --                 filetypes = {
            --                     "css", "scss", "less", "astro", "vue", "svelte", "html",
            --                 },
            --                 settings = {
            --                     autoFixOnSave = true,
            --                     autoFixOnFormat = true,
            --                     configFile = "stylelint.config.mjs",
            --                     validateOnType = true,
            --                 },
            --             })

            -- autocomplete, hover info
            vim.lsp.config("cssls", {})

            -- vim.lsp.config("pyright", {
            -- 	settings = {
            -- 		pyright = {
            -- 			disableOrganizeImports = true,
            -- 		},
            -- 		python = {
            -- 			analysis = {
            -- 				-- ignore = { "*" },
            -- 				-- "workspace" or "openFilesOnly". Workspace enables cross-file indexing for auto-imports.
            -- 				indexingMode = "workspace",
            -- 				autoImportCompletions = true, -- Enables auto-imports in the completion menu
            -- 			},
            -- 		},
            -- 	},
            -- })

            vim.lsp.config("basedpyright", {
                settings = {
                    basedpyright = {
                        disableOrganizeImports = true, -- let ruff handle imports
                        analysis = {
                            indexingMode = "workspace",
                            autoImportCompletions = true,
                            -- Optional: tighten type checking
                            typeCheckingMode = "standard", -- "off" | "basic" | "standard" | "strict" | "all"
                        },
                    },
                },
            })

            -- vim.lsp.config("basedpyright", {
            --     basedpyright = {
            --         disableOrganizeImports = true, -- let ruff handle imports
            --         analysis = {
            --             indexingMode = "workspace",
            --             autoImportCompletions = true,
            --             -- Optional: tighten type checking
            --             typeCheckingMode = "standard", -- "off" | "basic" | "standard" | "strict" | "all"
            --         },
            --     },
            -- })

            vim.lsp.config("ruff", {})

            vim.lsp.config("yaml-language-server", {})

            vim.lsp.enable({
                "lua_ls",
                "jinja_lsp",
                "ts_ls",
                "astro",
                "stylelint-language-server",
                "cssls",
                -- "pyright",
                "basedpyright",
                "ruff",
                "njk",
                "yaml-language-server",
            })

            vim.filetype.add({
                extension = {
                    njk = "html",
                },
            })

            -- Replaced deprecated vim.lsp.with() — filter diagnostics via autocmd instead
            vim.api.nvim_create_autocmd("DiagnosticChanged", {
                callback = function()
                    local filtered = {}
                    for _, d in ipairs(vim.diagnostic.get()) do
                        if not (d.message:find("DOCTYPE") or d.message:find("tag")) then
                            table.insert(filtered, d)
                        end
                    end
                end,
            })

            vim.diagnostic.config({
                virtual_text = true,
                signs = true,
                underline = true,
                update_in_insert = false,
                severity_sort = true,
            })
        end,
    },
}
