-- -----------------------------------------------------------------------------
-- Mason (LSP utilities)
-- https://github.com/williamboman/mason.nvim
--
-- :h mason
-- :h mason-quickstart
-- :h mason-lspconfig-quickstart
-- :h mason-lspconfig-automatic-server-setup
-- :h mason-settings
-- -----------------------------------------------------------------------------

print("Loading plugin: mason")

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

-- Automatic server setup for LSP installed by Mason
require("mason-lspconfig").setup_handlers {
    function (server_name)
        local lspconfig = require("lspconfig")
        lspconfig[server_name].setup {}
    end,
    ["rust_analyzer"] = function ()
        local lspconfig = require("lspconfig")
        lspconfig.rust_analyzer.setup { settings = { ["rust-analyzer"] = {}, }, }
    end
}

