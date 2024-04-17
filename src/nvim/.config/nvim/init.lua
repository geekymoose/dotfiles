-- -----------------------------------------------------------------------------
-- The NeoVim lua configuration file
-- $HOME/.confg/nvim/init.lua
-- https://neovim.io/doc/user/lua-guide.html
-- -----------------------------------------------------------------------------


vim.api.nvim_set_option('syntax', 'on')


-- Load custom configs
require("configs.keymap")


-- Load init plugins
require("plugins.plug")
require("plugins.vscode")


-- Load all plugins
require("plugins.editorconfig")
require("plugins.lspconfig")
require("plugins.lualine")
require("plugins.neogit")
require("plugins.nerdtree")
require("plugins.telescope")
require('gitsigns').setup()


-- General Utils options
vim.opt.mouse = 'a'                 -- Enable mouse in all modes
vim.opt.splitbelow = true           -- New split window is created below
vim.opt.clipboard = "unnamedplus"   -- Always use the clipboard for all operations


-- General display options
vim.opt.number = true               -- Display line number
vim.opt.cursorline = true           -- Hightlight current cursor line
vim.opt.ruler = true                -- Display line and column cursor
vim.opt.colorcolumn = "81"          -- 80 Char ruler
vim.opt.laststatus = 2              -- Always display status line

vim.opt.list = true                 -- Display special char (e.g., tab, whitespaces)
vim.opt.listchars = { trail = '.', tab = '|-', leadmultispace = '|...', nbsp = '~', extends = '>', precedes = '<' }


-- Tab / Whitechars
vim.opt.shiftwidth = 4              -- Tab size
vim.opt.tabstop = 4                 -- Number of spaces a tab takes
vim.opt.expandtab = true            -- Insert space instead of tab
vim.opt.smarttab = true             -- Tab in front of a line insert blanck
vim.opt.textwidth = 0               -- Unlimited text width
vim.opt.wrap = false                -- Don't wrap text if reach screen size


-- Indent
vim.opt.autoindent = true           -- Copy indent from current line when new line
vim.opt.breakindent = true          -- Wrapped line continue indented
vim.opt.smartindent = true          -- Smart autoindent when new line


-- Search / Pattern
vim.opt.ignorecase = true           -- Ignore uppercase
vim.opt.incsearch = true            -- Show matches while typing
vim.opt.hlsearch = true             -- Hightlight previous search
vim.opt.wildmenu = true             -- Pressing wildchar (TAB) invokes completion
vim.opt.showmatch = true            -- Show matching brace when insert one
vim.opt.matchtime = 1               -- Speed up brace matching time


-- Misc
-- filetype plugin on      -- Enable filetype and plugin detection
-- filetype indent on      -- Enable filetype and indent detection


