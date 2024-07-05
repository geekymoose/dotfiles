-- -----------------------------------------------------------------------------
-- LSP config plugin
-- https://github.com/neovim/nvim-lspconfig
-- Server-specific settings: see `:help lspconfig-setup`
--
-- :h lspconfig-all
-- -----------------------------------------------------------------------------

local lspconfig = require("lspconfig")

lspconfig.clangd.setup {}
lspconfig.pylsp.setup {}
lspconfig.rust_analyzer.setup { settings = { ["rust-analyzer"] = {}, }, }

-- LSP diagnostic
vim.diagnostic.config({
    virtual_text = false,
    signs = true,
    update_in_insert = true,
    underline = true,
    severity_sort = false,
})

-- LSP diagnostic custom icons
local sign = function(opts)
    vim.fn.sign_define(opts.name, {
        texthl = opts.name,
        text = opts.text,
        numhl = ''
    })
end
sign({name = 'DiagnosticSignError', text = '❌'})
sign({name = 'DiagnosticSignWarn', text = '⚠️'})
sign({name = 'DiagnosticSignHint', text = '💡'})
sign({name = 'DiagnosticSignInfo', text = '❔'})

