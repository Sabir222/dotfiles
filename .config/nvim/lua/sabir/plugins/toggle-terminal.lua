return {
  {
    'akinsho/toggleterm.nvim',
    lazy = true,
    cmd = 'ToggleTerm',
    version = '*',
    keys = {
      { '\\', '<cmd>ToggleTerm<cr>', desc = 'Toggle Terminal' },
    },
    opt = {
      direction = 'float',
    },
  },
}
