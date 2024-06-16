-- -----------------------------------------------------------------------------
-- LSP config plugin
-- https://github.com/neovim/nvim-lspconfig
-- Server-specific settings: see `:help lspconfig-setup`
--
-- :h lspconfig-all
-- -----------------------------------------------------------------------------

local lspconfig = require("lspconfig")

lspconfig.clangd.setup {}
lspconfig.pyright.setup {}
lspconfig.rust_analyzer.setup { settings = { ["rust-analyzer"] = {}, }, }

-- LSP diagnostic
vim.diagnostic.config({
    virtual_text = false,
    signs = true,
    update_in_insert = true,
    underline = true,
    severity_sort = false,
})

