local lang_servers = { "rust_analyzer", "clangd", "lua_ls", "bashls", "ts_ls", "html", "cssls" }

require("mason").setup()
require("mason-lspconfig").setup {
    ensure_installed = lang_servers,
    automatic_installation = true,
    automatic_enable = {
        exclude = { "luals" }
    },
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

-- disable LSP diagnostic underlines
local diagnostic_opts = {
    underline = false,
    virtual_text = true,
}

vim.diagnostic.config(diagnostic_opts)

vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics,
    diagnostic_opts
)

local lsp = require("lspconfig")
local coq = require("coq")
for _, lang_server in pairs(lang_servers) do
    lsp[lang_server].setup(coq.lsp_ensure_capabilities({
        settings = diagnostic_opts
    }))
end

vim.cmd("COQnow -s")
