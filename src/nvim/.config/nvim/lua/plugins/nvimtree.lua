-- -----------------------------------------------------------------------------
-- NVimTree Plugin
-- https://github.com/nvim-tree/nvim-tree.lua
-- -----------------------------------------------------------------------------

print("Loading plugin: nvimtree")

vim.g.loaded_netrw = 1          -- Ensure netrw is disabled
vim.g.loaded_netrwPlugin = 1    -- Ensure netrw is disabled
vim.opt.termguicolors = true    -- Ensure 24-bit colour is enabled

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

