-- -----------------------------------------------------------------------------
-- EditorConfig plugin
-- https://editorconfig.org
-- https://github.com/editorconfig/editorconfig-vim
-- -----------------------------------------------------------------------------

print("Loading plugin: editorconfig")

-- For compatibility with vim-fugitive
vim.g.EditorConfig_exclude_patterns = {"fugitive://.*"}

