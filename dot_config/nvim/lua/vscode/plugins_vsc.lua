-- This file can be loaded by calling `lua require('plugins')` from your init.vim

local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

return require('packer').startup(function(use)

  -- Packages
  use 'wbthomason/packer.nvim'
  use 'tpope/vim-surround'
  use 'tpope/vim-abolish'
  use 'mg979/vim-visual-multi'

  -- Automatically set up your configuration after cloning packer.nvim
  if PACKER_BOOTSTRAP then
    require('packer').sync()
  end
end)

