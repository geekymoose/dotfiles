-- -----------------------------------------------------------------------------
-- NVimTree Plugin
-- https://github.com/nvim-tree/nvim-tree.lua
-- -----------------------------------------------------------------------------

vim.g.loaded_netrw = 1          -- Disable netrw
vim.g.loaded_netrwPlugin = 1    -- Disable netrw
vim.opt.termguicolors = true    -- Enable 24-bit colour

require("nvim-tree").setup {
    view = {
        width = 40,
    },
    renderer = {
        indent_width = 2,
        indent_markers = {
            enable = true,
        },
        icons = {
            git_placement = "after",
            show = {
                folder_arrow = false,
            },
        },
    },
}

-- Key bindings
vim.keymap.set('n', '<F5>', ':NvimTreeCollapse<CR>')
vim.keymap.set('n', '<F6>', ':NvimTreeToggle<CR>')
vim.keymap.set('n', '<F7>', ':NvimTreeOpen<CR>')
vim.keymap.set('n', '<F8>', ':NvimTreeFindFile<CR>')

