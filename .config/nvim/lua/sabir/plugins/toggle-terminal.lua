return {
  {
    'akinsho/toggleterm.nvim',
    lazy = true,
    cmd = 'ToggleTerm',
    version = '*',
    keys = {
      { '<leader>tt', '<cmd>ToggleTerm<cr>', desc = 'Toggle Terminal' },
    },
    opts = {},
  },
}
