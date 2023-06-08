return {
  -- Install linters & formatters
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "pyright",
        "black",
        "ruff",
      })
    end,
  },
  -- Treesitter syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "python" })
      end
    end,
  },
  -- Setup lsp servers
  {
    "neovim/nvim-lspconfig",
    dependencies = {},
    opts = {
      servers = {
        ---@type lspconfig.options.pyright
        pyright = {},
        ruff_lsp = {},
      },
      setup = {
        ruff_lsp = function()
          require("lazyvim.util").on_attach(function(client, buffer)
            if client.name == "ruff_lsp" then
              -- Use pyright for hoverProvider
              client.server_capabilities.hoverProvider = false
            end
          end)
        end,
      },
    },
  },

  -- Setup null-ls with `black`
  {
    "jose-elias-alvarez/null-ls.nvim",
    opts = function(_, opts)
      local nls = require("null-ls")
      opts.sources = vim.list_extend(opts.sources, {
        nls.builtins.formatting.black,
        nls.builtins.formatting.ruff,
      })
    end,
  },
}
