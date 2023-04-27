-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Set common json names to jsonc
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = {
    ".eslintrc.json",
    "tsconfig.json",
    "keybindings.json", -- vscode keybindings
  },
  callback = function()
    vim.api.nvim_buf_set_option(0, "filetype", "jsonc")
  end,
})

-- Close some additional filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "fugitive",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})