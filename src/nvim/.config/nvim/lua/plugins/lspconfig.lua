-- -----------------------------------------------------------------------------
-- LSP config plugin
-- https://github.com/neovim/nvim-lspconfig
--
-- For config help, see `:help lspconfig-all`
-- Server-specific settings: see `:help lsp-quickstart`
--
-- NOTE
-- Use Mason to install the LSP
-- -----------------------------------------------------------------------------

local lspconfig = require("lspconfig")

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

--  LSP configurations: C++
vim.lsp.enable('clangd')
vim.lsp.config('clangd', {
    cmd = {
        'clangd',
        '--compile-commands-dir=generated',
        -- Clangd will also look for compile_commands.json inside a "generated" folder
    }
})

--  LSP configurations: Rust
vim.lsp.enable('rust_analyzer')
vim.lsp.config('rust_analyzer', {
    settings = {
        ['rust-analyzer'] = {},
    },
})

