return {
  {
    'akinsho/toggleterm.nvim',
    lazy = false,
    cmd = 'ToggleTerm',
    version = '*',
    opts = {
      direction = 'horizontal',
      -- Try one of these alternatives:
      open_mapping = [[<A-t>]], -- Ctrl + t
      -- open_mapping = [[<C-`>]], -- Ctrl + backtick (good for terminals)
      -- open_mapping = [[<F12>]], -- F12 key
      -- open_mapping = [[<A-t>]], -- Alt + t
      -- open_mapping = [[<C-j>]], -- Ctrl + j
    },
  },
}
