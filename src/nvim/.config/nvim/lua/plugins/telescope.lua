-- -----------------------------------------------------------------------------
-- https://github.com/nvim-telescope/telescope.nvim
-- https://github.com/nvim-telescope/telescope-fzf-native.nvim
-- -----------------------------------------------------------------------------

print("Loading plugin: telescope")

local telescope = require("telescope");
local action_layout = require("telescope.actions.layout")

telescope.setup({
    defaults = {
        layout_strategy = "horizontal",
        layout_config = {
            height = 0.99,
            width = 0.99,
        },
        file_ignore_patterns = {
            -- By default, things in .gitignore are also ignored
            "^extern/",
            "^./extern/",
            "^external/",
            "^./external/",
            "^build/",
            "^LICENSE*",
        },
        vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--ignore-case",
        },
    },
    extensions = {
        fzf = {
            fuzzy = true,                    -- false will only do exact matching
            override_generic_sorter = true,  -- override the generic sorter
            override_file_sorter = true,     -- override the file sorter
            case_mode = "smart_case",
        },
        media_files = {
            filetypes = {"png", "webm", "webp", "jpg", "jpeg", "pdf"},
            find_cmd = "rg",
        }
    },
})

telescope.load_extension('fzf')
telescope.load_extension('media_files')

