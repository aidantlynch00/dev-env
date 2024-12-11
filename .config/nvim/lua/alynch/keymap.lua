-- global
local opts = { noremap = true, silent = true }
vim.g.mapleader = " "

local map = function(modes, map, fn)
    vim.keymap.set(modes, map, fn, opts)
end

-- I don't like hitting the Ctrl key so allow <leader>w to be used in place of
-- Ctrl-w for window mappings
map({ "n", "v" }, "<leader>w", "<C-w>")
map({ "n", "v" }, "<leader>w", "<C-w>")
map({ "n", "v" }, "<leader>wf", FindFloatingInTab)

-- set up Neotree binding
map("n", "<leader>ls", NeotreeToggle)

-- set up telescope mappings
local telescope = require("telescope")
local builtin = require("telescope.builtin")
map("n", "<leader>ff", builtin.find_files)
map("n", "<leader>fg", builtin.live_grep)
map("n", "<leader>fr", builtin.lsp_references)
map("n", "<leader>fd", builtin.diagnostics)
map("n", "<leader>fb", builtin.buffers)
map("n", "<leader>fh", builtin.help_tags)
map("n", "<leader>fw", builtin.grep_string)
map("n", "<leader>fs", telescope.extensions.aerial.aerial)
map("n", "<leader>fn", "<cmd>NoteTelescope<CR>")
map("n", "<leader>tr", builtin.resume)

-- set up harpoon mappings
local harpoon = require("harpoon")
map("n", "<leader>ma", function() harpoon:list():add() end)
map("n", "<leader>fm", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

for i=1,9 do
    map("n", "<leader>" .. i, function() harpoon:list():select(i) end)
end

map("n", "<leader>mda", function() harpoon:list():clear() end)

-- annotations
map("n", "<leader>no", "<cmd>NoteCreate<CR>")
map("n", "<leader>nd", "<cmd>NoteDelete<CR>")

-- set up LSP mappings
map("n", "<leader>h", "<cmd>lua vim.lsp.buf.hover()<CR>")
map("n", "<leader>gd", "<cmd>lua vim.lsp.buf.definition()<CR>")
map("n", "<leader>gl", "<cmd>lua vim.lsp.buf.declaration()<CR>")
map("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>")

-- set up aerial mapping
map("n", "<leader>st", "<cmd>AerialToggle!<CR>")

-- set up local LLM mapping
map("n", "<leader>aa", "<cmd>Telescope codecompanion<CR>")

-- chat mapping
local codecompanion = require("codecompanion")
map({ "n", "v" }, "<leader>ac", "<cmd>CodeCompanionChat Toggle<CR>")

-- code generation mapping
map({ "n", "v" }, "<leader>ap", function()
    local prompt = vim.fn.input("Prompt: ")
    vim.cmd("CodeCompanion " .. prompt)
end)

-- code review mapping
map("v", "<leader>ae", function() codecompanion.prompt("explain") end)
