-- -----------------------------------------------------------------------------
-- Custom key bindings
-- n:normal / i:insert / v:visual+select / x:visual / s:select / c:cmd / o:op
-- -----------------------------------------------------------------------------

print("Loading config: keymap")

vim.g.mapleader = '-'

vim.keymap.set('n', '<leader>vo', ':vsplit $HOME/.config/nvim/init.lua<CR>')
vim.keymap.set('n', '<leader>vs', ':source $HOME/.config/nvim/init.lua<CR>')

vim.keymap.set('n', '<leader>aa', ':set paste<CR>')
vim.keymap.set('n', '<leader>an', ':set nopaste<CR>')

vim.keymap.set('n', '<leader>sf', ':setlocal spelllang=fr_fr<CR>')
vim.keymap.set('n', '<leader>se', ':setlocal spelllang=en_us<CR>')

vim.keymap.set('n', '<F2>', ':set spell<CR>')
vim.keymap.set('n', '<F3>', ':set nospell<CR>')


-- -----------------------------------------------------------------------------
-- Telescope plugin
-- -----------------------------------------------------------------------------
local telescope = require("telescope.builtin")

vim.keymap.set('n', '<C-p>', telescope.find_files, {})
vim.keymap.set('n', '<C-Tab>', telescope.buffers, {})
vim.keymap.set('n', '<leader>f', telescope.live_grep, {})
vim.keymap.set('n', '<leader>h', telescope.help_tags, {})
vim.keymap.set('n', '<leader>D', function() telescope.diagnostics {} end)


-- -----------------------------------------------------------------------------
-- Projects plugin
-- -----------------------------------------------------------------------------
vim.keymap.set('n', '<F9>', ':Telescope projects<CR>')


-- -----------------------------------------------------------------------------
-- TodoComments plugin
-- -----------------------------------------------------------------------------
local todocomments = require("todo-comments")
vim.keymap.set('n', '<leader>t', ':TodoTelescope<CR>', {})
vim.keymap.set("n", "]t", function() todocomments.jump_next() end, { desc = "Next todo comment" })
vim.keymap.set("n", "[t", function() todocomments.jump_prev() end, { desc = "Previous todo comment" })


-- -----------------------------------------------------------------------------
-- NvimTree plugin
-- -----------------------------------------------------------------------------
vim.keymap.set('n', '<F5>', ':NvimTreeCollapse<CR>')
vim.keymap.set('n', '<F6>', ':NvimTreeToggle<CR>')
vim.keymap.set('n', '<F7>', ':NvimTreeOpen<CR>')
vim.keymap.set('n', '<F8>', ':NvimTreeFindFile<CR>')


-- -----------------------------------------------------------------------------
-- Vim diagnostic (see :h vim.diagnostic)
-- -----------------------------------------------------------------------------
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)


-- -----------------------------------------------------------------------------
-- LSP Config
-- Use LspAttach autocommand to only map the following keys after the LSP started
-- https://neovim.io/doc/user/lsp.html#LspAttach
-- -----------------------------------------------------------------------------

vim.keymap.set('n', '<Esc>o', ':ClangdSwitchSourceHeader<CR>') -- Hack: <Esc> because M-o didn't work (ALT+o)

vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        -- Enable completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

        local opts = { buffer = ev.buf }

        -- see `:h vim.lsp.*` for functions documentation
        vim.keymap.set('n', 'gr', ":Telescope lsp_references<CR>")
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)

        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)

        vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
        vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
        vim.keymap.set('n', '<space>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, opts)
        vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
        vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
        vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, opts)
        vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
    end,
})


