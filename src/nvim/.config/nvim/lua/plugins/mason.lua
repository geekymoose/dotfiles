-- -----------------------------------------------------------------------------
-- Mason (LSP utilities)
-- https://github.com/williamboman/mason.nvim
-- https://github.com/williamboman/mason-lspconfig.nvim
--
-- :h mason
-- :h mason-quickstart
-- :h mason-lspconfig-quickstart
-- :h mason-lspconfig-automatic-server-setup
-- :h mason-settings
-- -----------------------------------------------------------------------------

local lspconfig = require("lspconfig")
local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")

mason.setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})

mason_lspconfig.setup()

