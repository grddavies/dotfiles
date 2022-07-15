-- Highlight on yank
local opts = {
  -- Default higroup = "IncSearch"
  higroup = "Visual",
  timeout = 150,
}

local yankGrp = vim.api.nvim_create_augroup("YankHighlight", { clear = true })

vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function() vim.highlight.on_yank(opts) end,
  group = yankGrp,
})

