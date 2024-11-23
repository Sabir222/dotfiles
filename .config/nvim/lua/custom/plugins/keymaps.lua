return {
  -- files cmds keymaps
  vim.keymap.set('n', '<;>', ':Neotree toggle<CR>', {}),
  vim.keymap.set({ 'n', 'i' }, '<C-s>', '<Esc>:w<CR>', {}),
  vim.keymap.set({ 'n', 'i' }, '<C-f>', '<Esc>:copy.<CR>', {}),
  vim.keymap.set({ 'n', 'i' }, '<C-x>', '<Esc>:bd<CR>', {}),
  -- CopilotChat keymaps
  vim.keymap.set({ 'n', 'v' }, '<leader>ce', ':CopilotChatExplain<CR>', {}),
  vim.keymap.set({ 'n', 'v' }, '<leader>cr', ':CopilotChatReview<CR>', {}),
  vim.keymap.set({ 'n', 'v' }, '<leader>cf', ':CopilotChatFix<CR>', {}),
  vim.keymap.set({ 'n', 'v' }, '<leader>cd', ':CopilotChatDocs<CR>', {}),
  vim.keymap.set({ 'n', 'v' }, '<leader>ct', ':CopilotChatTests<CR>', {}),
  vim.keymap.set({ 'n', 'v', 'i' }, '<C-z>', '<Esc>:CopilotChatToggle<CR>', {}),
  -- Remap Tab to go to Normal mode in Insert mode
  vim.api.nvim_set_keymap('i', '<Tab>', '<Esc>', { noremap = true, silent = true }),
  -- Themery : theme switcher
  vim.keymap.set({ 'n', 'v' }, '<leader>tt', ':Themery<CR>', {}),
  -- git plugins keymaps
  vim.keymap.set({ 'n', 'v' }, '<leader>gn', ':Neogit<CR>', {}),
  vim.keymap.set({ 'n', 'v' }, '<leader>gdo', ':DiffviewOpen<CR>', {}),
  vim.keymap.set({ 'n', 'v' }, '<leader>gdc', ':DiffviewClose<CR>', {}),
  -- open lazy vim plugins manager
  vim.keymap.set({ 'n', 'v' }, '<leader>ll', ':Lazy<CR>', {}),
}
