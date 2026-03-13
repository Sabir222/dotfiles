return {
  {
    'NvChad/nvim-colorizer.lua',
    lazy = false,
    init = function()
      vim.opt.termguicolors = true
    end,
    opts = {
      user_default_options = { tailwind = true },
    },
  },
}
