return {
  'nvim-orgmode/orgmode',
  event = 'VeryLazy',
  config = function()
    -- Setup orgmode
    require('orgmode').setup {
      org_agenda_files = '~/dotfiles/orgfiles/**/*',
      org_default_notes_file = '~/dotfiles/orgfiles/refile.org',
    }
  end,
}
