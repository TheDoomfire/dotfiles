## ERROR 1

The `require('lspconfig')` "framework" is deprecated, use vim.lsp.config (see :help lspconfig-nvim-0.11) instead.
Feature will be removed in nvim-lspconfig v3.0.0
stack traceback:
        .../.local/share/nvim/lazy/nvim-lspconfig/lua/lspconfig.lua:81: in function '__index'
        /home/emma/.config/nvim/lua/plugins/lsp-config.lua:34: in function 'config'
        ...local/share/nvim/lazy/lazy.nvim/lua/lazy/core/loader.lua:380: in function <...local/share/nvim/lazy/lazy.nvim/lua/lazy/core/loader.lua:378>
        [C]: in function 'xpcall'
        .../.local/share/nvim/lazy/lazy.nvim/lua/lazy/core/util.lua:135: in function 'try'
        ...local/share/nvim/lazy/lazy.nvim/lua/lazy/core/loader.lua:395: in function 'config'
        ...local/share/nvim/lazy/lazy.nvim/lua/lazy/core/loader.lua:362: in function '_load'
        ...local/share/nvim/lazy/lazy.nvim/lua/lazy/core/loader.lua:197: in function 'load'
        ...local/share/nvim/lazy/lazy.nvim/lua/lazy/core/loader.lua:127: in function 'startup'
        .../emma/.local/share/nvim/lazy/lazy.nvim/lua/lazy/init.lua:112: in function 'setup'
vim.lsp.with() is deprecated. Run ":checkhealth vim.deprecated" for more information


