-- Options relevant to NeoVim and running under VScode-nvim
local shared_options = {
  backup = false,                          -- create a backup file
  conceallevel = 0,                        -- so that `` is visible in markdown files
  fileencoding = "utf-8",                  -- the encoding written to a file
  hlsearch = true,                         -- highlight all matches on previous search pattern
  ignorecase = true,                       -- ignore case in search patterns
  smartcase = true,                        -- smart case: Use case sensitive search if uppercase chars in query
  pumheight = 10,                          -- pop up menu height
  showmode = true,                         -- Toggle mode display -- INSERT -- anymore
  showtabline = 2,                         -- always show tabs
  splitbelow = true,                       -- force all horizontal splits to go below current window
  splitright = true,                       -- force all vertical splits to go to the right of current window
  swapfile = false,                        -- creates a swapfile
  termguicolors = true,                    -- set term gui colors (most terminals support this)
  timeoutlen = 100,                        -- time to wait for a mapped sequence to complete (in milliseconds)
  undofile = true,                         -- enable persistent undo
  writebackup = false,                     -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
  expandtab = true,                        -- convert tabs to spaces
  shiftwidth = 2,                          -- the number of spaces inserted for each indentation
  tabstop = 2,                             -- insert 2 spaces for a tab
  startofline = true,                      -- retain cursor position where possible
}

-- Options that don't apply to running VScode-nvim
local standalone_options = {
  scrolloff = 8,                           -- keep cursor 8 lines from top & bottom of page
  sidescrolloff = 8,
  smartindent = true,                      -- Make indenting smarter again
  cmdheight = 1,                           -- Nvim command line height
  completeopt = { "menuone", "noselect" }, -- Completion params
  updatetime = 1000,                       -- Time until completions offered (4000ms default)
  mouse = "a",                             -- Enable mouse
  cursorline = true,                       -- Highlight the current line
  cursorlineopt = 'number',                -- Only highlight current line's number
  number = true,                           -- Set numbered lines
  relativenumber = true,                   -- Set relative numbered lines
  numberwidth = 4,                         -- Set number column width to 2 {default 4}
  signcolumn = "yes",                      -- Set the number column as the sign column
  wrap = false,                            -- Display lines as one long line
  list = true,                             -- Show whitespace chars
}

vim.opt.shortmess:append "c"

for k, v in pairs(shared_options) do
  vim.opt[k] = v
end

if vim.g.vscode then
  -- VScode-nvim
else
  -- Standalone nvim
  for k, v in pairs(standalone_options) do
    vim.opt[k] = v
  end
end

