return {
  {
    'akinsho/toggleterm.nvim',
    lazy = false,
    cmd = 'ToggleTerm',
    version = '*',
    keys = {
      { '\\', '<cmd>ToggleTerm<cr>', desc = 'Toggle Terminal' },
    },
    opts = {
      direction = 'float',
    },
  },
}
