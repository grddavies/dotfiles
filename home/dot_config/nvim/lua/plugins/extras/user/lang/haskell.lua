return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = { hls = { mason = false } },
    },
  },
  -- Install linters & formatters
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = { "fourmolu" },
    },
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
  -- -- TODO: Set up fourmolu with conform-nvim
  --
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
