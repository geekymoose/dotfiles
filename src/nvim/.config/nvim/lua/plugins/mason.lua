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

if (vim.g.vscode) then
    print("Loading plugin: mason is disabled on vscode (use vscode plugins instead for LSP)")
    return
else
    print("Loading plugin: mason")
end

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
local lspconfig = require("lspconfig")
require("mason-lspconfig").setup_handlers {
    function (server_name)
        lspconfig[server_name].setup {}
    end,
    ["rust_analyzer"] = function ()
        lspconfig.rust_analyzer.setup { settings = { ["rust-analyzer"] = {}, }, }
    end,
    ["clangd"] = function ()
        -- Clangd will also look for compile_commands.json inside a "generated" folder
        lspconfig.clangd.setup({ cmd = { 'clangd', '--compile-commands-dir=generated' } })
    end
}

