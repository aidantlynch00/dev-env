local blink = require("blink.cmp")

blink.setup({
    keymap = {
        preset = "none",
        ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
        ["<Esc>"] = { "cancel", "fallback" },
        ["<BS>"] = { "fallback" },
        ["<CR>"] = { "accept", "fallback" },
        ["<Tab>"] = { "select_next", "fallback" },
        ["<S-Tab>"] = { "select_prev", "fallback" },
    },
    appearance = {
        nerd_font_variant = "mono",
    },
    completion = {
        documentation = { auto_show = false },
    },
    sources = {
        default = { "lsp", "path", "snippets", "buffer" },
    },
    fuzzy = {
        implementation = "prefer_rust_with_warning",
    },
})
