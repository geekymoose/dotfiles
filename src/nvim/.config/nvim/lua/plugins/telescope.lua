-- -----------------------------------------------------------------------------
-- https://github.com/nvim-telescope/telescope.nvim
-- -----------------------------------------------------------------------------

local telescope = require("telescope.builtin")

-- Key bindings
vim.keymap.set('n', '<C-p>', telescope.find_files, {})
vim.keymap.set('n', '<leader>f', telescope.live_grep, {})
vim.keymap.set('n', '<leader>b', telescope.buffers, {})
vim.keymap.set('n', '<leader>fh', telescope.help_tags, {})

