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
require("plugins.glow")
require("plugins.gitsigns")
require("plugins.lspconfig")
require("plugins.lualine")
require("plugins.mason")
require("plugins.nvim_autopairs")
require("plugins.nvimtree")
require("plugins.project_nvim")
require("plugins.telescope")
require("plugins.todocomments")
require("plugins.trouble")
require("plugins.treesitter")

