local languages = {
    "c",
    "cpp",
    "c_sharp",
    "rust",
    "lua",
    "bash",
    "python",
    "javascript",
    "html",
    "css",
    "make",
    "xml",
    "json",
    "csv",
    "markdown",
}

require("arborist").setup({
    update_cadence = "weekly",
    install_popular = false,
    ensure_installed = languages,
})
