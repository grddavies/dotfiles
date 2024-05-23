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
    "folke/which-key.nvim",
    opts = {
      -- Disable in vim ft to prevent crash in cmd window
      -- See <https://github.com/folke/which-key.nvim/issues/558>
      disable = {
        filetypes = { "vim" },
      },
    },
  },
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
    -- TODO: Update comment system for nvim 10.x
    "echasnovski/mini.comment",
    keys = {
      {
        "<A-/>",
        "gcgv",
        mode = { "v" },
        remap = true,
        desc = "Toggle linewise comment",
      },
    },
  },
  {
    "numToStr/Comment.nvim",
    dependencies = "JoosepAlviste/nvim-ts-context-commentstring",
    keys = {
      -- Normal/insert mode toggle line
      {
        "<A-/>",
        function()
          require("Comment.api").toggle.linewise.current()
        end,
        mode = { "i", "n" },
        desc = "Toggle linewise comment",
      },
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
    -- Add telescope-fzf-native
    "telescope.nvim",
    opts = {
      defaults = {
        dynamic_preview_title = true,
        path_display = function(_, path)
          local tail = require("telescope.utils").path_tail(path)
          return string.format("%s (%s)", tail, path)
        end,
      },
    },
    keys = {
      {
        "<leader>sy",
        function()
          require("telescope.builtin").symbols()
        end,
        desc = "Search s[y]mbols",
      },
    },
    dependencies = {
      {
        "nvim-telescope/telescope-symbols.nvim",
      },
    },
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
          scope_incremental = false,
          node_decremental = "<C-bs>",
        },
      }
    end,
  },
  -- Disable default <Tab> and <S-Tab> behavior in LuaSnip
  {
    "L3MON4D3/LuaSnip",
    vscode = true,
    keys = function()
      return {}
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    vscode = true,
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
          elseif luasnip.expand_or_locally_jumpable() then
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
