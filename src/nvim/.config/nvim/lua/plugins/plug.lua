-- -----------------------------------------------------------------------------
-- Plugins manager (vim-plug)
-- https://github.com/junegunn/vim-plug
-- -----------------------------------------------------------------------------

local vim = vim
local plug = vim.fn['plug#']

vim.call('plug#begin')

-- Theme
plug('https://github.com/mofiqul/vscode.nvim')
plug('https://github.com/nvim-lualine/lualine.nvim')
plug('https://github.com/nvim-tree/nvim-web-devicons') -- optional for barbar

-- VCS
plug('https://github.com/lewis6991/gitsigns.nvim')
plug('https://github.com/tpope/vim-fugitive')
plug('https://github.com/neogitorg/neogit')

-- Explorer / Search
plug('https://github.com/scrooloose/nerdtree')
plug('https://github.com/romgrk/barbar.nvim')
plug('https://github.com/nvim-telescope/telescope.nvim')
plug('https://github.com/nvim-lua/plenary.nvim') -- required by telescope
-- Plug('https://github.com/majutsushi/tagbar')

-- Syntax
plug('https://github.com/tree-sitter/tree-sitter')
plug('https://github.com/editorconfig/editorconfig-vim')
plug('https://github.com/rrethy/vim-illuminate')

-- LSP
plug('https://github.com/neovim/nvim-lspconfig')

vim.call('plug#end')

