return {
  'zaldih/themery.nvim',
  lazy = true,
  cmd = { 'Themery' },
  config = function()
    require('themery').setup {
      -- add the config here
      themes = {
        'darcubox',
        'gruvbuddy',
        'kanagawa',
        'solarized-osaka',
        'gruvbox',
        'tokyonight',
        'onedark',
        'rose-pine',
        'moonfly',
        'sonokai',
        'lackluster',
        'catppuccin',
      },
    }
  end,
}
