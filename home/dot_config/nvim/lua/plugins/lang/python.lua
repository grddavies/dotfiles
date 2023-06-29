-- https://github.com/neovim/nvim-lspconfig/issues/500#issuecomment-851247107
local configs = require("lspconfig/configs")
local util = require("lspconfig/util")

local path = util.path

local function get_python_path(workspace)
  -- Use activated virtualenv.
  if vim.env.VIRTUAL_ENV then
    return path.join(vim.env.VIRTUAL_ENV, "bin", "python")
  end

  -- Find and use virtualenv in workspace directory.
  for _, pattern in ipairs({ "*", ".*" }) do
    local match = vim.fn.glob(path.join(workspace, pattern, "pyvenv.cfg"))
    if match ~= "" then
      return path.join(path.dirname(match), "bin", "python")
    end
  end

  -- Fallback to system Python.
  return exepath("python3") or exepath("python") or "python"
end

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
        pyright = {
          on_init = function(client)
            client.config.settings.python.pythonPath = get_python_path(client.config.root_dir)
          end,
        },
        ruff_lsp = {},
      },
      setup = {
        ruff_lsp = function()
          require("lazyvim.util").on_attach(function(client)
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
  {
    "nvim-neotest/neotest",
    dependencies = { "nvim-neotest/neotest-python" },
    opts = function(_, opts)
      local adapters = opts.adapters
      vim.list_extend(adapters, { "neotest-python" })
    end,
  },
}
