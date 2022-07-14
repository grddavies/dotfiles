-- Highlight on yank
local opts = {
  higroup = "WildMenu",
  timeout = 150,
}

vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function() vim.highlight.on_yank(opts) end,
})

