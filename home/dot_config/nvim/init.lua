-- Common Config
require "user.yankhl" -- highlight on yank
require "user.keymaps" -- Custom keybindings

-- VSCode-nvim config --
if vim.fn.exists("g:vscode") ~= 0 then
  require "vscode.plugins_vsc"
  return
end

-- Standard NeoVim Config --
require "user.options" -- Global options
require "user.plugins" -- All plugins
require "user.theme" -- Editor Theme
require "user.cmp" -- Code completion
require "user.lsp" -- LSP setup
require "user.telescope" -- Telescope fuzzyfinding
require "user.treesitter" -- Treesitter source code parsing
require "user.autopairs" -- Auto pair brackets etc
require "user.comment" -- Easy comment code
require "user.whitespace" -- Set whitespace display characters
require "user.nvimtree"  -- File Explorer

