local function setupCustomSnippets()
  local ls = require 'luasnip'
  local s = ls.snippet
  local t = ls.text_node
  local i = ls.insert_node
  vim.keymap.set({ 'i', 's' }, '<A-l>', function()
    if ls.expand_or_jumpable() then
      ls.expand_or_jump()
    end
  end, { silent = true })

  vim.keymap.set({ 'i', 's' }, '<A-h>', function()
    if ls.jumpable(-1) then
      ls.jump(-1)
    end
  end, { silent = true })
  -- Common HTML tags snippets
  local snippets = {
    -- hello world test
    s('hello', {
      t { 'Hello, ' },
      i(1, 'name'),
      t { ' World , i am ' },
      i(2, 'name'),
    }),
    -- Containers
    s('div.', {
      t { '<div>' },
      i(0),
      t { '</div>' },
    }),
    s('div', {
      t { '<div className="' },
      i(1, 'class'),
      t { '">' },
      i(0),
      t { '</div>' },
    }),

    -- Text elements
    s('p.', {
      t { '<p>' },
      i(0),
      t { '</p>' },
    }),
    s('p', {
      t { '<p className="' },
      i(1, 'class'),
      t { '">' },
      i(0),
      t { '</p>' },
    }),
    s('span.', {
      t { '<span>' },
      i(0),
      t { '</span>' },
    }),
    s('span', {
      t { '<span className="' },
      i(1, 'class'),
      t { '">' },
      i(0),
      t { '</span>' },
    }),

    -- Lists
    s('ul', {
      t { '<ul>' },
      t { '  ' },
      i(0),
      t { '', '</ul>' },
    }),
    s('ol', {
      t { '<ol>' },
      t { '  ' },
      i(0),
      t { '', '</ol>' },
    }),
    s('li', {
      t { '<li>' },
      i(0),
      t { '</li>' },
    }),

    -- Headers
    s('h1', {
      t { '<h1>' },
      i(0),
      t { '</h1>' },
    }),
    s('h2', {
      t { '<h2>' },
      i(0),
      t { '</h2>' },
    }),
    s('h3', {
      t { '<h3>' },
      i(0),
      t { '</h3>' },
    }),

    -- Forms
    s('button', {
      t { '<button type="' },
      i(1, 'button'),
      t { '">' },
      i(0),
      t { '</button>' },
    }),
    s('input', {
      t { '<input type="' },
      i(1, 'text'),
      t { '" ' },
      t { 'placeholder="' },
      i(2, ''),
      t { '" ' },
      t { 'value="' },
      i(3, ''),
      t { '" ' },
      t { '/>' },
    }),

    -- Links
    s('a', {
      t { '<a href="' },
      i(1, '#'),
      t { '">' },
      i(0),
      t { '</a>' },
    }),

    -- Images
    s('img', {
      t { '<img src="' },
      i(1, ''),
      t { '" alt="' },
      i(2, ''),
      t { '" />' },
    }),

    -- Section containers
    s('section', {
      t { '<section>' },
      t { '  ' },
      i(0),
      t { '', '</section>' },
    }),
    s('main', {
      t { '<main>' },
      t { '  ' },
      i(0),
      t { '', '</main>' },
    }),
    s('header', {
      t { '<header>' },
      t { '  ' },
      i(0),
      t { '', '</header>' },
    }),
    s('footer', {
      t { '<footer>' },
      t { '  ' },
      i(0),
      t { '', '</footer>' },
    }),
  }

  -- Add these snippets for both typescriptreact and javascriptreact
  ls.add_snippets('typescriptreact', snippets)
  ls.add_snippets('javascriptreact', snippets)
  ls.add_snippets('typescript', snippets)
  ls.add_snippets('javascript', snippets)
  ls.add_snippets('go', {
    -- Add the Go-specific snippet for `if err != nil`
    s('iferr', {
      t { 'if err != nil {' },
      t { '', '\t' },
      i(1, 'return err'), -- Default return statement
      t { '', '}' },
    }),
  })
