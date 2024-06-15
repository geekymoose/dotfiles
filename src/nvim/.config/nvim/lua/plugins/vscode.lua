-- -----------------------------------------------------------------------------
-- VSCode theme
-- https://github.com/Mofiqul/vscode.nvim
-- -----------------------------------------------------------------------------

require("vscode.colors").get_colors()

require("vscode").setup({
    transparent = true,             -- Enable transparent background
    italic_comments = true,         -- Enable italic comment
    underline_links = true,         -- Underline `@markup.link.*` variants
    disable_nvimtree_bg = true,     -- Disable nvim-tree background color
})

require("vscode").load()

vim.o.background = "dark"
vim.g.colorscheme = "vscode"

