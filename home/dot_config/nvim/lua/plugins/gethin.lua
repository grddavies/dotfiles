-- True when not running inside vscode
local NOT_VSCODE = vim.g.vscode ~= 1

-- Disable ui plugins under vscode
local ui = require("lazyvim.plugins.ui")
for _, plugin in pairs(ui) do
  plugin["cond"] = NOT_VSCODE
end

return {
  -- Colourscheme
  { "rose-pine/neovim", name = "rose-pine", cond = NOT_VSCODE },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = function()
        if NOT_VSCODE then
          require("rose-pine").setup()
          vim.cmd("colorscheme rose-pine")
        end
      end,
    },
  },
  --
  {
    "tpope/vim-fugitive",
    cond = NOT_VSCODE,
  },
  {
    "echasnovski/mini.pairs",
    cond = NOT_VSCODE,
  },
  {
    "mini.comment",
    cond = NOT_VSCODE,
  },
  {
    "mini.pairs",
    cond = NOT_VSCODE,
  },
  {
    -- TODO: Find out why 't' text obj isn't working well then reeenable
    "mini.ai",
    enabled = false,
  },
  {
    -- Text case change and case-smart query replace
    "grddavies/text-case.nvim",
    config = true,
  },
  {
    -- Terminal window
    "akinsho/toggleterm.nvim",
    cond = NOT_VSCODE,
    version = "*",
    opts = {
      open_mapping = "<C-`>", -- Mimic VSCode keymap
    },
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    cond = NOT_VSCODE,
    opts = function(_, opts)
      opts.window.mappings = vim.tbl_extend("force", opts.window.mappings, {
        ["l"] = "open",
        ["h"] = "close_node",
      })
    end,
  },
  {
    -- Add telescope-fzf-native
    "telescope.nvim",
    cond = NOT_VSCODE,
    dependencies = {
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        config = function()
          require("telescope").load_extension("fzf")
        end,
      },
      {
        "xiyaowong/telescope-emoji.nvim",
        config = function()
          require("telescope").load_extension("emoji")
        end,
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      -- Disable treesitter syntax highlighting in VSCode
      highlight = { enable = NOT_VSCODE },
      ensure_installed = {
        "bash",
        "c",
        "css",
        "haskell",
        "html",
        "javascript",
        "json",
        "jsonc",
        "lua",
        "luadoc",
        "luap",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "r",
        "regex",
        "rust",
        "scss",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
        "yaml",
      },
    },
  },
  {
    "nvim-treesitter/playground",
    cond = NOT_VSCODE,
  },
  -- Disable default <tab> and <s-tab> behavior in LuaSnip
  {
    "L3MON4D3/LuaSnip",
    keys = function()
      return {}
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-emoji",
    },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      local luasnip = require("luasnip")
      local cmp = require("cmp")

      opts.mapping = vim.tbl_extend("force", opts.mapping, {
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
            -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
            -- they way you will only jump inside the snippet region
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<CR>"] = cmp.mapping.confirm({ select = false }),
      })
    end,
  },
}
