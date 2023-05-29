-- vim: foldmethod=marker
local VSCODE_NVIM = vim.g.vscode == 1

-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Format buffer {{{
vim.keymap.set("n", "<A-S-f>", require("lazyvim.plugins.lsp.format").format, { desc = "Format buffer" })
--}}}

-- Yanks {{{
-- Yank from cursor to EOL
vim.keymap.set("n", "Y", "y$", { desc = "Yank from cursor to EOL" })

-- Yank to ctrl-v register
vim.keymap.set("n", "<leader>y", '"+y', { desc = "[Y]ank to system clipboard" })
vim.keymap.set("n", "<leader>Y", '"+Y', { desc = "[Y]ank from cursor to eol into system clipboard" })
vim.keymap.set("v", "<leader>y", '"+y', { desc = "[Y]ank to system clipboard" })
vim.keymap.set("v", "<leader>Y", '"+Y', { desc = "[Y]ank from cursor to eol into system clipboard" })

-- Put from ctrl-v register
vim.keymap.set("n", "<leader>p", '"+p', { desc = "[P]ut from system clipboard" })
vim.keymap.set("v", "<leader>p", '"+p', { desc = "[P]ut from system clipboard" })

-- When putting in visual mode keep replaced text in "*
vim.keymap.set("v", "p", '"_dP')
-- }}}

-- Comment-toggling {{{
-- Line Comment with 'Alt+/'
-- Block Comment With 'Alt+Shift+/'
vim.keymap.set({ "i", "n" }, "<A-/>", "<Plug>(comment_toggle_linewise_current)", { desc = "Toggle linewise comment" })
vim.keymap.set({ "i", "n" }, "<A-S-/>", "<Plug>(comment_toggle_blockwise_current)", { desc = "Toggle block comment" })

-- TODO: Update keymaps to reselect inner comment text object
vim.keymap.set("x", "<A-/>", "<Plug>(comment_toggle_linewise_visual)gv", { desc = "Toggle linewise comment" })
vim.keymap.set("x", "<A-S-/>", "<Plug>(comment_toggle_blockwise_visual)gv", { desc = "Toggle block comment" })
-- }}}

-- Terminal {{{
--
function _G.set_terminal_keymaps()
  local opts = { buffer = 0 }
  vim.keymap.set("t", "<C-Esc>", [[<C-\><C-n>]], opts)
  vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
  vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
  vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

-- }}}
