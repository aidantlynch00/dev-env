local coq = require("coq")
local mason = require("mason")
local lspconfig = require("mason-lspconfig")

-- disable LSP diagnostic underlines
local default_diagnostic_settings = {
    underline = false,
    virtual_text = true,
}

local servers = {
    ["rust_analyzer"] = {
        install = false,
        settings = concat_tables({
            command = { "rust-analyzer" },
        }, default_diagnostic_settings),
    },
    ["clangd"] = {
        install = false,
        settings = concat_tables({
            cmd = { "clangd" },
        }, default_diagnostic_settings),
    },
    ["lua_ls"] = {
        automatic_enable = false,
    },
    ["bashls"] = { },
    ["ts_ls"] = { },
    ["html"] = { },
    ["cssls"] = { },
    ["roslyn_ls"] = { },
}

local servers_to_install = { }
local servers_to_exclude = { }
for server, options in pairs(servers) do
    local install = options.install
    if install == nil then
        install = true
    end

    if install then
        table.insert(servers_to_install, server)
    end

    local automatic_enable = options.automatic_enable
    if automatic_enable == nil then
        automatic_enable = true
    end

    if not automatic_enable then
        table.insert(servers_to_exclude, server)
    end
end

mason.setup()
lspconfig.setup {
    ensure_installed = servers_to_install,
    automatic_installation = true,
    automatic_enable = {
        exclude = servers_to_exclude
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

vim.diagnostic.config(default_diagnostic_settings)

vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics,
    default_diagnostic_settings
)

for server, options in pairs(servers) do
    if vim.tbl_isempty(options) then
        options = {
            settings = default_diagnostic_settings
        }
    end

    vim.lsp.enable(server, coq.lsp_ensure_capabilities(options))
end

vim.cmd("COQnow -s")
