-- return {
--   'kevinhwang91/nvim-ufo',
--   dependencies = { 'kevinhwang91/promise-async' },
--   config = function()
-- -- Assign UFO to a variable
-- local ufo = require('ufo')
--
-- -- Configure UFO
-- ufo.setup({
--   provider_selector = function(bufnr, filetype, buftype)
--     return { 'lsp', 'indent' }
--   end
-- })
--
--
-- -- Keybindings
-- -- 'za' - toggle fold
--     vim.keymap.set('n', 'zR', ufo.openAllFolds, { desc = 'Open all folds' })
-- vim.keymap.set('n', 'zM', ufo.closeAllFolds, { desc = 'Close all folds' })
-- vim.keymap.set('n', 'zK', function()
--       local winid = ufo.peekFoldedLinesUnderCursor()
--       if not winid then
--         vim.lsp.buf.hover()
--       end
--       end, { desc = 'Peek folded lines under cursor' })
--   end
-- }
return {
  'kevinhwang91/nvim-ufo',
  dependencies = { 'kevinhwang91/promise-async' },
  config = function()
    local ufo = require('ufo')

    ufo.setup({
      -- Use ONLY ONE provider to prevent over-folding
      provider_selector = function(bufnr, filetype, buftype)
        -- Prefer LSP if available, otherwise use treesitter/indent
        if vim.fn.has('nvim-0.10') == 1 then
          return { 'treesitter', 'indent' }  -- Neovim 0.10+ uses treesitter
        else
          local clients = vim.lsp.get_active_clients({ bufnr = bufnr })
          if #clients > 0 then
            return 'lsp'
          else
            return 'indent'
          end
        end
      end,
      -- Prevent folds from closing automatically
      close_fold_kinds = {},  -- Disable auto-close on certain operations
      -- Ensure folds stay open when moving around
      preserve_last_line = false
    })

    -- Keybindings (keep yours)
    vim.keymap.set('n', 'zR', ufo.openAllFolds, { desc = 'Open all folds' })
    vim.keymap.set('n', 'zM', ufo.closeAllFolds, { desc = 'Close all folds' })
    vim.keymap.set('n', 'zK', function()
      local winid = ufo.peekFoldedLinesUnderCursor()
      if not winid then
        vim.lsp.buf.hover()
      end
    end, { desc = 'Peek folded lines under cursor' })

    -- Force open folds on startup
    -- vim.api.nvim_create_autocmd('BufEnter', {
    --   pattern = '*',
    --   command = 'normal! zR',
    --   group = vim.api.nvim_create_augroup('ForceOpenFolds', { clear = true })
    -- })
  end
}
