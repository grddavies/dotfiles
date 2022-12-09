local fn = vim.fn
local vscode_nvim = vim.g.vscode -- is nvim running behind vscode?
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

if vscode_nvim then
    -- No windows for packer cmds
    packer.init {
        display = {
            non_interactive = true
        }
    }
else
    -- Standalone nvim
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
end

local vscode = vim.g.vscode == 1

-- Install Packages
return require('packer').startup(function(use)
    -- Manage packer itself
    use 'wbthomason/packer.nvim'

    -- Standalone Only Plugins --
    use {
        'grddavies/darkplus.nvim',
        disable = vscode
    } -- Colour scheme / Theme
    use {
        'RRethy/vim-illuminate',
        requires = 'neovim/nvim-lspconfig'
    } -- Highlight other uses of word under cursor
    use {
        'rcarriga/nvim-notify',
        disable = vscode
    } -- popup notifications
    use {
        "neovim/nvim-lspconfig",
        disable = vscode
    } -- Collection of configurations for built-in LSP client
    use {
        "williamboman/nvim-lsp-installer",
        disable = vscode
    } -- simple to use language server installer
    use {
        "jose-elias-alvarez/null-ls.nvim",
        disable = vscode
    } -- for formatters and linters
    use {
        'kyazdani42/nvim-tree.lua',
        requires = {'kyazdani42/nvim-web-devicons'}
    } -- File explorer
    use {
        "lewis6991/gitsigns.nvim",
        disable = vscode
    } -- Git integration
    use {
        "windwp/nvim-autopairs",
        disable = vscode
    } -- Autopair paretheses etc
    use {
        "tversteeg/registers.nvim",
        disable = vscode
    }
    use {
        "p00f/nvim-ts-rainbow",
        requires = "nvim-treesitter/nvim-treesitter",
        disable = vscode
    } -- Rainbow paretheses

    -- Telescope Fuzzyfinder
    use {
        "nvim-telescope/telescope.nvim",
        requires = "nvim-lua/plenary.nvim",
        disable = vscode
    }
    use {
        'nvim-telescope/telescope-fzf-native.nvim',
        run = 'make',
        disable = vscode
    }
    use {
        "xiyaowong/telescope-emoji.nvim",
        requires = "nvim-telescope/telescope.nvim",
        disable = vscode
    }

    -- Shared Plugins // VSCode-Neovim // Standalone
    -- Editing Plugins
    use {
        'kylechui/nvim-surround',
        config = function()
            require("nvim-surround").setup()
        end
    } -- Modifying text <({'surroundings'})>
    use 'tpope/vim-abolish' -- Spelling and smart case-sentitive query replace
    use 'mg979/vim-visual-multi' -- MultiCursor support

    -- Code completion plugins
    use "hrsh7th/nvim-cmp" -- Autocompletion plugin
    use "hrsh7th/cmp-buffer" -- Buffer completions
    use "hrsh7th/cmp-path" -- Path completions
    use "hrsh7th/cmp-cmdline" -- cmdline completions
    use 'hrsh7th/cmp-nvim-lsp' -- LSP source for nvim-cmp
    use {
        'hrsh7th/cmp-nvim-lua',
        ft = 'lua'
    } -- Completions for Lua nvim api
    use "saadparwaiz1/cmp_luasnip" -- Snippet completions

    -- Snippets
    use "L3MON4D3/LuaSnip" -- Snippet engine
    use "rafamadriz/friendly-snippets" -- Snippet library

    -- Easy Block Comment
    use "numToStr/comment.nvim"

    -- TreeSitter Source Code Parsing
    use {
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate"
    }
    -- highlight current function context
    use {
        "nvim-treesitter/nvim-treesitter-context",
        requires = "nvim-treesitter/nvim-treesitter"
    }
    -- Context-aware 'commentstring' setting
    use "JoosepAlviste/nvim-ts-context-commentstring"
    -- TS-Nodes as text objects
    use "RRethy/nvim-treesitter-textsubjects"

    -- Automatically set up your configuration after cloning packer.nvim
    if PACKER_BOOTSTRAP then
        require('packer').sync()
    end
end)

