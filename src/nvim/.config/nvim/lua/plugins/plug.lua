-- -----------------------------------------------------------------------------
-- Plugins manager (vim-plug)
-- https://github.com/junegunn/vim-plug
-- -----------------------------------------------------------------------------

local plug = vim.fn['plug#']

vim.call('plug#begin')

-- UI
plug('https://github.com/nvim-lualine/lualine.nvim')
plug('https://github.com/nvim-tree/nvim-web-devicons')

-- Theme
plug('https://github.com/mofiqul/vscode.nvim')
plug('https://github.com/edeneast/nightfox.nvim')
plug('https://github.com/rebelot/kanagawa.nvim')

-- Utils
plug('https://github.com/folke/which-key.nvim')
plug('https://github.com/folke/todo-comments.nvim')
plug('https://github.com/ellisonleao/glow.nvim')
plug('https://github.com/nvim-lua/plenary.nvim') -- required by telescope

-- Explorer / Search
plug('https://github.com/nvim-tree/nvim-tree.lua')
plug('https://github.com/romgrk/barbar.nvim')
plug('https://github.com/nvim-telescope/telescope.nvim')
plug('https://github.com/nvim-telescope/telescope-fzf-native.nvim', { ['do'] = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' })
plug('https://github.com/nvim-telescope/telescope-media-files.nvim')
plug('https://github.com/ahmedkhalf/project.nvim')

-- Syntax
plug('https://github.com/rhysd/vim-clang-format')
plug('https://github.com/editorconfig/editorconfig-vim')
plug('https://github.com/rrethy/vim-illuminate')
plug('https://github.com/windwp/nvim-autopairs')

-- LSP
plug('https://github.com/nvim-treesitter/nvim-treesitter', { ['do'] = ':TSUpdate' })
plug('https://github.com/neovim/nvim-lspconfig')
plug('https://github.com/williamboman/mason.nvim')
plug('https://github.com/williamboman/mason-lspconfig.nvim')

-- Completion
plug('https://github.com/hrsh7th/vim-vsnip')
plug('https://github.com/hrsh7th/nvim-cmp')
plug('https://github.com/hrsh7th/cmp-nvim-lsp')
plug('https://github.com/hrsh7th/cmp-nvim-lua')
plug('https://github.com/hrsh7th/cmp-nvim-lsp-signature-help')
plug('https://github.com/hrsh7th/cmp-vsnip')
plug('https://github.com/hrsh7th/cmp-path')
plug('https://github.com/hrsh7th/cmp-buffer')

-- Debug
plug('https://github.com/mfussenegger/nvim-dap')
plug('https://github.com/folke/trouble.nvim')

-- VCS
plug('https://github.com/lewis6991/gitsigns.nvim')
plug('https://github.com/tpope/vim-fugitive')

vim.call('plug#end')