end

return { -- Autocompletion
  'saghen/blink.cmp',
  event = 'InsertEnter',
  version = '1.*',
  dependencies = {
    -- Snippet Engine (blink uses LuaSnip under the hood via `preset = 'luasnip'`)
    {
      'L3MON4D3/LuaSnip',
      build = (function()
        -- Build Step is needed for regex support in snippets.
        -- This step is not supported in many windows environments.
        -- Remove the below condition to re-enable on windows.
        if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
          return
        end
        return 'make install_jsregexp'
      end)(),
      config = function()
        setupCustomSnippets()
      end,
      dependencies = {
        -- `friendly-snippets` contains a variety of premade snippets.
        --    See the README about individual language/framework/plugin snippets:
        --    https://github.com/rafamadriz/friendly-snippets
        {
          'rafamadriz/friendly-snippets',
          config = function()
            require('luasnip.loaders.from_vscode').lazy_load()
            require('luasnip').filetype_extend('javascriptreact', { 'html' })
            require('luasnip').filetype_extend('typescriptreact', { 'html' })
            require('luasnip').filetype_extend('typescript', { 'tsdoc' })
            require('luasnip').filetype_extend('javascript', { 'jsdoc' })
            require('luasnip').filetype_extend('typescript', { 'javascript' })
            require('luasnip').filetype_extend('typescriptreact', { 'javascript', 'typescript' })
          end,
        },
      },
    },
    -- SQL completion via vim-dadbod-completion
    'kristijanhusak/vim-dadbod-completion',
    -- `lazydev` provides better Lua completions for Neovim config files.
    -- Must be loaded (setup runs) before blink asks for its provider, so it's
    -- marked with config = true and loaded on the same InsertEnter event.
    {
      'folke/lazydev.nvim',
      config = true,
    },
  },
  config = function()
    require('blink.cmp').setup {
      -- 'default' (recommended) for mappings similar to built-in completions
      --   <c-y> to accept ([y]es) the completion.
      --    This will auto-import if your LSP supports it.
      --    This will expand snippets if the LSP sent a snippet.
      -- 'super-tab' for tab to accept
      -- 'enter' for enter to accept
      -- 'none' for no mappings
      --
      -- All presets have the following mappings:
      -- <tab>/<s-tab>: move to right/left of your snippet expansion
      -- <c-space>: Open menu or open docs if already open
      -- <c-n>/<c-p> or <up>/<down>: Select next/previous item
      -- <c-e>: Hide menu
      -- <c-k>: Toggle signature help
      keymap = {
        preset = 'default',
        -- Preserve the classic nvim-cmp snippet navigation you're used to
        ['<C-l>'] = { 'snippet_forward' },
        ['<C-h>'] = { 'snippet_backward' },
      },

      appearance = {
        -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = 'mono',
      },

      completion = {
        -- By default, you may press `<c-space>` to show the documentation.
        -- Optionally, set `auto_show = true` to show the documentation after a delay.
        documentation = { auto_show = false, auto_show_delay_ms = 500 },
      },

      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer', 'lazydev' },
        per_filetype = {
          sql = { 'vim-dadbod-completion', 'buffer' },
        },
        -- Register the `lazydev` provider, backed by lazydev.nvim's official
        -- blink integration (lua/lazydev/integrations/blink.lua)
        providers = {
          lazydev = {
            name = 'lazydev',
            module = 'lazydev.integrations.blink',
            score_offset = -3,
          },
        },
      },

      snippets = { preset = 'luasnip' },

      -- Blink.cmp includes an optional, recommended rust fuzzy matcher,
      -- which automatically downloads a prebuilt binary when enabled.
      --
      -- By default, we use the Lua implementation instead, but you may enable
      -- the rust implementation via `'prefer_rust_with_warning'`
      --
      -- See `:help blink-cmp-config-fuzzy` for more information
      fuzzy = { implementation = 'lua' },

      -- Shows a signature help window while you type arguments for a function
      signature = { enabled = true },
    }
  end,
}
