-- -----------------------------------------------------------------------------
-- https://github.com/nvim-telescope/telescope.nvim
-- https://github.com/nvim-telescope/telescope-fzf-native.nvim
-- -----------------------------------------------------------------------------

local telescope = require("telescope");

telescope.setup({
    defaults = {
        layout_strategy = "vertical",
        layout_config = {
            height = 0.95,
            width = 0.95,
        },
        file_ignore_patterns = {
            -- By default, things in .gitignore are also ignored
            "^extern/",
            "^./extern/",
            "^build/",
            "^LICENSE*",
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

