return {
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    branch = 'canary',
    dependencies = {
      { 'zbirenbaum/copilot.lua' }, -- or github/copilot.vim
      { 'nvim-lua/plenary.nvim' }, -- for curl, log wrapper
    },
    opts = {
      debug = true, -- Enable debugging
      question_header = '## sabir', -- Header to use for user questions
      answer_header = '## Copilot ', -- Header to use for AI answers
      error_header = '## Error ', -- Header to use for errors
      separator = '---', -- Separator to use in chat
      model = 'gpt-4', -- GPT model to use, 'gpt-3.5-turbo' or 'gpt-4'
      temperature = 0.1, -- GPT temperature
      show_help = false,
    },
    -- See Commands section for default commands if you want to lazy load on them
  },
}
