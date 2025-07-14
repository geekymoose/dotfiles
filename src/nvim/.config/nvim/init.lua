-- -----------------------------------------------------------------------------
-- The NeoVim lua configuration file
-- To place in $HOME/.confg/nvim/init.lua
-- https://neovim.io/doc/user/lua-guide.html
-- -----------------------------------------------------------------------------

if (vim.g.vscode) then
    -- On vscode (NeoVim plugin), we don't load the custom settings
    return
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
require("plugins.gitsigns")
require("plugins.glow")
require("plugins.lspconfig")
require("plugins.lualine")
require("plugins.mason")
require("plugins.nvim_autopairs")
require("plugins.nvimtree")
require("plugins.project_nvim")
require("plugins.telescope")
require("plugins.todocomments")
require("plugins.treesitter")
require("plugins.trouble")
