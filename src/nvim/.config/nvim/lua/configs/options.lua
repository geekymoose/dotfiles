-- -----------------------------------------------------------------------------
-- General VIM configuration
-- -----------------------------------------------------------------------------

-- Theme
vim.opt.syntax = "on"
vim.opt.termguicolors = true -- Enable 23-bit RGB color in the TUI
vim.opt.background = "dark"  -- Adjust default color for background type
vim.cmd.colorscheme("kanagawa-wave")

-- Utilities
vim.opt.mouse = "a"               -- Enable mouse in all modes
vim.opt.splitbelow = true         -- New split window is created below
vim.opt.splitright = true         -- New vsplit window is created at right
vim.opt.clipboard = "unnamedplus" -- Always use the clipboard for all operations

-- Display
vim.opt.title = true                -- Dynamic update of the window title
vim.opt.titlestring = "%{getcwd()}" -- The dynamic window title (see :help statuline for options)
vim.opt.number = true               -- Display line number
vim.opt.cursorline = true           -- Highlight current cursor line
vim.opt.ruler = true                -- Display line and column cursor
vim.opt.colorcolumn = "81"          -- 80 Char ruler
vim.opt.laststatus = 2              -- Always display status line

-- Characters
vim.opt.list = true -- Display special char (e.g., tab, white-spaces)
vim.opt.listchars = { trail = ".", tab = "|-", leadmultispace = "|...", nbsp = "~", extends = ">", precedes = "<" }

-- Tab
vim.opt.shiftwidth = 4   -- Tab size
vim.opt.tabstop = 4      -- Number of spaces a tab takes
vim.opt.expandtab = true -- Insert space instead of tab
vim.opt.smarttab = true  -- Tab in front of a line insert blank
vim.opt.textwidth = 0    -- Unlimited text width
vim.opt.wrap = false     -- Don't wrap text if reach screen size

-- Search
vim.opt.ignorecase = true -- Ignore uppercase
vim.opt.incsearch = true  -- Show matches while typing
vim.opt.hlsearch = true   -- Highlight previous search

-- Brace
vim.opt.showmatch = true -- Show matching brace when insert one
vim.opt.matchtime = 1    -- Speed up brace matching time

-- Indent
vim.opt.autoindent = true  -- Copy indent from current line when new line
vim.opt.breakindent = true -- Wrapped line continue indented
vim.opt.smartindent = true -- Smart auto-indent when new line

-- Completion
vim.opt.wildmenu = true -- Pressing wildchar (TAB) invokes completion
vim.opt.completeopt = { "menuone", "noselect", "noinsert" }

-- Folding
vim.opt.foldenable = false                      -- By default, fold are opened
vim.opt.foldminlines = 20                       -- Min number of lines to displayed folded
vim.opt.foldnestmax = 3                         -- Maximum nesting for "indent" folding
vim.opt.foldmethod = "expr"                     -- Use custom folding method
vim.opt.foldexpr = "nvim_treesitter#foldexpr()" -- Use treesitter as the custom folding
