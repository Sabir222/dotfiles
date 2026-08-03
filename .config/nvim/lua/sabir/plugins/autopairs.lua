-- autopairs
-- https://github.com/windwp/nvim-autopairs

return {
  'windwp/nvim-autopairs',
  event = 'InsertEnter',
  config = function()
    require('nvim-autopairs').setup {}
    -- Blink.cmp handles the `confirm_done` integration natively
    -- (see blink.cmp `autopairs` option), so no cmp hook is needed here.
  end,
}
