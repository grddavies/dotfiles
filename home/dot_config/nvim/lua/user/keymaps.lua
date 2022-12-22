-- vim: foldmethod=marker
local opts = {
  noremap = true,
  silent = true
}
local recursive = {
  noremap = false,
  silent = true
}
local vscode_nvim = vim.g.vscode

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

-- Leader defn {{{
-- Remap space as leader key
-- Default <Leader> is "\"
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "
-- }}}

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Standalone only keymaps {{{
if not vscode_nvim then
  -- Normal Mode --
  -- Better window navigation {{{
  keymap("n", "<C-h>", "<C-w>h", opts)
  keymap("n", "<C-j>", "<C-w>j", opts)
  keymap("n", "<C-k>", "<C-w>k", opts)
  keymap("n", "<C-l>", "<C-w>l", opts)
  -- }}}

  -- Format buffer (requires user.lsp) {{{
  keymap("n", "<A-S-f>", ":Format<CR>", opts)
  -- keymap("n", "<A-F>", ":Format<CR>", opts)
  --}}}

  -- Open File Browser {{{
  keymap("n", "<leader>e", ":NvimTreeToggle<CR>", opts)
  --}}}

  -- Resize with arrows {{{
  keymap("n", "<C-Up>", ":resize -2<CR>", opts)
  keymap("n", "<C-Down>", ":resize +2<CR>", opts)
  keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
  keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)
  --}}}

  -- Navigate buffers {{{
  keymap("n", "<S-l>", ":bnext<CR>", opts)
  keymap("n", "<S-h>", ":bprevious<CR>", opts)
  --}}}

  -- TelescopeKeymaps {{{
  -- See `:help telescope.builtin`
  vim.keymap.set('n', '<leader>\\', require('telescope.builtin').oldfiles, { desc = '[\\] Find recently opened files' })
  vim.keymap.set('n', '<leader>sb', require('telescope.builtin').buffers, { desc = '[S]earch [B]uffers' })
  vim.keymap.set('n', '<leader>/', function()
    -- You can pass additional configuration to telescope to change theme, layout, etc.
    require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
      winblend = 10,
      previewer = false,
    })
  end, { desc = '[/] Fuzzily search in current buffer]' })

  vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
  vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
  vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
  vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
  vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
  --}}}
  -- End Standalone keymaps
end
-- }}}

-- Yanks {{{
-- Yank from cursor to EOL
keymap("n", "Y", "y$", opts)

-- Yank to ctrl-v register
keymap("n", "<leader>y", '"+y', opts)
keymap("v", "<leader>y", '"+y', opts)

-- Put from ctrl-v register
keymap("n", "<leader>p", '"+p', opts)
keymap("v", "<leader>p", '"+p', opts)

-- More intuitive yank/put behaviour
keymap("v", "p", '"_dP', opts)

-- }}}

-- Misc user-defined {{{

-- Clear search register with ctrl+/
keymap("n", "<C-/>", ':let @/ = ""<CR>', opts)
keymap("n", "<C-_>", ':let @/ = ""<CR>', opts)
-- }}}

-- Common keymaps {{{
-- Press jk fast to exit insert mode
keymap("i", "jk", "<ESC>", opts)

-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- }}}

