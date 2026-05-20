return {
    {
        "hrsh7th/cmp-nvim-lsp",
    },
    {
        "L3MON4D3/LuaSnip",
        dependencies = {
            "saadparwaiz1/cmp_luasnip",
            "rafamadriz/friendly-snippets",
        },
        config = function()
            local ls = require("luasnip")

            require("luasnip.loaders.from_vscode").lazy_load()

            -- Load your pure Lua snippets from ~/.config/nvim/snippets/
            require("luasnip.loaders.from_lua").lazy_load({
                paths = { vim.fn.stdpath("config") .. "/snippets" },
            })

            -- Setup snippet jump keymaps so you can navigate your loops easily
            vim.keymap.set({ "i", "s" }, "<C-k>", function()
                if ls.expand_or_jumpable() then
                    ls.expand_or_jump()
                end
            end, { silent = true })

            vim.keymap.set({ "i", "s" }, "<C-j>", function()
                if ls.jumpable(-1) then
                    ls.jump(-1)
                end
            end, { silent = true })
        end,
    },
    {
        "hrsh7th/nvim-cmp",
        config = function()
            local cmp = require("cmp")

            cmp.setup({
                snippet = {
                    REQUIRED = true,
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end,
                },
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-e>"] = cmp.mapping.abort(),
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                }),
                sources = cmp.config.sources({
                    { name = "luasnip" }, -- This connects nvim-cmp to LuaSnip
                    { name = "nvim_lsp" },
                }, {
                    { name = "buffer" },
                }),
            })
        end,
        --    config = function()
        --      local cmp = require("cmp")
        --      require("luasnip.loaders.from_vscode").lazy_load()
        --
        --      cmp.setup({
        --        snippet = {
        --          -- REQUIRED - you must specify a snippet engine
        --          expand = function(args)
        --            --vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        --            require("luasnip").lsp_expand(args.body)
        --          end,
        --        },
        --        window = {
        --          completion = cmp.config.window.bordered(),
        --          documentation = cmp.config.window.bordered(),
        --        },
        --        mapping = cmp.mapping.preset.insert({
        --          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        --          ["<C-f>"] = cmp.mapping.scroll_docs(4),
        --          ["<C-Space>"] = cmp.mapping.complete(),
        --          ["<C-e>"] = cmp.mapping.abort(),
        --          ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        --        }),
        --        sources = cmp.config.sources({
        --          { name = "nvim_lsp" },
        --          --{ name = 'vsnip' }, -- For vsnip users.
        --          { name = "luasnip" }, -- For luasnip users.
        --        }, {
        --          { name = "buffer" },
        --        }),
        --      })
        --
        --      -- To use git you need to install the plugin petertriho/cmp-git and uncomment lines below
        --      -- Set configuration for specific filetype.
        --      --[[ cmp.setup.filetype('gitcommit', {
        --    sources = cmp.config.sources({
        --      { name = 'git' },
        --    }, {
        --      { name = 'buffer' },
        --    })
        -- })
        -- require("cmp_git").setup() ]]
        --      --
        --    end,
    },
}
