return {
  'zaldih/themery.nvim',
  lazy = false,
  config = function()
    require('themery').setup {
      -- add the config here
      themes = { 'solarized-osaka', 'gruvbox', 'tokyonight', 'onedark', 'rose-pine', 'moonfly' },
    }
  end,
}
