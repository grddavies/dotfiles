return {
  -- Colourschemes
  {
    "rebelot/kanagawa.nvim",
  },
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
  { "nyoom-engineering/oxocarbon.nvim", event = "VeryLazy" },
  -- Layout
  {
    "folke/snacks.nvim",
    opts = {
      dashboard = {
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
    opts = {
      options = {
        section_separators = { left = "", right = "" },
      },
    },
  },
  {
    "folke/edgy.nvim",
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
      window = { mappings = {
        ["l"] = "open",
        ["h"] = "close_node",
      } },
    },
  },
}
