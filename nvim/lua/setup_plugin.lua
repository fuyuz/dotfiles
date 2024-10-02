local jetpackfile = vim.fn.stdpath('data') .. '/site/pack/jetpack/opt/vim-jetpack/plugin/jetpack.vim'
local jetpackurl = "https://raw.githubusercontent.com/tani/vim-jetpack/master/plugin/jetpack.vim"
if vim.fn.filereadable(jetpackfile) == 0 then
  vim.fn.system(string.format('curl -fsSLo %s --create-dirs %s', jetpackfile, jetpackurl))
end

vim.cmd('packadd vim-jetpack')
require('jetpack.packer').startup(function(use)
  use 'tani/vim-jetpack'
  use 'UtkarshVerma/molokai.nvim'
  use 'navarasu/onedark.nvim'
  use {
    'nvim-tree/nvim-tree.lua',
    requires = {{'nvim-tree/nvim-web-devicons'}},
  }
  use 'tribela/transparent.nvim'
  use 'nvim-telescope/telescope.nvim'
  use 'nvim-lua/plenary.nvim'
  use 'nvim-telescope/telescope-file-browser.nvim'
  use 'windwp/nvim-autopairs'
  use 'echasnovski/mini.indentscope'
  use 'akinsho/toggleterm.nvim'

  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/nvim-cmp'

  use {
    'PaterJason/cmp-conjure',
    ft = 'clojure',
    requires = {{'Olical/conjure'}},
  }
  use {
    'luochen1990/rainbow',
    ft = 'clojure',
  }
  use {
    'ThePrimeagen/harpoon',
    branch = "harpoon2",
    requires = {{"nvim-lua/plenary.nvim"}},
  }
  use 'nvim-treesitter/nvim-treesitter'
end)

local jetpack = require('jetpack')
for _, name in ipairs(jetpack.names()) do
  if not jetpack.tap(name) then
    jetpack.sync()
    break
  end
end

