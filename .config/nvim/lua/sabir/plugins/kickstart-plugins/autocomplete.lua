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
end

return { -- Autocompletion
  'hrsh7th/nvim-cmp',
  event = 'InsertEnter',
  dependencies = {
    -- Snippet Engine & its associated nvim-cmp source
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
    'saadparwaiz1/cmp_luasnip',

    -- Adds other completion capabilities.
    --  nvim-cmp does not ship with all sources by default. They are split
    --  into multiple repos for maintenance purposes.
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-path',
  },
  config = function()
    -- See `:help cmp`
    local cmp = require 'cmp'
    local luasnip = require 'luasnip'
    luasnip.config.setup {}

    cmp.setup {
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      completion = { completeopt = 'menu,menuone,noinsert' },

      -- For an understanding of why these mappings were
      -- chosen, you will need to read `:help ins-completion`
      --
      -- No, but seriously. Please read `:help ins-completion`, it is really good!
      mapping = cmp.mapping.preset.insert {
        -- Select the [n]ext item
        ['<C-n>'] = cmp.mapping.select_next_item(),
        -- Select the [p]revious item
        ['<C-p>'] = cmp.mapping.select_prev_item(),

        -- Scroll the documentation window [b]ack / [f]orward
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),

        -- Accept ([y]es) the completion.
        --  This will auto-import if your LSP supports it.
        --  This will expand snippets if the LSP sent a snippet.
        ['<Tab>'] = cmp.mapping.confirm { select = true },

        -- If you prefer more traditional completion keymaps,
        -- you can uncomment the following lines
        --['<CR>'] = cmp.mapping.confirm { select = true },
        --['<Tab>'] = cmp.mapping.select_next_item(),
        --['<S-Tab>'] = cmp.mapping.select_prev_item(),

        -- Manually trigger a completion from nvim-cmp.
        --  Generally you don't need this, because nvim-cmp will display
        --  completions whenever it has completion options available.
        ['<C-Space>'] = cmp.mapping.complete {},

        -- Think of <c-l> as moving to the right of your snippet expansion.
        --  So if you have a snippet that's like:
        --  function $name($args)
        --    $body
        --  end
        --
        -- <c-l> will move you to the right of each of the expansion locations.
        -- <c-h> is similar, except moving you backwards.
        ['<C-l>'] = cmp.mapping(function()
          if luasnip.expand_or_locally_jumpable() then
            luasnip.expand_or_jump()
          end
        end, { 'i', 's' }),
        ['<C-h>'] = cmp.mapping(function()
          if luasnip.locally_jumpable(-1) then
            luasnip.jump(-1)
          end
        end, { 'i', 's' }),

        -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
        --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
      },
      sources = {
        {
          name = 'lazydev',
          -- set group index to 0 to skip loading LuaLS completions as lazydev recommends it
          group_index = 0,
        },
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'path' },
      },
    }
  end,
}
