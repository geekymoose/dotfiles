-- -----------------------------------------------------------------------------
-- NERDTree plugin
-- https://github.com/preservim/nerdtree
-- -----------------------------------------------------------------------------

vim.g.NERDTreeShowHidden = 1
vim.g.NERDTreeAutoCenter = 1

vim.keymap.set('n', '<F5>', ':NERDTreeRefreshRoot<CR>')
vim.keymap.set('n', '<F6>', ':NERDTreeToggle<CR>')
vim.keymap.set('n', '<F7>', ':NERDTree<CR>')
vim.keymap.set('n', '<F8>', ':NERDTreeFind<CR>')

