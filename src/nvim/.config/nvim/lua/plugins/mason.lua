-- -----------------------------------------------------------------------------
-- Mason (LSP utilities)
-- https://github.com/williamboman/mason.nvim
--
-- :h mason
-- :h mason-quickstart
-- :h mason-lspconfig-quickstart
-- :h mason-settings
-- -----------------------------------------------------------------------------

require("mason").setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})

require("mason-lspconfig").setup()

