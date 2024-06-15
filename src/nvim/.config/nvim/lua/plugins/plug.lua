-- -----------------------------------------------------------------------------
-- Plugins manager (vim-plug)
-- https://github.com/junegunn/vim-plug
-- -----------------------------------------------------------------------------

local plug = vim.fn['plug#']

vim.call('plug#begin')

-- Theme
plug('https://github.com/mofiqul/vscode.nvim')
plug('https://github.com/nvim-lualine/lualine.nvim')
plug('https://github.com/nvim-tree/nvim-web-devicons')

-- Explorer
plug('https://github.com/nvim-tree/nvim-tree.lua')
plug('https://github.com/romgrk/barbar.nvim')

-- Search
plug('https://github.com/nvim-telescope/telescope.nvim')
plug('https://github.com/nvim-lua/plenary.nvim') -- required by telescope

-- Syntax
plug('https://github.com/editorconfig/editorconfig-vim')
plug('https://github.com/rrethy/vim-illuminate')
plug('https://github.com/windwp/nvim-autopairs')

-- LSP / Completion
plug('https://github.com/nvim-treesitter/nvim-treesitter')
plug('https://github.com/neovim/nvim-lspconfig')
plug('https://github.com/hrsh7th/nvim-cmp')

-- Debug
plug('https://github.com/mfussenegger/nvim-dap')

-- VCS
plug('https://github.com/lewis6991/gitsigns.nvim')
plug('https://github.com/tpope/vim-fugitive')

vim.call('plug#end')

