-- Options relevant to NeoVim and running under VScode-nvim
local shared_options = {
  backup = false,                          -- Create a backup file
  conceallevel = 0,                        -- So that `` is visible in markdown files
  fileencoding = "utf-8",                  -- The encoding written to a file
  hlsearch = true,                         -- Highlight all matches on previous search pattern
  ignorecase = true,                       -- Ignore case in search patterns
  smartcase = true,                        -- Smart case: Use case sensitive search if uppercase chars in query
  pumheight = 10,                          -- Pop up menu height
  showmode = true,                         -- Toggle mode display
  splitbelow = true,                       -- Force all horizontal splits to go below current window
  splitright = true,                       -- Force all vertical splits to go to the right of current window
  swapfile = false,                        -- Creates a swapfile
  termguicolors = true,                    -- Set term gui colors (most terminals support this)
  timeoutlen = 250,                        -- Time to wait for a mapped sequence to complete (in milliseconds)
  undofile = true,                         -- Enable persistent undo
  writebackup = false,                     -- If a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
  expandtab = true,                        -- Convert tabs to spaces
  shiftwidth = 2,                          -- The number of spaces inserted for each indentation
  tabstop = 2,                             -- Insert 2 spaces for a tab
  startofline = true,                      -- Retain cursor position where possible
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

if vim.g.vscode == 1 then
  -- VScode-nvim
else
  -- Standalone nvim
  for k, v in pairs(standalone_options) do
    vim.opt[k] = v
  end
end

