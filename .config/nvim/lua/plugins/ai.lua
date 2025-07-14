return {
  "supermaven-inc/supermaven-nvim",
  config = function()
    require("supermaven-nvim").setup({
      keymaps = {
        -- Other AI also might have <Tab> as accept suggestion.
        accept_suggestion = "<Tab>",
        clear_suggestion = "<C-]>",
        accept_word = "<C-j>",
      },
    })
  end,
}

-- Free AI plugins
--'Exafunction/windsurf.vim',
--event = 'BufEnter'

-- Semi-paid AI plugins
-- "github/copilot.vim",
