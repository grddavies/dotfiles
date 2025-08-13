return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        harper_ls = {
          settings = {
            ["harper-ls"] = {
              diagnosticSeverity = "hint",
              dialect = "British",
            },
          },
        },
      },
    },
  },
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      ensure_installed = { "harper_ls" },
      automatic_enable = {
        exclude = {
          "harper_ls",
        },
      },
    },
  },
}
