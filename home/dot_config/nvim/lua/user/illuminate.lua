 -- Override LSP-highlighting modes in `darkplus`
 vim.api.nvim_command [[ hi! def link LspReferenceText CursorLine ]]
 vim.api.nvim_command [[ hi! def link LspReferenceWrite CursorLine ]]
 vim.api.nvim_command [[ hi! def link LspReferenceRead CursorLine ]]
 vim.api.nvim_set_keymap('n', '<A-n>', '<cmd>lua require"illuminate".next_reference{wrap=true}<cr>', {noremap=true})
 vim.api.nvim_set_keymap('n', '<A-S-n>', '<cmd>lua require"illuminate".next_reference{reverse=true,wrap=true}<cr>', {noremap=true})

