-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Do not sync with system clipboard
vim.opt.clipboard = ""

vim.opt.completeopt = "menu,preview,menuone"

-- Do not unload abandoned buffers (see toggleterm setup https://github.com/akinsho/toggleterm.nvim#setup)
vim.opt.hidden = true
