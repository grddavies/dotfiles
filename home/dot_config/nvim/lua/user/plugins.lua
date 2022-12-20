-- https://github.com/wbthomason/packer.nvim#bootstrapping
local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local PACKER_BOOTSTRAP = ensure_packer()
local VSCODE_NVIM = vim.g.vscode == 1

-- Automatically source and re-compile packer whenever you save this file
local packer_group = vim.api.nvim_create_augroup('Packer', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', {
  command = 'source <afile> | PackerCompile',
  group = packer_group,
  pattern = "plugins.lua"
})

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end

if VSCODE_NVIM then
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

-- Install Packages
return require('packer').startup(function(use)
    -- Manage packer itself
    use 'wbthomason/packer.nvim'

    -- *** Standalone Only Plugins *** --
    use { -- Colour scheme / Theme
        'grddavies/darkplus.nvim',
        disable = VSCODE_NVIM
    }
    use { -- Popup notifications
        'rcarriga/nvim-notify',
        disable = VSCODE_NVIM
    }
    use { -- File explorer
        'kyazdani42/nvim-tree.lua',
        requires = {'kyazdani42/nvim-web-devicons'}
    }
    use 'nvim-lualine/lualine.nvim' -- Fancier statusline
    use { -- LSP Configuration & Plugins
        'neovim/nvim-lspconfig',
        disable = VSCODE_NVIM,
        requires = {'williamboman/mason.nvim' --[[ Automatically install LSPs to stdpath for neovim ]] ,
                    'williamboman/mason-lspconfig.nvim' --[[ Useful status updates for LSP ]] , 'j-hui/fidget.nvim'}
    }
    use { -- Highlight other uses of word under cursor
        'RRethy/vim-illuminate',
        requires = 'neovim/nvim-lspconfig'
    }
    use { -- Git integration
        "lewis6991/gitsigns.nvim",
        disable = VSCODE_NVIM
    }
    use { -- Autopair paretheses etc
        "windwp/nvim-autopairs",
        disable = VSCODE_NVIM
    }
    -- use { -- Show register contents
    --     "tversteeg/registers.nvim",
    --     disable = vscode
    -- }
    -- use { -- Rainbow paretheses
    --     "p00f/nvim-ts-rainbow",
    --     requires = "nvim-treesitter/nvim-treesitter",
    --     disable = vscode
    -- }
    -- use { -- Highlight current function context
    --     "nvim-treesitter/nvim-treesitter-context",
    --     requires = "nvim-treesitter/nvim-treesitter",
    --     disable = vscode
    -- }

    use { -- Telescope Fuzzyfinder
        "nvim-telescope/telescope.nvim",
        requires = "nvim-lua/plenary.nvim",
        disable = VSCODE_NVIM
    }
    use {
        'nvim-telescope/telescope-fzf-native.nvim',
        run = 'make',
        disable = VSCODE_NVIM
    }
    use {
        "xiyaowong/telescope-emoji.nvim",
        requires = "nvim-telescope/telescope.nvim",
        disable = VSCODE_NVIM
    }

    -- Shared Plugins // VSCode-Neovim // Standalone
    -- Editing Plugins
    use { -- Modifying text <({'surroundings'})>
        'kylechui/nvim-surround',
        config = function()
            require("nvim-surround").setup()
        end
    }
    use 'tpope/vim-abolish' -- Spelling and smart case-sentitive query replace
    use 'mg979/vim-visual-multi' -- MultiCursor support

    -- Code completion plugins
    use "hrsh7th/nvim-cmp" -- Autocompletion plugin
    use "hrsh7th/cmp-buffer" -- Buffer completions
    use "hrsh7th/cmp-path" -- Path completions
    use "hrsh7th/cmp-cmdline" -- cmdline completions
    use 'hrsh7th/cmp-nvim-lsp' -- LSP source for nvim-cmp
    use { -- Completions for Lua nvim api
        'hrsh7th/cmp-nvim-lua',
        ft = 'lua'
    }
    use "saadparwaiz1/cmp_luasnip" -- Snippet completions
    -- Snippets
    use "L3MON4D3/LuaSnip" -- Snippet engine
    use "rafamadriz/friendly-snippets" -- Snippet library

    -- Easy Block Comment
    use "numToStr/comment.nvim"
    use { -- TreeSitter Source Code Parsing
        "nvim-treesitter/nvim-treesitter",
        run = function()
            local ts_update = require('nvim-treesitter.install').update({
                with_sync = true
            })
            ts_update()
        end
    }
    -- Context-aware 'commentstring' setting
    use "JoosepAlviste/nvim-ts-context-commentstring"
    use { -- TS-Nodes as text objects
        "RRethy/nvim-treesitter-textsubjects",
        after = 'nvim-treesitter'
    }

    -- Automatically set up your configuration after cloning packer.nvim
    if PACKER_BOOTSTRAP then
        print '=================================='
        print '    Plugins are being installed'
        print '    Wait until Packer completes,'
        print '       then restart nvim'
        print '=================================='
        require('packer').sync()
    end
end)
