return {
  'sabir222/bracepy.nvim',
  ft = 'python',
  opts = {
    enabled = true,
    show_function_braces = true,
    show_class_braces = true,
    show_loop_braces = true,
    show_conditional_braces = true,
    show_try_braces = true,
    brace_style = 'curly', -- 'curly', 'square', 'round'
    highlight_group = 'Comment',
    position = 'end_of_line', -- 'end_of_line', 'below_line', 'inline'
  },
}
