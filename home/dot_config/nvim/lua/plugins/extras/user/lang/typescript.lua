return {
  -- Test integration
  {
    "nvim-neotest/neotest",
    dependencies = { "nvim-neotest/neotest-jest" },
    opts = function(_, opts)
      local adapters = opts.adapters
      vim.list_extend(adapters, { "neotest-jest" })
    end,
  },
  -- Debugging
  {
    "mason-nvim-dap.nvim",
    opts = function(_, opts)
      -- add tsx and treesitter
      vim.list_extend(opts.ensure_installed, {
        "js",
        "chrome",
      })
    end,
  },
}
