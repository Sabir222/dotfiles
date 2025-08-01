return {
  -- files cmds keymaps

  --vim.keymap.set('n', '<;>', ':Neotree toggle<CR>', {}),
  vim.keymap.set({ 'n', 'i' }, '<C-s>', '<Esc>:w<CR>', {}),
  vim.keymap.set({ 'n', 'i' }, '<C-f>', '<Esc>:copy.<CR>', {}),
  vim.keymap.set({ 'n', 'i' }, '<C-x>', '<Esc>:bd<CR>', {}),
  -- CopilotChat keymaps
  -- vim.keymap.set({ 'n', 'v' }, '<leader>ce', ':CopilotChatExplain<CR>', {}),
  -- vim.keymap.set({ 'n', 'v' }, '<leader>cr', ':CopilotChatReview<CR>', {}),
  -- vim.keymap.set({ 'n', 'v' }, '<leader>cf', ':CopilotChatFix<CR>', {}),
  -- vim.keymap.set({ 'n', 'v' }, '<leader>cd', ':CopilotChatDocs<CR>', {}),
  -- vim.keymap.set({ 'n', 'v' }, '<leader>ct', ':CopilotChatTests<CR>', {}),
  -- vim.keymap.set({ 'n', 'v', 'i' }, '<C-z>', '<Esc>:CopilotChatToggle<CR>', {}),
  -- Themery : theme switcher
  vim.keymap.set({ 'n', 'v' }, '<leader>tt', ':Themery<CR>', {}),
  -- git plugins keymaps
  vim.keymap.set({ 'n', 'v' }, '<leader>gn', ':Neogit<CR>', {}),
  vim.keymap.set({ 'n', 'v' }, '<leader>gdo', ':DiffviewOpen<CR>', {}),
  vim.keymap.set({ 'n', 'v' }, '<leader>gdc', ':DiffviewClose<CR>', {}),
  -- open lazy vim plugins manager
  vim.keymap.set({ 'n', 'v' }, '<leader>ll', ':Lazy<CR>', {}),
  -- leap plugins keymaps
  vim.keymap.set({ 'n', 'x', 'o' }, 'f', '<Plug>(leap-forward)'),
  vim.keymap.set({ 'n', 'x', 'o' }, 'F', '<Plug>(leap-backward)'),
  vim.keymap.set({ 'n', 'x', 'o' }, 'gf', '<Plug>(leap-from-window)'),

  -- Disable 's' in Normal and Visual modes
  vim.keymap.set('n', 's', '<Nop>', { noremap = true, silent = true }), -- Normal mode
  vim.keymap.set('x', 's', '<Nop>', { noremap = true, silent = true }), -- Visual mode
  -- marks telescope
  vim.keymap.set({ 'n', 'v' }, '<leader>lm', ':Telescope marks<CR>', {}),
  -- open mason
  vim.keymap.set({ 'n', 'v' }, '<leader>lc', ':Mason<CR>', {}),
  -- diagnostic
  vim.keymap.set('n', '<leader>x', vim.diagnostic.open_float, { desc = 'Show diagnostics' }),
  -- spectre search and replce
  vim.keymap.set('n', '<leader>ts', '<cmd>lua require("spectre").toggle()<CR>', {
    desc = 'Search & Replace Project',
  }),
  vim.keymap.set('n', '<leader>tw', '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', {
    desc = 'Search & Replace current word',
  }),
  vim.keymap.set('v', '<leader>tw', '<esc><cmd>lua require("spectre").open_visual()<CR>', {
    desc = 'Search current word',
  }),
  vim.keymap.set('n', '<leader>tf', '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', {
    desc = 'Search & Replace current file',
  }),
  -- vim.keymap.set({ 'n', 'v' }, '<leader>ts', function()
  --   require('spectre').open()
  -- end, { desc = 'Search replace in Project' }),
  -- vim.keymap.set('n', '<leader>tf', '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', {
  --   desc = 'Search on current file',
  -- }),
}
