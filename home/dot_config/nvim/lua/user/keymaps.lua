local opts = { noremap = true, silent = true }
local recursive = { noremap = false, silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

-- Remap space as leader key
-- Default <Leader> is "\"
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

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

-- Yank from cursor to EOL
keymap("n", "Y", "y$", opts)

-- Clear search register with ctrl+/
keymap("n", "<C-/>", ':let @/ = ""<CR>', opts)
keymap("n", "<C-_>", ':let @/ = ""<CR>', opts)


-- Insert Mode --
-- Press jk fast to exit insert mode 
keymap("i", "jk", "<ESC>", opts)

-- Visual Mode --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- More intuitive yank/put behaviour
keymap("v", "p", '"_dP', opts)

-- Visual Block Mode --
-- <empty>

-- VSCode-style comment-toggling --
-- Normal Mode
-- line comment
keymap("n", "<M-/>", 'gcc', recursive)
-- block comment
keymap("n", "<M-?>", 'gcb', recursive)
-- Visual Mode
keymap("v", "<M-/>", 'gc', recursive)
keymap("v", "<M-?>", 'gb', recursive)

-- VSCode-style line movement/duplication with alt-direction --
-- Move lines up and down
-- Insert Mode
keymap("i", "<A-Up>", "<Esc>:m .-2<CR>==i", opts)
keymap("i", "<A-Down>", "<Esc>:m .+1<CR>==i", opts)
-- Normal Mode
keymap("n", "<A-k>", "<Esc>:m .-2<CR>==", opts)
keymap("n", "<A-j>", "<Esc>:m .+1<CR>==", opts)
keymap("n", "<A-Up>", "<Esc>:m .-2<CR>==", opts)
keymap("n", "<A-Down>", "<Esc>:m .+1<CR>==", opts)
-- Visual Mode
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)
-- for some reason also works with arrow keys?
-- Visual Block Mode
keymap("x", "<A-Down>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-Up>", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)


-- Dupicate lines above/below
-- keymap("n", "<A-S-Down>", "yy :call append(getline(\".\"), getreg())", opts)



