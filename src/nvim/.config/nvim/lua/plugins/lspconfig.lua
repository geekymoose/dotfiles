-- -----------------------------------------------------------------------------
-- LSP Config plugin
-- https://github.com/neovim/nvim-lspconfig
-- -----------------------------------------------------------------------------

local lspconfig = require('lspconfig')

lspconfig.clangd.setup {}
lspconfig.pyright.setup {}
lspconfig.rust_analyzer.setup { settings = { ['rust-analyzer'] = {}, }, }

