local mapping_key_prefix = vim.g.ai_prefix_key or "<leader>a"

return {
  {
    "folke/which-key.nvim",
    optional = true,
    opts = {
      spec = {
        { mapping_key_prefix, group = "AI Code Companion", mode = { "n", "v" } },
      },
    },
  },
  {
    "folke/edgy.nvim",
    optional = true,
    opts = function(_, opts)
      opts.right = opts.right or {}
      table.insert(opts.right, {
        ft = "codecompanion",
        title = "Companion Chat",
        size = { width = 70 },
      })
    end,
  },
  {
    "olimorris/codecompanion.nvim",
    cmd = { "CodeCompanion", "CodeCompanionChat" },
    event = "VeryLazy",
    keys = {
      {
        mapping_key_prefix .. "a",
        function()
          require("codecompanion").actions({})
        end,
        desc = "Actions",
      },
      {
        mapping_key_prefix .. "c",
        function()
          require("codecompanion").toggle()
        end,
        desc = "Toggle Chat",
        mode = { "n", "v" },
      },
    },
    init = function()
      require("plugins.ai.codecompanion-notify").setup()
    end,
    opts = {
      adapters = {
        anthropic = function()
          return require("codecompanion.adapters").extend("anthropic", {
            env = {
              api_key = "cmd:rbw get ANTHROPIC_API_KEY",
            },
          })
        end,
      },
      strategies = {
        chat = {
          adapter = "anthropic",
        },
        inline = {
          adapter = "anthropic",
        },
        cmd = {
          adapter = "anthropic",
        },
      },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
  },
  -- prevent neo-tree from opening files in codecompanion chat window
  {
    "nvim-neo-tree/neo-tree.nvim",
    optional = true,
    opts = function(_, opts)
      table.insert(opts.open_files_do_not_replace_types, "codecompanion")
    end,
  },
}
