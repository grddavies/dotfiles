-- VSCode-nvim config --
if vim.fn.exists("g:vscode") ~= 0 then
    require "vscode.plugins"
    return
end

-- Standard NeoVim Config --
require "user.options" -- Global options
require "user.plugins" -- All plugins
require "user.keymaps" -- Custom keybindings
require "user.theme" -- Editor Theme
require "user.cmp" -- Code completion
require "user.lsp" -- LSP setup
require "user.telescope" -- Telescope fuzzyfinding
require "user.treesitter" -- Treesitter source code parsing
require "user.autopairs" -- Auto pair brackets etc

