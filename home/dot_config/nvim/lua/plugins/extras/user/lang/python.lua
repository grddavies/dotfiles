return {
  -- Install linters & formatters
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "pyright",
        "black",
        "ruff",
        "ruff-lsp",
      })
    end,
  },
  -- IPython REPL integration
  {
    "Vigemus/iron.nvim",
    opts = {
      config = {
        repl_definition = {
          python = {
            -- Can be a table or a function that
            -- returns a table (see below)
            -- TODO: Setup matplotlib kitty backend
            -- Disable autoindent to allow mutliline paste
            command = { "ipython", "--no-autoindent", "--no-confirm-exit" },
          },
        },
        optional = true,
      },
    },
  },
  -- Test integration
  { "nvim-neotest/neotest-python" },
  {
    "nvim-neotest/neotest",
    opts = {
      adapters = {
        ["neotest-python"] = {
          -- Here you can specify the settings for the adapter, i.e.
          -- runner = "pytest",
          -- python = ".venv/bin/python",
        },
      },
    },
  },
}
