-- -----------------------------------------------------------------------------
-- The NeoVim lua configuration file
-- To place in $HOME/.confg/nvim/init.lua
-- https://neovim.io/doc/user/lua-guide.html
-- -----------------------------------------------------------------------------

if (vim.g.vscode) then
    print("Loading vscode only config (some native nvim plugin may be disabled)")
else
    print("Loading native nvim config")
end

-- Load init plugins
require("plugins.plug")
require("plugins.vscode")

-- Load global configs
require("configs.options")
require("configs.keymap")

-- Load all plugins
require("plugins.cmp")
require("plugins.editorconfig")
require("plugins.lspconfig")
require("plugins.lualine")
require("plugins.mason")
require("plugins.nvimtree")
require("plugins.todocomments")
require("plugins.telescope")
require("plugins.treesitter")

require("glow").setup({ style = "dark", width = 120, })
require("gitsigns").setup()
require("nvim-autopairs").setup()
require("project_nvim").setup()
require("trouble").setup()

