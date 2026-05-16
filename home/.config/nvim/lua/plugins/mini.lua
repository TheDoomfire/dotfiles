return {
  "echasnovski/mini.nvim",
  version = "*",
  config = function()
    require("mini.cursorword").setup({})
    require("mini.surround").setup({})
    -- require("mini.sessions").setup()
  end,
}
