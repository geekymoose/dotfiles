-- -----------------------------------------------------------------------------
-- The NeoVim lua configuration file
-- $HOME/.confg/nvim/init.lua
-- https://neovim.io/doc/user/lua-guide.html
-- -----------------------------------------------------------------------------

-- Load custom configs
require("configs.basics")
require("configs.keymap")

-- Load init plugins
require("plugins.plug")
require("plugins.vscode")

-- Load all plugins
require("plugins.editorconfig")
require("plugins.lspconfig")
require("plugins.lualine")
require("plugins.nvimtree")
require("plugins.telescope")
require("plugins.treesitter")

require("gitsigns").setup()
require("nvim-autopairs").setup()

