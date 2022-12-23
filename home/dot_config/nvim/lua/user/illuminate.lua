-- Override LSP-highlighting modes in `darkplus`
vim.api.nvim_command [[ hi! def link IlluminatedWordText CursorLine ]]
vim.api.nvim_command [[ hi! def link IlluminatedWordWrite CursorLine ]]
vim.api.nvim_command [[ hi! def link IlluminatedWordRead CursorLine ]]
vim.api.nvim_set_keymap('n', '<A-n>', '<cmd>lua require"illuminate".next_reference{wrap=true}<cr>', {
    noremap = true
})
vim.api.nvim_set_keymap('n', '<A-S-n>', '<cmd>lua require"illuminate".next_reference{reverse=true,wrap=true}<cr>', {
    noremap = true
})
