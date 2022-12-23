local vscode_colours = { bracket_1 = "#FFD700", bracket_2 = "#DA70D6", bracket_3 = "#179FFF" }

-- Disable unused providers
vim.g.loaded_python3_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0

local VSCODE = vim.g.vscode == 1

require 'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
  ensure_installed = { "help", "html", "typescript", "tsx", "javascript", "css", "scss", "cpp", "c", "rust", "r", "python" },

  -- Incremental text selection based on the named nodes from the parse tree
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<c-space>",
      node_incremental = "<c-'>",
      scope_incremental = "<c-\\>",
      node_decremental = "<c-;>"
    }
  },
  -- Experimental feature
  indent = {
    enable = true
  },

  -- PLUGINS --
  -- Automatically pair parentheses etc via 'windwp/nvim-autopairs'
  autopairs = {
    enable = not VSCODE
  },
  -- Rainbow parentheses via 'p00f/nvim-ts-rainbow'
  rainbow = {
    enable = not VSCODE,
    -- disable = { "jsx", "cpp" }, -- Disable for these languages
    extended_mode = false, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    max_file_lines = nil, -- Do not enable for files with more than n lines, int
    colors = { vscode_colours.bracket_1, vscode_colours.bracket_2, vscode_colours.bracket_3 } -- table of hex strings
    -- termcolors = {} -- table of colour name strings
  },
  -- Use treesitter context to set the 'commentstring' parameter
  -- (JoosepAlviste/nvim-ts-context-commentstring)
  context_commentstring = {
    enable = true,
    enable_autocmd = false -- for Comment.nvim integration
  },
  -- Use treesitter nodes for text objects
  textsubjects = {
    enable = true,
    prev_selection = ',', -- (Optional) keymap to select the previous selection
    keymaps = {
      ['.'] = 'textsubjects-smart',
      [';'] = 'textsubjects-container-outer',
      ['i;'] = 'textsubjects-container-inner'
    }
  }
}

-- -- Show current context/scope based on cursor position
-- require('treesitter-context').setup {
--     enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
--     max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
--     trim_scope = 'outer', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
--     patterns = { -- Match patterns for TS nodes. These get wrapped to match at word boundaries.
--         -- For all filetypes
--         -- Note that setting an entry here replaces all other patterns for this entry.
--         -- By setting the 'default' entry below, you can control which nodes you want to
--         -- appear in the context window.
--         default = {'class', 'function', 'method' -- 'for', -- These won't appear in the context
--         -- 'while',
--         -- 'if',
--         -- 'switch',
--         -- 'case',
--         }
--         -- Example for a specific filetype.
--         -- If a pattern is missing, *open a PR* so everyone can benefit.
--         --   rust = {
--         --       'impl_item',
--         --   },
--     },
--     exact_patterns = {
--         -- Example for a specific filetype with Lua patterns
--         -- Treat patterns.rust as a Lua pattern (i.e "^impl_item$" will
--         -- exactly match "impl_item" only)
--         -- rust = true,
--     }
-- }
