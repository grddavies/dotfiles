-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

local function augroup(name)
  return vim.api.nvim_create_augroup(name, { clear = true })
end

-- Set common json names to jsonc
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  group = augroup("jsonc"),
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
  group = augroup("easy_close"),
  pattern = {
    "fugitive",
    "fugitiveblame",
    "git",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})

-- Use tsc for :make in typescript projects
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("tsc_quickfix"),
  pattern = {
    "typescript",
    "typescriptreact",
  },
  callback = function()
    vim.cmd([[compiler tsc | setlocal makeprg=npm\ exec\ tsc]])
  end,
})

-- Set .tidal giles to haskell
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  group = augroup(".tidal_filetype"),
  pattern = {
    "*.tidal",
  },
  callback = function()
    vim.api.nvim_buf_set_option(0, "filetype", "haskell")
  end,
})
