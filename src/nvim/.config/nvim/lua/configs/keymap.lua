-- -----------------------------------------------------------------------------
-- Custom general key bindins
-- n:normal / i:insert / v:visual+select / x:visual / s:select / c:cmd / o:op
-- -----------------------------------------------------------------------------

vim.g.mapleader = '-'

vim.keymap.set('n', '<leader>vo', ':vsplit $MYVIMRC<CR>')
vim.keymap.set('n', '<leader>vs', ':source $MYVIMRC<CR>')

vim.keymap.set('n', '<leader>sf', ':setlocal spelllang=CA_fr<CR>')
vim.keymap.set('n', '<leader>se', ':setlocal spelllang=CA_en<CR>')

vim.keymap.set('n', '<leader>a', ':set paste<CR>')
vim.keymap.set('n', '<leader>aa', ':set nopaste<CR>')

vim.keymap.set('n', '<F2>', ':set spell<CR>')
vim.keymap.set('n', '<F3>', ':set nospell<CR>')

