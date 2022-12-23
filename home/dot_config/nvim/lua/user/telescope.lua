local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  return
end

local actions = require "telescope.actions"

telescope.setup {
  defaults = {
    selection_caret = " ",
    path_display = { "smart" },
    file_ignore_patterns = { "^%.git/" }
  },
  pickers = {
    find_files = {
      hidden = true
    }
  },
  extensions = {
    -- Your extension configuration goes here:
    -- extension_name = {
    --   extension_config_key = value,
    -- }
    -- please take a look at the readme of the extension you want to configure

    -- Faster file searching
    fzf = {
      fuzzy = true, -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true, -- override the file sorter
      case_mode = "smart_case" -- or "ignore_case" or "respect_case"
      -- the default case_mode is "smart_case"
    },
    -- Emoji searcher
    emoji = {
      action = function(emoji)
        -- argument emoji is a table.
        -- {name="", value="", cagegory="", description=""}

        vim.fn.setreg("*", emoji.value)
        print([[Press p or "*p to paste this emoji]] .. emoji.value)

        -- insert emoji when picked
        -- vim.api.nvim_put({ emoji.value }, 'c', false, true)
      end
    }

  }
}

local notify = require('notify')

-- Load Extensions
telescope.load_extension('emoji')
telescope.load_extension('notify')

local plugname = "Telescope fzf Native"

-- Try to load fzf and help user if it can't be loaded
local fzf_loaded, _ = pcall(telescope.load_extension, 'fzf')
if not fzf_loaded then
  -- fzf extension could not load
  local build_tool = 'make'
  local cmd
  local os = vim.loop.os_uname().sysname
  if os == 'Linux' then
    cmd = "sudo apt install " .. build_tool
  elseif os == 'Darwin' then
    cmd = "brew install " .. build_tool
  else
    cmd = '...?'
    notify("Unsupported OS", vim.log.levels.WARN, {
      title = plugname
    })
  end
  -- Tell the user how to install the build_tool
  notify("`telescope-fzf-native.nvim` requires building with `" .. build_tool .. "`\nAdd `" .. build_tool ..
    "` to your $PATH or install with\n" .. cmd, vim.log.levels.INFO, {
    title = plugname,
    timeout = 10000
  })
end
