return {
  -- {
  --   "jose-elias-alvarez/null-ls.nvim",
  --   opts = function(_, opts)
  --     local nls = require("null-ls")
  --     opts.sources = vim.list_extend(opts.sources, {
  --       nls.builtins.diagnostics.tsc.with({
  --         prefer_local = "node_modules/.bin",
  --       }),
  --     })
  --   end,
  -- },
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    opts = {},
  },
  -- Test integration
  {
    "nvim-neotest/neotest",
    dependencies = { "nvim-neotest/neotest-jest" },
    opts = function(_, opts)
      local adapters = opts.adapters
      vim.list_extend(adapters, { "neotest-jest" })
    end,
  },
}
