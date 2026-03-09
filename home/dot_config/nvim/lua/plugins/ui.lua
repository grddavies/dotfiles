return {
  -- Colourschemes
  {
    "rose-pine/neovim",
    name = "rose-pine",
    opts = {
      enable = { legacy_highlights = false },
      before_highlight = function(group, highlight, palette)
        if highlight.bold then
          highlight.bold = false
        end
      end,
      highlight_groups = {
        Visual = { bg = "pine", blend = 40 },
        IlluminatedWordText = { bg = "highlight_med", blend = 20 },
        IlluminatedWordRead = { bg = "highlight_med", blend = 20 },
        IlluminatedWordWrite = { bg = "highlight_med", blend = 20 },
        SnacksDashboardHeader = { fg = "iris" },
        SnacksDashboardKey = { fg = "gold" },
        SnacksDashboardIcon = { fg = "pine" },
        ["@tag.tsx"] = { fg = "rose" },
      },
    },
  },
  { "rebelot/kanagawa.nvim", lazy = true },
  { "cdmill/neomodern.nvim", lazy = true },
  { "nyoom-engineering/oxocarbon.nvim", lazy = true },

  -- Layout
  {
    "folke/snacks.nvim",
    opts = {
      dashboard = {
        enabled = not vim.g.basic_mode,
        preset = {
          header = [[
      ___           ___           ___           ___                       ___     
     /\__\         /\  \         /\  \         /\__\          ___        /\__\    
    /::|  |       /::\  \       /::\  \       /:/  /         /\  \      /::|  |   
   /:|:|  |      /:/\:\  \     /:/\:\  \     /:/  /          \:\  \    /:|:|  |   
  /:/|:|  |__   /::\-\:\  \   /:/  \:\  \   /:/__/  ___      /::\__\  /:/|:|__|__ 
 /:/ |:| /\__\ /:/\:\ \:\__\ /:/__/ \:\__\  |:|  | /\__\  __/:/\/__/ /:/ |::::\__\
 \/__|:|/:/  / \:\-\:\ \/__/ \:\  \ /:/  /  |:|  |/:/  / /\/:/  /    \/__/--/:/  /
     |:/:/  /   \:\ \:\__\    \:\  /:/  /   |:|__/:/  /  \::/__/           /:/  / 
     |::/  /     \:\ \/__/     \:\/:/  /     \::::/__/    \:\__\          /:/  /  
     /:/  /       \:\__\        \::/  /       ----         \/__/         /:/  /   
     \/__/         \/__/         \/__/                                   \/__/    
]],
        },
      },
    },
  },
  {
    "lualine.nvim",
    enabled = not vim.g.basic_mode,
    opts = {
      options = {
        component_separators = "",
        section_separators = { left = "", right = "" },
      },
    },
  },
  {
    "folke/edgy.nvim",
    enabled = not vim.g.basic_mode,
    opts = function(_, opts)
      vim.list_extend(opts.bottom, {
        {
          ft = "fugitive",
          size = { height = 0.4 },
          filter = function(_, win)
            return vim.api.nvim_win_get_config(win).relative == ""
          end,
        },
      })
      return vim.tbl_extend("force", opts, {
        animate = { enabled = false },
        options = { left = { size = 40 } },
      })
    end,
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      filesystem = {
        filtered_items = {
          visible = true,
          hide_dotfiles = false,
          hide_gitignored = true,
        },
      },
      window = {
        mappings = {
          ["l"] = "open",
          ["h"] = "close_node",
        },
      },
    },
  },
  {
    "folke/noice.nvim",
    enabled = not vim.g.basic_mode,
    opts = {
      presets = {
        lsp_doc_border = true, -- add a border to hover docs and signature help
      },
    },
  },
}
