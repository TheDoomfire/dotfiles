return { 
  "catppuccin/nvim", 
  lazy = false,
  name = "catppuccin", 
  priority = 1000,
  config = function()
    require("catppuccin").setup({
      flavour = "mocha",
      --transparent_background = true,
      styles = { 
        comments = { "italic" }, 
      },
    })
    

    --vim.cmd.colorscheme "catppuccin"
    --vim.cmd("colorscheme catppuccin")
    --vim.o.termguicolors = true
    --vim.o.background = "dark"
    vim.cmd[[colorscheme catppuccin]]
  end
}
