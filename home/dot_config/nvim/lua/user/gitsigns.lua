local status, gitsigns = pcall(require, "gitsigns")
if not status then
  local notify = require("notifty")
  notify("Could not load `gitsigns`", vim.log.levels.INFO, { title = "gitsigns", timeout = 10000 })
  return
end

gitsigns.setup()

