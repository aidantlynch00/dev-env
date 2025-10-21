require("nvim-treesitter.configs").setup {
    ensure_installed = {
        "c", "cpp", "rust",      -- compiled languages
        "lua", "bash", "python", -- scripting languages
        "html", "css",           -- web languages
        "make",                  -- tooling
        "xml", "json", "csv",    -- data formats
        "markdown"               -- text formats
    },
    highlight = {
        enable = true
    }
}
