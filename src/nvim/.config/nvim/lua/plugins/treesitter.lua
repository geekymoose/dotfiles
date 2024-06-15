-- -----------------------------------------------------------------------------
-- Syntax highlight with Treesitter
-- https://github.com/nvim-treesitter/nvim-treesitter
--
-- See :h nvim-treesitter
-- -----------------------------------------------------------------------------

require ("nvim-treesitter.configs").setup {
    -- Parser to always install (or "all")
    ensure_installed = {
        "bash",
        "c",
        "c_sharp",
        "cmake",
        "cpp",
        "html",
        "http",
        "java",
        "javascript",
        "json",
        "lua",
        "luadoc",
        "make",
        "markdown",
        "query",
        "rust",
        "typescript",
        "vim",
        "vimdoc",
    },

    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,

    -- Automatically install missing parsers when entering buffer
    -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
    auto_install = true,

    highlight = {
        enable = true,

        -- Disable slow treesitter highlight for large files
        disable = function(lang, buf)
            local max_filesize = 100 * 1024 -- 100 KB
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
                return true
            end
        end,

        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false,
    },
}

