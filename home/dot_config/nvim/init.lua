-- NeoVim Config
require "user.yankhl" -- highlight on yank
require "user.keymaps" -- Custom keybindings
require "user.options" -- Global options
require "user.plugins" -- All plugins
require "user.cmp" -- Code completion
require "user.comment" -- Easy comment code
require "user.treesitter" -- Treesitter source code parsing

-- Do not run under vscode
if (not vim.g.vscode) then
    require "user.theme" -- Editor Theme
    require "user.lsp" -- LSP setup
    require "user.nvimtree"  -- File Explorer
    require "user.telescope" -- Telescope fuzzyfinding
    require "user.autopairs" -- Auto pair brackets etc
    require "user.gitsigns"  -- Git integration
    require "user.whitespace" -- Set whitespace display characters
    require "user.illuminate" -- Highlight other instances of word under cursor
end
