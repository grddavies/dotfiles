return {
  -- Set default colorscheme
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "rose-pine",
    },
  },
  --- Coding
  {
    "neovim/nvim-lspconfig",
    init = function()
      -- Modify default LSP keymaps
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      keys[#keys + 1] = { "<leader>c<leader>", "<cmd>LspRestart<cr>", desc = "Restart LSP" }
    end,
    opts = {
      -- Disable inlay hints by default, can be enabled with <leader>uh
      inlay_hints = { enabled = false },
    },
  },
  {
    "tpope/vim-fugitive",
    event = { "VeryLazy" },
  },
  {
    "numToStr/Comment.nvim",
    dependencies = "JoosepAlviste/nvim-ts-context-commentstring",
    keys = {
      -- Normal/insert mode toggle line
      {
        "<A-S-/>",
        function()
          require("Comment.api").toggle.blockwise.current()
        end,
        mode = { "i", "n" },
        desc = "Toggle block comment",
      },
      {
        "<A-S-/>",
        function()
          -- FIXME: This is a bit broken, and not actually that useful
          local api = require("Comment.api")
          local esc = vim.api.nvim_replace_termcodes("<ESC>", true, false, true)
          vim.api.nvim_feedkeys(esc, "nx", false)
          api.locked("toggle.blockwise")(vim.fn.visualmode())
          vim.api.nvim_feedkeys("gv", "nx", true)
          -- TODO: Restore visual selection as inside block, so that A-S-/ toggles off again
        end,
        mode = { "v" },
        desc = "Toggle blockwise comment",
      },
    },
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require("Comment").setup({
        -- Use treesitter to determine commentstring eg in jsx/tsx files
        pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
        mappings = false, -- Disable all mappings, use mini.comment for gc, gcc and gc text object
      })
    end,
    vscode = true,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = "nvim-treesitter/nvim-treesitter-textobjects",
    opts = function(_, opts)
      -- Ensure parsers for following grammars are installed
      vim.list_extend(opts.ensure_installed, {
        "bash",
        "c",
        "css",
        "html",
        "javascript",
        "json",
        "jsonc",
        "lua",
        "luadoc",
        "luap",
        "markdown",
        "markdown_inline",
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
      })
      -- Incremental selection keymaps
      opts.incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          scope_incremental = "<C-enter>",
          node_decremental = "<C-bs>",
        },
      }
    end,
  },
  {
    "saghen/blink.cmp",
    opts = {
      keymap = {
        preset = "enter",
        ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
        ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
        ["<C-Up>"] = { "scroll_documentation_up", "fallback" },
        ["<C-Down>"] = { "scroll_documentation_down", "fallback" },
      },
      completion = {
        accept = {
          auto_brackets = {
            enabled = false,
          },
        },
        trigger = {
          -- Prefer C-space to bring up completion menu while snippet is active
          -- So that you can tab between snippet placeholders
          show_in_snippet = false,
        },
        list = {
          -- This setting ignores vim.opts.completeopt
          selection = { preselect = true, auto_insert = true },
        },
        documentation = {
          window = {
            direction_priority = {
              menu_north = { "n", "s", "e", "w" },
              menu_south = { "s", "n", "e", "w" },
            },
          },
        },
      },
    },
  },
}
