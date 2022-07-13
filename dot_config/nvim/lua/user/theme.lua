-- vim.opt.guifont = "monospace:h17" -- the font used in graphical neovim applications
vim.opt.termguicolors = true

-- VisualMulti cursor highlighting
vim.cmd("let g:VM_theme = 'purplegray'")

-- 'Illuminate' word highlighting
-- local illuminate_augroup vim.api.nvim_create_augroup("IllumanateHighlight", { clear = true })
--vim.cmd([[
--  augroup illuminate_augroup
--      autocmd!
--      autocmd VimEnter * hi illuminatedWord cterm=standout gui=standout
--  augroup END
--]])

-- Load theme
-- Requires 'martinsione/darkplus.nvim' plugin
vim.cmd([[
  try
    colorscheme darkplus
  catch /^Vim\%((\a\+)\)\=:E185/
    colorscheme default
    set background=dark
  endtry
]])

