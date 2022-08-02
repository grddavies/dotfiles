-- vim: foldmethod=marker

local opts = { noremap = true, silent = true }
local recursive = { noremap = false, silent = true }
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
    -- Better window navigation
    keymap("n", "<C-h>", "<C-w>h", opts)
    keymap("n", "<C-j>", "<C-w>j", opts)
    keymap("n", "<C-k>", "<C-w>k", opts)
    keymap("n", "<C-l>", "<C-w>l", opts)

    -- Open File Browser
    keymap("n", "<leader>e", ":NvimTreeToggle<CR>", opts)

    -- Resize with arrows
    keymap("n", "<C-Up>", ":resize -2<CR>", opts)
    keymap("n", "<C-Down>", ":resize +2<CR>", opts)
    keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
    keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

    -- Navigate buffers
    keymap("n", "<S-l>", ":bnext<CR>", opts)
    keymap("n", "<S-h>", ":bprevious<CR>", opts)

  end
-- }}}


-- Yanks {{{
  -- Yank from cursor to EOL
  keymap("n", "Y", "y$", opts)

  -- Yank to ctrl-v register
  keymap("n", "<leader>y", '"+y', opts)
  keymap("v", "<leader>y", '"+y', opts)

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
  if vscode_nvim then
    -- Insert mode
    keymap("i", "<A-/>", "<Esc>gcca", recursive)
    -- Normal Mode
    keymap("n", "gcc", ":VSCodeCommentary<CR>", opts)
    keymap("n", "<A-/>", 'gcc', recursive)
    -- Visual Mode
    keymap("v", "gc", "<Plug>VSCodeCommentary", opts)
    keymap("v", "<A-/>", 'gcgv', recursive)
  else
    -- Standard NeoVim --
    -- Insert Mode
    keymap("i", "<A-/>", '<Esc>gcca', recursive) -- line comment
    -- Normal Mode
    keymap("n", "<A-/>", 'gcc', recursive) -- line comment
    -- FIXME: Not block-commenting out a word as expected
    -- Should this command take some kind of motion?
    -- ie <A-S-/>+6j block comments current line and the six below?
    -- keymap("n", "<A-S-/>", 'gcb', recursive) -- block comment
    -- Visual Mode
    keymap("v", "<A-/>", 'gc', recursive) -- line
    keymap("v", "<A-S-/>", 'gb', recursive) -- block
  end
-- }}}

-- VSCode-style line movement {{{
  -- Move lines up and down
  -- Insert Mode
  keymap("i", "<A-k>", "<Esc>m`:m .-2<CR>==``a", opts)
  keymap("i", "<A-j>", "<Esc>m`:m .+1<CR>==``a", opts)
  keymap("i", "<A-Up>", "<Esc>m`:m .-2<CR>==``a", opts)
  keymap("i", "<A-Down>", "<Esc>m`:m .+1<CR>==``a", opts)
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
  keymap("i", "<A-S-j>", "<Esc>m` :t.<CR> `` ji", opts)
  keymap("i", "<A-S-k>", "<Esc>m` :t.<CR> ``a", opts)
  keymap("i", "<A-S-Up>", "<Esc>m` :t.<CR> ``a", opts)
  keymap("i", "<A-S-Down>", "<Esc>m` :t.<CR> `` ji", opts)
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
  -- keymap 'C-k' -> display signature
-- }}}

