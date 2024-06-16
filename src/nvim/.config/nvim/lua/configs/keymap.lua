-- -----------------------------------------------------------------------------
-- Custom general key bindings
-- n:normal / i:insert / v:visual+select / x:visual / s:select / c:cmd / o:op
-- -----------------------------------------------------------------------------

vim.g.mapleader = '-'

vim.keymap.set('n', '<leader>vo', ':vsplit $HOME/.config/nvim/init.lua<CR>')
vim.keymap.set('n', '<leader>vs', ':source $HOME/.config/nvim/init.lua<CR>')

vim.keymap.set('n', '<leader>aa', ':set paste<CR>')
vim.keymap.set('n', '<leader>an', ':set nopaste<CR>')

vim.keymap.set('n', '<leader>sf', ':setlocal spelllang=fr_fr<CR>')
vim.keymap.set('n', '<leader>se', ':setlocal spelllang=en_us<CR>')

vim.keymap.set('n', '<F2>', ':set spell<CR>')
vim.keymap.set('n', '<F3>', ':set nospell<CR>')

