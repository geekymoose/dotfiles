-- -----------------------------------------------------------------------------
-- TODO Comments utils
-- https://github.com/folke/todo-comments.nvim
--
-- :h nvim-treesitter for general help
-- :h nvim-treesitter-commands for a list of all available commands
-- -----------------------------------------------------------------------------

require("todo-comments").setup()

-- Custom key bindings
vim.keymap.set("n", "]t", function()
    require("todo-comments").jump_next()
end, { desc = "Next todo comment" })

vim.keymap.set("n", "[t", function()
    require("todo-comments").jump_prev()
end, { desc = "Previous todo comment" })

vim.keymap.set('n', '<leader>t', ':TodoTelescope<CR>', {})

