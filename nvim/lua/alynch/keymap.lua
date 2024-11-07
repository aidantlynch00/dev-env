-- global
local opts = { noremap = true, silent = true }
vim.g.mapleader = " "

local map = vim.keymap.set

-- set up Neotree binding
map("n", "<leader>ls", Neotree, opts)

-- set up telescope mappings
local telescope = require("telescope")
local builtin = require("telescope.builtin")
map("n", "<leader>ff", builtin.find_files, opts)
map("n", "<leader>fg", builtin.live_grep, opts)
map("n", "<leader>fr", builtin.lsp_references, opts)
map("n", "<leader>fb", builtin.buffers, opts)
map("n", "<leader>fh", builtin.help_tags, opts)
map("n", "<leader>fw", builtin.grep_string, opts)
map("n", "<leader>fm", Harpoon, opts)
map("n", "<leader>fs", telescope.extensions.aerial.aerial, opts)

-- set up harpoon mappings
local harpoon = require("harpoon")
map("n", "<leader>ma", function() harpoon:list():add() end, opts)
map("n", "<leader>mn", function() harpoon:list():next() end, opts)
map("n", "<leader>mp", function() harpoon:list():prev() end, opts)

for i=1,9 do
    map("n", "<leader>" .. i, function() harpoon:list():select(i) end, opts)
    map("n", "<leader>md" .. i, function() harpoon:list():remove_at(i) end, opts)
end

map("n", "<leader>mda", function() harpoon:list():clear() end, opts)

-- set up LSP mappings
map("n", "<leader>h", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
map("n", "<leader>gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
map("n", "<leader>gl", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
map("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)

-- set up aerial mapping
map("n", "<leader>st", "<cmd>AerialToggle<CR>", opts)

-- set up genAI mappings
map({ "n", "v" }, "<leader>ag", "<cmd>Gen<CR>", opts)
map("n", "<leader>ac", "<cmd>Gen Chat<CR>", opts)
