local defaults = {
  {
    "zbirenbaum/copilot.lua",
    optional = true,
    opts = {
      copilot_node_command = vim.trim(vim.fn.system("mise -q x node@latest -- which node")),
    },
  },
}

if vim.g.basic_mode then
  return defaults
end

local mapping_key_prefix = vim.g.ai_prefix_key or "<leader>a"
return vim.list_extend(defaults, {
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
    "olimorris/codecompanion.nvim",
    cmd = { "CodeCompanion", "CodeCompanionChat" },
    event = "VeryLazy",
    keys = {
      {
        mapping_key_prefix .. "f",
        function()
          require("codecompanion").actions({})
        end,
        desc = "Actions",
      },
      {
        mapping_key_prefix .. "c",
        function()
          require("codecompanion").chat()
        end,
        desc = "Chat (New)",
        mode = { "n", "v" },
      },
      {
        mapping_key_prefix .. "<space>",
        function()
          require("codecompanion").toggle()
        end,
        desc = "Toggle",
        mode = { "n", "v" },
      },
    },
    init = function()
      require("plugins.ai.codecompanion-notify").setup()
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "ravitemer/codecompanion-history.nvim",
    },
    opts = {
      extensions = {
        history = {
          enabled = true,
          opts = {
            keymap = "gh",
            save_chat_keymap = "sc",
            auto_save = true,
            expiration_days = 0,
            auto_generate_title = true,
            dir_to_save = vim.fn.stdpath("data") .. "/codecompanion-history",
            enable_logging = false,
          },
        },
      },
      adapters = {
        acp = {
          opts = {
            show_presets = false,
          },
          claude_code = function()
            return require("codecompanion.adapters").extend("claude_code", {
              env = {
                CLAUDE_CODE_OAUTH_TOKEN = "cmd:rbw get 'RA Claude Code Token'",
              },
            })
          end,
          -- NOOP so it is included in the adapter list
          opencode = function()
            return require("codecompanion.adapters").extend("opencode", {})
          end,
        },
        http = {
          opts = {
            show_presets = false,
          },
          copilot = function()
            -- NOOP so it is included in the adapter list
            return require("codecompanion.adapters").extend("copilot", {})
          end,
          anthropic = function()
            return require("codecompanion.adapters").extend("anthropic", {
              env = {
                api_key = "cmd:rbw get ANTHROPIC_API_KEY",
              },
            })
          end,
          tavily = function()
            return require("codecompanion.adapters").extend("tavily", {
              env = {
                api_key = "cmd:rbw get TAVILY_API_KEY",
              },
            })
          end,
        },
      },
      strategies = {
        chat = {
          adapter = "copilot",
          variables = {
            ["buffer"] = {
              opts = {
                default_params = "diff",
              },
            },
          },
        },
        inline = {
          adapter = "copilot",
        },
        cmd = {
          adapter = "copilot",
        },
      },
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
  {
    "folke/edgy.nvim",
    optional = true,
    opts = function(_, opts)
      opts.right = opts.right or {}
      table.insert(opts.right, {
        filter = function(buf, win)
          -- Only match codecompanion chat buffers
          local bufname = vim.api.nvim_buf_get_name(buf)
          return bufname:match("%[CodeCompanion%]")
        end,
        ft = "codecompanion",
        title = "Chat",
        size = { width = 70 },
      })
    end,
  },
})
