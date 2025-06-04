return {
  lazy = true,
  'https://git.sr.ht/~whynothugo/lsp_lines.nvim',
  config = function()
    require('lsp_lines').setup {
      -- Your optional custom configuration can go here
    }

    -- Toggle off lsp_lines on startup
    vim.api.nvim_create_autocmd('VimEnter', {
      callback = function()
        require('lsp_lines').toggle()
      end,
    })

    -- Keymap to toggle lsp_lines
    vim.keymap.set('n', '<Leader>e', require('lsp_lines').toggle, { desc = 'Toggle lsp_lines' })
  end,
}
