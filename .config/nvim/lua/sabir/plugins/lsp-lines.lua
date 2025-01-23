return {
  'https://git.sr.ht/~whynothugo/lsp_lines.nvim',
  config = function()
    require('lsp_lines').setup {
      -- Your optional custom configuration can go here
    }

    vim.keymap.set('', '<Leader>e', require('lsp_lines').toggle, { desc = 'Toggle lsp_lines' })
  end,
}
