return {
  'sainnhe/gruvbox-material',
  lazy = false,
  priority = 1000,
  config = function()
    -- Configure gruvbox-material
    vim.g.gruvbox_material_background = 'hard' -- 'hard', 'medium', 'soft'
    vim.g.gruvbox_material_foreground = 'material'
    vim.g.gruvbox_material_disable_italic_comment = 0
    -- Override background color
    vim.schedule(function()
      vim.cmd 'highlight Normal guibg=#101010 ctermbg=NONE'
      vim.cmd 'highlight NormalNC guibg=#101010 ctermbg=NONE'
    end)
  end,
}
