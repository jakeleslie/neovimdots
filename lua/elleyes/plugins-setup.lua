local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end
local packer_bootstrap = ensure_packer()

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins-setup.lua source <afile> | PackerSync
  augroup end
]])

local status, packer = pcall(require, "packer")
if not status then
  return
end

return packer.startup(function(use)
  use("wbthomason/packer.nvim")
  use("bluz71/vim-nightfly-guicolors")
  use ({
  'nvim-tree/nvim-tree.lua',
  requires = {
    'nvim-tree/nvim-web-devicons', -- optional, for file icons
  },
  tag = 'nightly' -- optional, updated every week. (see issue #1193)
})

  use("neovim/nvim-lspconfig")

  use({"akinsho/toggleterm.nvim", tag = '*', config = function()
  require("toggleterm").setup()
end})

    use ("nvim-treesitter/nvim-treesitter")

    use {
  'nvim-lualine/lualine.nvim',
  requires = { 'kyazdani42/nvim-web-devicons', opt = true }
}

use {
    'numToStr/Comment.nvim',
    config = function()
        require('Comment').setup()
    end
}

use {
  'nvim-telescope/telescope.nvim', tag = '0.1.0',
-- or                            , branch = '0.1.x',
  requires = { {'nvim-lua/plenary.nvim'} }
}

use "hrsh7th/nvim-cmp"
use "hrsh7th/cmp-buffer"
use "hrsh7th/cmp-path"
use "hrsh7th/cmp-nvim-lua"
use "hrsh7th/cmp-nvim-lsp"
use({"L3MON4D3/LuaSnip", tag = "v<CurrentMajor>.*", run = "make install_jsregexp"})

-- using packer.nvim
use {'akinsho/bufferline.nvim', tag = "v3.*", requires = 'kyazdani42/nvim-web-devicons'}

  if packer_bootstrap then
    require("packer").sync()
  end
end)
