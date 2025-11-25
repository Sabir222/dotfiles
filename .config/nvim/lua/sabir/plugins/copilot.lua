return {
  {
    'zbirenbaum/copilot.lua',
    lazy = true,
    config = function()
      require('copilot').setup {
        suggestion = {
          enabled = true,
          auto_trigger = false,
          accept = false,
        },
        panel = {
          enabled = false,
        },
        filetypes = {
          markdown = true,
          help = true,
          html = true,
          javascript = true,
          typescript = true,
          ['*'] = true,
        },
      }

      vim.keymap.set('i', '<Tab>', function()
        if require('copilot.suggestion').is_visible() then
          require('copilot.suggestion').accept()
        else
          vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Tab>', true, false, true), 'n', false)
        end
      end, {
        silent = true,
      })
      --toggle_auto_trigger
      vim.keymap.set('n', '<leader>tc', function()
        require('copilot.suggestion').toggle_auto_trigger()
      end, { silent = true, desc = 'Toggle Copilot auto-trigger' })
    end,
  },
  -- {
  --   'zbirenbaum/copilot.lua',
  --   enabled = true,
  --   cmd = 'Copilot',
  --   event = 'InsertEnter',
  --   lazy = false,
  --   opts = {
  --     suggestion = {
  --       enabled = true,
  --       auto_trigger = true,
  --       keymap = {
  --         accept = '<M-]>',
  --         prev = 'M-',
  --         next = '<M-[>',
  --         dismiss = '<C-]>',
  --       },
  --     },
  --     panel = {
  --       enabled = true,
  --       auto_refresh = false,
  --       keymap = {
  --         accept = '<CR>',
  --         jump_prev = '[[',
  --         jump_next = ']]',
  --         refresh = 'gr',
  --         open = '<M-CR>',
  --       },
  --     },
  --   },
  -- },
}
