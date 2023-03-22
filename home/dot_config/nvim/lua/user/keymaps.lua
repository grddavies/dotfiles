-- vim: foldmethod=marker
local VSCODE_NVIM = vim.g.vscode == 1;

-- Leader defn {{{
-- Remap space as leader key
-- Default <Leader> is "\"
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
if not VSCODE_NVIM then
  -- Normal Mode --
  -- Better window navigation {{{
  vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to window left" })
  vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to window above" })
  vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to window below" })
  vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to window right" })
  -- }}}

  -- Format buffer (requires user.lsp) {{{
  vim.keymap.set("n", "<A-S-f>", ":Format<CR>", { desc = "Format buffer" })

  --}}}

  -- Open File Browser {{{
  vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "Toggle File [E]xplorer" })
  --}}}

  -- Resize with arrows {{{
  vim.keymap.set("n", "<C-S-Up>", ":resize -2<CR>")
  vim.keymap.set("n", "<C-S-Down>", ":resize +2<CR>")
  vim.keymap.set("n", "<C-S-Left>", ":vertical resize -2<CR>")
  vim.keymap.set("n", "<C-S-Right>", ":vertical resize +2<CR>")
  --}}}

  -- Navigate buffers {{{
  vim.keymap.set("n", "<S-l>", ":bnext<CR>", { desc = "Next buffer" })
  vim.keymap.set("n", "<S-h>", ":bprevious<CR>", { desc = "Previous buffer" })
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

-- Misc user-defined {{{

-- No [s]ubstutute
vim.keymap.set("n", "s", "<Nop>")
vim.keymap.set("n", "S", "<Nop>")
vim.keymap.set("v", "s", "<Nop>")
vim.keymap.set("v", "S", "<Nop>")

-- Clear search register with ctrl+/
vim.keymap.set("n", "<Esc>", '<cmd>noh<cr><esc>', { desc = "Escape and clear hlsearch" })
-- }}}

-- Common keymaps {{{
-- Press jk fast to exit insert mode
vim.keymap.set("i", "jk", "<Esc>")

-- Stay in indent mode
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- }}}

-- Comment-toggling {{{
-- Line Comment with 'Alt+/'
-- Block Comment With 'Alt+Shift+/'
if VSCODE_NVIM then
  -- Line Comment with 'Alt+/'
  -- Insert mode
  vim.keymap.set("i", "<A-/>", "<Esc>gcca", { remap = true })
  -- Normal Mode
  vim.keymap.set("n", "gcc", "<Plug>VSCodeCommentary")
  vim.keymap.set("n", "<A-/>", 'gcc', { remap = true })
  -- Visual Mode
  vim.keymap.set("v", "gc", "'<,'><Plug>VSCodeCommentary")
  vim.keymap.set("v", "<A-/>", 'gcgv', { remap = true })

  -- Block Comment With 'Alt+Shift+/'
  -- Insert mode [[ block comment a line ]]
  vim.keymap.set("i", "<A-S-/>", "<Esc>lgbca", { remap = true })
  -- Normal Mode [[ block comment a line ]]
  vim.keymap.set("n", "gbc", "<Plug>VSCodeNotifyVisual('editor.action.blockComment', 1)")
  vim.keymap.set("n", "<A-S-/>", 'gbc', { remap = true })
  -- Visual Mode [[ block comment selection ]]
  vim.keymap.set("v", "gb", "<Plug>VSCodeNotifyVisual('editor.action.blockComment', 1)")
  vim.keymap.set("v", "<A-S-/>", 'gbgv', { remap = true })

else
  -- Standard NeoVim --
  -- Insert Mode
  vim.keymap.set("i", "<A-/>", '<Esc>gcca', { remap = true }) -- Line
  vim.keymap.set("i", "<A-S-/>", "<Esc>gbca", { remap = true }) -- Block
  -- Normal Mode
  vim.keymap.set("n", "<A-/>", 'gcc', { remap = true }) -- Line
  vim.keymap.set("n", "<A-S-/>", 'gbc', { remap = true }) -- Block
  -- Visual Mode
  vim.keymap.set("v", "<A-/>", 'gcgv', { remap = true }) -- Line
  vim.keymap.set("v", "<A-S-/>", 'gbgv', { remap = true }) -- Block
end
-- }}}

-- VSCode-style line movement {{{
-- Move lines up and down
-- Insert Mode

if not VSCODE_NVIM then
  vim.keymap.set("i", "<A-k>", "<Esc>m`:m .-2<CR>==``a")
  vim.keymap.set("i", "<A-j>", "<Esc>m`:m .+1<CR>==``a")
  vim.keymap.set("i", "<A-Up>", "<Esc>m`:m .-2<CR>==``a")
  vim.keymap.set("i", "<A-Down>", "<Esc>m`:m .+1<CR>==``a")
end
-- Normal Mode
vim.keymap.set("n", "<A-k>", "<Esc>m`:m .-2<CR>==``")
vim.keymap.set("n", "<A-j>", "<Esc>m`:m .+1<CR>==``")
vim.keymap.set("n", "<A-Up>", "<Esc>m`:m .-2<CR>==``")
vim.keymap.set("n", "<A-Down>", "<Esc>m`:m .+1<CR>==``")
-- Visual Mode
vim.keymap.set("v", "<A-k>", ":m .-2<CR>==")
vim.keymap.set("v", "<A-j>", ":m .+1<CR>==")
-- for some reason also works with arrow keys?
-- Visual Block Mode
vim.keymap.set("x", "<A-k>", ":move '<-2<CR>gv=gv")
vim.keymap.set("x", "<A-j>", ":move '>+1<CR>gv=gv")
vim.keymap.set("x", "<A-Up>", ":move '<-2<CR>gv=gv")
vim.keymap.set("x", "<A-Down>", ":move '>+1<CR>gv=gv")

-- Duplicate lines above/below
-- Insert Mode
if not VSCODE_NVIM then
  vim.keymap.set("i", "<A-S-j>", "<Esc>m` :t.<CR> `` ji")
  vim.keymap.set("i", "<A-S-k>", "<Esc>m` :t.<CR> ``a")
  vim.keymap.set("i", "<A-S-Up>", "<Esc>m` :t.<CR> ``a")
  vim.keymap.set("i", "<A-S-Down>", "<Esc>m` :t.<CR> `` ji")
end
-- Normal Mode
vim.keymap.set("n", "<A-S-k>", "m` :t.<CR> ``")
vim.keymap.set("n", "<A-S-j>", "m` :t.<CR> `` jh")
vim.keymap.set("n", "<A-S-Up>", "m` :t.<CR> ``")
vim.keymap.set("n", "<A-S-Down>", "m` :t.<CR> `` jh")
-- -- Visual Mode
-- keymap("v", "<A-J>", ":co .+1<CR>==")
-- keymap("v", "<A-K>", ":co .-2<CR>==")
-- }}}

-- LSP {{{
-- Diagnostic keymaps
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, { desc = "Open [D]iagnostics" })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = "Show LSP diagnostic loclist" })

-- Additional LSP keymaps in user.lsp
-- }}}

-- Terminal {{{
--
function _G.set_terminal_keymaps()
  local opts = {buffer = 0}
  vim.keymap.set('t', '<C-Esc>', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
  vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

-- }}}
