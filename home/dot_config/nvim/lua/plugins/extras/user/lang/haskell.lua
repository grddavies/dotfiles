return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        hls = {
          mason = false,
        },
      },
      setup = {
        hls = function()
          LazyVim.lsp.on_attach(function(client, _)
            if client.name == "hls" then
              -- Fix to remove highlight capability as there's an annoying error
              client.server_capabilities.documentHighlightProvider = false
            end
          end)
        end,
      },
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
