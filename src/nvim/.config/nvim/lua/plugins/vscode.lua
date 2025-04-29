-- -----------------------------------------------------------------------------
-- VSCode theme
-- https://github.com/mofiqul/vscode.nvim
-- -----------------------------------------------------------------------------

local vscode = require("vscode")
local vscode_colors = require("vscode.colors")

vscode_colors.get_colors()

vscode.setup({
    transparent = true,             -- Enable transparent background
    italic_comments = true,         -- Enable italic comment
    underline_links = true,         -- Underline `@markup.link.*` variants
    disable_nvimtree_bg = true,     -- Disable nvim-tree background color
})

vscode.load('dark')

