-- local vscode_colours = { bracket_1 = "#FFD700", bracket_2 = "#DA70D6", bracket_3 = "#179FFF" }

-- Disable unused providers
vim.g.loaded_python3_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0

local VSCODE = vim.g.vscode == 1

require 'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
  ensure_installed = { "help", "html", "typescript", "tsx", "javascript", "css", "scss", "cpp", "c", "rust", "r",
    "python" },

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
