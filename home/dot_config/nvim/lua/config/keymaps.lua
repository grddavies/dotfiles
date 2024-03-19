-- vim: foldmethod=marker
-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Format buffer {{{
vim.keymap.set("n", "<A-S-f>", function()
  require("lazyvim.util").format({ force = true })
end, { desc = "Format buffer" })
--}}}

-- Yanks {{{
-- Yank from cursor to EOL
vim.keymap.set("n", "Y", "y$", { desc = "Yank to End Of Line" })

-- Yank to system keyboard
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y', { desc = "[Y]ank to system clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>Y", '"+Y', { desc = "[Y]ank to EOL to system clipboard" })

-- Put from system keyboard
vim.keymap.set({ "n", "v" }, "<leader>p", '"+p', { desc = "[P]ut from system clipboard" })

-- When putting in visual mode keep replaced text in "_ register
vim.keymap.set("v", "p", '"_dP')
-- }}}

-- Terminal {{{

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

-- Fugitive {{{
vim.keymap.set({ "n" }, "<leader>gf", "<Cmd>G<CR>", { desc = "Fugitive" })
-- }}}
