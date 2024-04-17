-- -----------------------------------------------------------------------------
-- Plugins manager (vim-plug)
-- https://github.com/junegunn/vim-plug
-- -----------------------------------------------------------------------------

local vim = vim
local Plug = vim.fn['plug#']

vim.call('plug#begin')

-- Theme
Plug('https://github.com/Mofiqul/vscode.nvim')
Plug('https://github.com/nvim-lualine/lualine.nvim')
Plug('https://github.com/nvim-tree/nvim-web-devicons') -- Optional for BarBar

-- Utils
Plug('https://github.com/nvim-lua/plenary.nvim') -- Required by telescope
Plug('https://github.com/editorconfig/editorconfig-vim')
Plug('https://github.com/RRethy/vim-illuminate')

-- VCS
Plug('https://github.com/lewis6991/gitsigns.nvim')
Plug('https://github.com/tpope/vim-fugitive')
Plug('https://github.com/NeogitOrg/neogit')

-- Explorer / Search
Plug('https://github.com/scrooloose/nerdtree')
Plug('https://github.com/romgrk/barbar.nvim')
Plug('https://github.com/nvim-telescope/telescope.nvim')
-- Plug('https://github.com/majutsushi/tagbar')

-- Syntax
Plug('https://github.com/tree-sitter/tree-sitter')

vim.call('plug#end')

