-- -----------------------------------------------------------------------------
-- NVim Tree
-- https://github.com/nvim-tree/nvim-tree.lua
-- -----------------------------------------------------------------------------

-- Disable netrw (to avoid conflicts)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Enable 24-bit colour
vim.opt.termguicolors = true

-- Setup (with some custom config overrides)
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

