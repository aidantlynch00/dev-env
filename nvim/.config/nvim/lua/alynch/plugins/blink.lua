local blink = require("blink.cmp")

local cancel_cmp_and_enter_normal = function(cmp)
    cmp.cancel()
    vim.schedule(vim.cmd.stopinsert)
end

blink.setup({
    keymap = {
        preset = "none",
        ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
        ["<Esc>"] = { cancel_cmp_and_enter_normal },
        ["<BS>"] = { "fallback" },
        ["<CR>"] = { "accept", "fallback" },
        ["<Tab>"] = { "select_next", "fallback" },
        ["<S-Tab>"] = { "select_prev", "fallback" },
        ["<C-j>"] = { "select_next", "fallback" },
        ["<C-k>"] = { "select_prev", "fallback" },
    },
    appearance = {
        nerd_font_variant = "mono",
    },
    completion = {
        list = {
            selection = {
                preselect = false,
            },
        },
        documentation = {
            auto_show = false,
        },
        accept = {
            auto_brackets = {
                enabled = false,
            },
        },
    },
    sources = {
        default = { "lsp", "path", "snippets", "buffer" },
    },
    fuzzy = {
        implementation = "prefer_rust_with_warning",
    },
})
