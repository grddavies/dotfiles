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
    "launch.json",
    "keybindings.json", -- vscode keybindings
  },
  callback = function()
    vim.api.nvim_set_option_value("filetype", "jsonc", { buf = 0 })
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
    vim.keymap.set("n", "<C-q>", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})

-- Disable codelens in the blamed buffer while fugitive blame is open
-- Codelens virt_lines only exist in the source window, which breaks scrollbind alignment
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("blame_codelens"),
  pattern = "fugitiveblame",
  callback = function(event)
    local src = vim.fn.FugitiveResult(event.buf).origin_bufnr
    if not src or not vim.api.nvim_buf_is_valid(src) then
      return
    end
    local was_enabled = vim.lsp.codelens.is_enabled({ bufnr = src })
    vim.lsp.codelens.enable(false, { bufnr = src })
    vim.api.nvim_create_autocmd("BufWinLeave", {
      buffer = event.buf,
      once = true,
      callback = function()
        if was_enabled and vim.api.nvim_buf_is_valid(src) then
          vim.lsp.codelens.enable(true, { bufnr = src })
        end
      end,
    })
  end,
})

-- Cmd Window Keymaps
vim.api.nvim_create_autocmd({ "CmdwinEnter" }, {
  group = augroup("cmdwin"),
  callback = function()
    vim.keymap.set("n", "<C-q>", "<cmd>close<CR>", { buffer = true, silent = true })
  end,
})

-- Terminal keymaps
vim.api.nvim_create_autocmd("TermOpen", {
  group = augroup("terminal"),
  pattern = {
    [[term://*]],
  },
  callback = function(event)
    vim.keymap.set("n", "gf", "<C-w>gf", { buffer = event.buf, silent = true })
  end,
})

-- Magrittr pipe in R files with alt+>
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("r"),
  pattern = {
    "r",
    "rnoweb",
  },
  callback = function()
    vim.keymap.set("i", "M->", "%>%", { buffer = true, silent = true })
  end,
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  group = augroup("dotenv"),
  pattern = {
    ".env",
  },
  callback = function()
    vim.diagnostic.enable(false)
  end,
})
