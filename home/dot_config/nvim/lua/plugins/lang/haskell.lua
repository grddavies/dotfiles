return {
  -- TODO: Use haskell-tools
  -- { "mrcjkb/haskell-tools.nvim" },

  -- Install linters & formatters
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "fourmolu",
        "haskell-language-server",
      })
    end,
  },
  -- Treesitter syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "haskell" })
      end
    end,
  },
  -- Set up fourmolu
  {
    "jose-elias-alvarez/null-ls.nvim",
    opts = function(_, opts)
      local nls = require("null-ls")
      opts.sources = vim.list_extend(opts.sources, {
        nls.builtins.formatting.fourmolu,
      })
    end,
  },
  -- GHCi REPL integration
  {
    "Vigemus/iron.nvim",
    opts = {
      config = {
        repl_definition = {
          haskell = {
            command = { "ghci" },
          },
        },
        optional = true,
      },
    },
  },
}
