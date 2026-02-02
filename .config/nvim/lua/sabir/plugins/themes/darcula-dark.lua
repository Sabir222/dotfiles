return {
  {
    'xiantang/darcula-dark.nvim',
    config = function()
      -- setup must be called before loading
      require('darcula').setup {
        override = function(c)
          return {
            background = '#1B1B1D',
            dark = '#000000',
          }
        end,
        opt = {
          integrations = {
            telescope = false,
            snacks = true,
            lualine = true,
            lsp_semantics_token = true,
            nvim_cmp = true,
            dap_nvim = true,
          },
        },
      }
    end,
  },
}
