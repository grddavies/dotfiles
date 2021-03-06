local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim',
                                  install_path})
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end

-- Have packer use a popup window
packer.init {
    display = {
        open_fn = function()
            return require("packer.util").float {
                border = "rounded"
            }
        end
    }
}

-- Install Packages
return require('packer').startup(function(use)
    -- Package manager
    use 'wbthomason/packer.nvim'

    -- Editing Plugins
    use {'kylechui/nvim-surround', config = function() require("nvim-surround").setup() end} -- Modifying text <({'surroundings'})>
    use 'tpope/vim-abolish' -- Spelling and smart case-sentitive query replace
    use 'mg979/vim-visual-multi' -- MultiCursor support
    use { 'RRethy/vim-illuminate', requires = 'neovim/nvim-lspconfig' } -- Highlight other uses of word under cursor

    -- Theme --
    use 'grddavies/darkplus.nvim'
    use 'rcarriga/nvim-notify'

    -- Code completion plugins
    use "hrsh7th/nvim-cmp" -- Autocompletion plugin
    use "hrsh7th/cmp-buffer" -- Buffer completions
    use "hrsh7th/cmp-path" -- Path completions
    use "hrsh7th/cmp-cmdline" -- cmdline completions
    use 'hrsh7th/cmp-nvim-lsp' -- LSP source for nvim-cmp
    use {'hrsh7th/cmp-nvim-lua', ft = 'lua'} -- Completions for Lua nvim api
    use "saadparwaiz1/cmp_luasnip" -- Snippet completions

    -- Snippets
    use "L3MON4D3/LuaSnip" -- Snippet engine
    use "rafamadriz/friendly-snippets" -- Snippet library

    -- LSP
    use "neovim/nvim-lspconfig" -- Collection of configurations for built-in LSP client
    use "williamboman/nvim-lsp-installer" -- simple to use language server installer
    use "jose-elias-alvarez/null-ls.nvim" -- for formatters and linters

    -- Telescope Fuzzyfinder
    use {"nvim-telescope/telescope.nvim", requires = "nvim-lua/plenary.nvim"}
    use {
      'nvim-telescope/telescope-fzf-native.nvim',
      run = 'make'
    }
    use {"xiyaowong/telescope-emoji.nvim", requires = "nvim-telescope/telescope.nvim"}

    -- Easy Block Comment
    use "numToStr/comment.nvim"

    -- TreeSitter Source Code Parsing
    use {"nvim-treesitter/nvim-treesitter", run = ":TSUpdate"}
    -- highlight current function context
    use  {"nvim-treesitter/nvim-treesitter-context", requires = "nvim-treesitter/nvim-treesitter"}
    -- Rainbow paretheses
    use {"p00f/nvim-ts-rainbow", requires = "nvim-treesitter/nvim-treesitter"}
    -- Autopair paretheses etc
    use "windwp/nvim-autopairs"
    -- Context-aware 'commentstring' setting
    use "JoosepAlviste/nvim-ts-context-commentstring"

    -- File explorer
    use { 'kyazdani42/nvim-tree.lua', requires = {'kyazdani42/nvim-web-devicons'}}

    -- Git integration
    use "lewis6991/gitsigns.nvim"

    -- Automatically set up your configuration after cloning packer.nvim
    if PACKER_BOOTSTRAP then
        require('packer').sync()
    end
end)

