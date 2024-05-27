return {
  {
    'zbirenbaum/copilot.lua',
    enabled = true,
    cmd = 'Copilot',
    event = 'InsertEnter',
    opts = {
      suggestion = {
        enabled = true,
        auto_trigger = false,
        keymap = {
          accept = '<M-l>',
          prev = '<M-[>',
          next = '<M-]>',
          dismiss = '<C-]>',
        },
      },
      panel = {
        enabled = true,
        auto_refresh = false,
        keymap = {
          accept = '<CR>',
          jump_prev = '[[',
          jump_next = ']]',
          refresh = 'gr',
          open = '<M-CR>',
        },
      },
    },
  },
}
