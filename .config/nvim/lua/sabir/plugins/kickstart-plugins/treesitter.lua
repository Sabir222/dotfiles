return { -- Highlight, edit, and navigate code
  'nvim-treesitter/nvim-treesitter',
  dependencies = { 'nvim-treesitter/nvim-treesitter-context' },
  branch = 'main',
  config = function()
    -- On Neovim 0.12+, syntax highlighting, indentation, and folds are built-in
    -- (vim.treesitter.start() is automatic). nvim-treesitter's job is now just
    -- installing parsers; features are enabled natively.

    -- Ensure basic parsers are installed
    local parsers = {
      'bash',
      'c',
      'diff',
      'html',
      'lua',
      'go',
      'typescript',
      'javascript',
      'luadoc',
      'markdown',
      'markdown_inline',
      'query',
      'vim',
      'vimdoc',
      'python',
      'rust',
      'zig',
    }
    require('nvim-treesitter').install(parsers)

    ---@param buf integer
    ---@param language string
    local function treesitter_try_attach(buf, language)
      -- Check if a parser exists and load it
      if not vim.treesitter.language.add(language) then
        return
      end
      -- Enable syntax highlighting and other treesitter features
      vim.treesitter.start(buf, language)

      -- Check if treesitter indentation is available for this language, and if so enable it
      -- in case there is no indent query, the indentexpr will fallback to the vim's built in one
      local has_indent_query = vim.treesitter.query.get(language, 'indents') ~= nil

      -- Enable treesitter based indentation
      if has_indent_query then
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end
    end

    local available_parsers = require('nvim-treesitter').get_available()
    vim.api.nvim_create_autocmd('FileType', {
      callback = function(args)
        local buf, filetype = args.buf, args.match

        local language = vim.treesitter.language.get_lang(filetype)
        if not language then
          return
        end

        local installed_parsers = require('nvim-treesitter').get_installed 'parsers'

        if vim.tbl_contains(installed_parsers, language) then
          -- Enable the parser if it is already installed
          treesitter_try_attach(buf, language)
        elseif vim.tbl_contains(available_parsers, language) then
          -- If a parser is available in `nvim-treesitter`, auto-install it and enable it after the installation is done
          require('nvim-treesitter')
            .install(language)
            :await(function()
              treesitter_try_attach(buf, language)
            end)
        else
          -- Try to enable treesitter features in case the parser exists but is not available from `nvim-treesitter`
          treesitter_try_attach(buf, language)
        end
      end,
    })
  end,
  -- There are additional nvim-treesitter modules that you can use to interact
  -- with nvim-treesitter. You should go explore a few and see what interests you:
  --
  --    - Incremental selection: Included natively, see `:help treesitter-incremental-selection`
  --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
  --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
}
