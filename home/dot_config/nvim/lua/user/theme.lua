vim.opt.termguicolors = true

-- VisualMulti cursor highlighting
vim.cmd("let g:VM_theme = 'purplegray'")

-- Load theme
-- Requires 'grddavies/darkplus.nvim' plugin
vim.cmd([[
  try
    colorscheme darkplus
  catch /^Vim\%((\a\+)\)\=:E185/
    colorscheme default
    set background=dark
  endtry
]])

