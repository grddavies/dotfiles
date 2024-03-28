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
}
