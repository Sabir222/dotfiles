return {
  'nvim-lualine/lualine.nvim',
  lazy = true,
  config = function()
    require('lualine').setup {
      options = {
        theme = 'dracula',
      },
    }
  end,
}
