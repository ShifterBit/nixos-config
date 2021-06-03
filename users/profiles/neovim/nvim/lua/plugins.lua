local cmd = vim.cmd

cmd 'packadd packer.nvim'


------------------------
--------Packages--------
------------------------
return require('packer').startup(function()


  use {'wbthomason/packer.nvim', opt = true}

  ---- Utils ----
  use 'tpope/vim-repeat'
  use 'tpope/vim-surround'
  use 'tpope/vim-commentary'
  use 'tpope/vim-obsession'
  use 'tpope/vim-fugitive'
  use 'antoinemadec/FixCursorHold.nvim'

  ---- Dev ----
  use 'rust-lang/rust.vim'

  ---- Completion ----
  use 'hrsh7th/nvim-compe'

  ---- Linting ----
  use 'dense-analysis/ale'

  ---- LSP ----
  use 'neovim/nvim-lspconfig'
  use 'nvim-lua/lsp_extensions.nvim'
  use { 'RishabhRD/nvim-lsputils', requires = { 'RishabhRD/popfix' } }

  ---- Syntax ----
  use 'lnl7/vim-nix'
  use 'nvim-treesitter/nvim-treesitter'

  ---- Snippets ----
  use 'cohama/lexima.vim'
  use 'hrsh7th/vim-vsnip'
  use 'norcalli/snippets.nvim'
  use 'hrsh7th/vim-vsnip-integ'
  use 'microsoft/vscode-typescript-next'
  use 'xabikos/vscode-javascript'
  use 'microsoft/vscode-cpptools'
  use 'rust-lang/rls-vscode'
  use 'tht13/Python-vscode'

  ---- Theme ----
  use 'sainnhe/sonokai'
  use 'arcticicestudio/nord-vim'
  use 'norcalli/nvim-colorizer.lua'
  use 'kyazdani42/nvim-web-devicons'
  use 'vim-airline/vim-airline'
  use 'vim-airline/vim-airline-themes'

  ---- FZF ----
  use {'junegunn/fzf', run = function() vim.fn['fzf#install()'](0) end}
  use 'junegunn/fzf.vim'
  use 'gfanto/fzf-lsp.nvim'


end)
