local lang_servers = {
    ["rust_analyzer"] = {},
    ["clangd"] = {},
    ["lua_ls"] = {},
    ["bashls"] = {},
    ["ts_ls"] = {},
    ["html"] = {},
    ["cssls"] = {},
}

require("mason").setup()
require("mason-lspconfig").setup {
    ensure_installed = lang_servers,
    automatic_installation = true
}

-- configure coq
vim.g.coq_settings = {
    auto_start = "shut-up",
    display = {
        pum = {
            fast_close = false
        }
    }
}

local lsp = require("lspconfig")
local coq = require("coq")
for lang_server, settings in pairs(lang_servers) do
    lsp[lang_server].setup(coq.lsp_ensure_capabilities(settings))
end

vim.cmd("COQnow -s")
