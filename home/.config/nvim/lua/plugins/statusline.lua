-- For pretty status lines.
return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require('lualine').setup({
      options = {
        theme = 'auto',
        --theme = 'nightfly',
        --theme = 'codedark',
        --theme = 'dracula'
        --theme = 'base16',
        --theme = 'wombat'
        },
      --sections = {
        --lualine_a = {
          --{
            --'mode',
            --path = 1,
          --}
        --}
      --}
    })
  end
}
