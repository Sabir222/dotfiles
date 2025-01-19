return {
  'saecki/crates.nvim',
  lazy = true,
  tag = 'stable',
  ft = 'toml',
  config = function()
    require('crates').setup()
  end,
}