-- Comment-toggling {{{
-- Line Comment with 'Alt+/'
-- Block Comment With 'Alt+Shift+/'
if vscode_nvim then
  -- Line Comment with 'Alt+/'
  -- Insert mode
  keymap("i", "<A-/>", "<Esc>gcca", recursive)
  -- Normal Mode
  keymap("n", "gcc", "<Plug>VSCodeCommentary", opts)
  keymap("n", "<A-/>", 'gcc', recursive)
  -- Visual Mode
  keymap("v", "gc", "'<,'><Plug>VSCodeCommentary", opts)
  keymap("v", "<A-/>", 'gcgv', recursive)

  vim.cmd([[
        function! s:vscodeCommentBlock(...) abort
            if !a:0
                let &operatorfunc = matchstr(expand('<sfile>'), '[^. ]*$')
                return 'g@'
            elseif a:0 > 1
                let [line1, line2] = [a:1, a:2]
            else
                let [line1, line2] = [line("'["), line("']")]
            endif
        
            call VSCodeCallRange('editor.action.blockComment', line1, line2, 0)
        endfunction

        command! -range -bar VSCodeCommentBlock call s:vscodeCommentBlock(<line1>, <line2>)

        xnoremap <expr> <Plug>VSCodeCommentBlock <SID>vscodeCommentBlock()
        nnoremap <expr> <Plug>VSCodeCommentBlock <SID>vscodeCommentBlock()
    ]])
  -- Block Comment With 'Alt+Shift+/'
  -- Insert mode
  keymap("i", "<A-S-/>", "<Esc>lgbca", recursive)
  -- Normal Mode
  keymap("n", "gbc", "<Plug>VSCodeCommentBlock", opts)
  keymap("n", "<A-S-/>", 'gbc', recursive)
  -- Visual Mode
  keymap("v", "gb", "'<,'><Plug>VSCodeCommentBlock", opts)
  keymap("v", "<A-S-/>", 'gbgv', recursive)

else
  -- Standard NeoVim --
  -- Insert Mode
  keymap("i", "<A-/>", '<Esc>gcca', recursive) -- Line
  keymap("i", "<A-S-/>", "<Esc>gbca", recursive) -- Block
  -- Normal Mode
  keymap("n", "<A-/>", 'gcc', recursive) -- Line
  keymap("n", "<A-S-/>", 'gbc', recursive) -- Block
  -- Visual Mode
  keymap("v", "<A-/>", 'gcgv', recursive) -- Line
  keymap("v", "<A-S-/>", 'gbgv', recursive) -- Block
end
-- }}}

-- VSCode-style line movement {{{
-- Move lines up and down
-- Insert Mode

if not vscode_nvim then
  keymap("i", "<A-k>", "<Esc>m`:m .-2<CR>==``a", opts)
  keymap("i", "<A-j>", "<Esc>m`:m .+1<CR>==``a", opts)
  keymap("i", "<A-Up>", "<Esc>m`:m .-2<CR>==``a", opts)
  keymap("i", "<A-Down>", "<Esc>m`:m .+1<CR>==``a", opts)
end
-- Normal Mode
keymap("n", "<A-k>", "<Esc>m`:m .-2<CR>==``", opts)
keymap("n", "<A-j>", "<Esc>m`:m .+1<CR>==``", opts)
keymap("n", "<A-Up>", "<Esc>m`:m .-2<CR>==``", opts)
keymap("n", "<A-Down>", "<Esc>m`:m .+1<CR>==``", opts)
-- Visual Mode
keymap("v", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
-- for some reason also works with arrow keys?
-- Visual Block Mode
keymap("x", "<A-k>", ":move '<-2<CR>gv=gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv=gv", opts)
keymap("x", "<A-Up>", ":move '<-2<CR>gv=gv", opts)
keymap("x", "<A-Down>", ":move '>+1<CR>gv=gv", opts)

-- Duplicate lines above/below
-- Insert Mode
if not vscode_nvim then
  keymap("i", "<A-S-j>", "<Esc>m` :t.<CR> `` ji", opts)
  keymap("i", "<A-S-k>", "<Esc>m` :t.<CR> ``a", opts)
  keymap("i", "<A-S-Up>", "<Esc>m` :t.<CR> ``a", opts)
  keymap("i", "<A-S-Down>", "<Esc>m` :t.<CR> `` ji", opts)
end
-- Normal Mode
keymap("n", "<A-S-k>", "m` :t.<CR> ``", opts)
keymap("n", "<A-S-j>", "m` :t.<CR> `` jh", opts)
keymap("n", "<A-S-Up>", "m` :t.<CR> ``", opts)
keymap("n", "<A-S-Down>", "m` :t.<CR> `` jh", opts)
-- -- Visual Mode
-- keymap("v", "<A-J>", ":co .+1<CR>==", opts)
-- keymap("v", "<A-K>", ":co .-2<CR>==", opts)
-- }}}

-- LSP {{{
-- Diagnostic keymaps
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)

-- Additional LSP keymaps in user.lsp
-- }}}
