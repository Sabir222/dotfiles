vim.g.mapleader = " "
vim.keymap.set('n', '\\', '<Esc>:Ex<CR>')
vim.keymap.set({ 'n', 'i' }, '<C-s>', '<Esc>:w<CR>', {})
vim.keymap.set({ 'n', 'i' }, '<C-x>', '<Esc>:bd<CR>', {})
vim.keymap.set('n', '<leader>w', function()
  print("Leader key is working!")
end, { noremap = true, silent = true })
