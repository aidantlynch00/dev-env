vim.g.mapleader = " "
vim.keymap.set("n", "<leader>fd", vim.cmd.Ex)

-- set up telescope mappings
local builtin = require("telescope.builtin")
local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<leader>ff", builtin.find_files, opts)
vim.keymap.set("n", "<leader>fg", builtin.live_grep, opts)
vim.keymap.set("n", "<leader>fr", builtin.lsp_references, opts)
vim.keymap.set("n", "<leader>fb", builtin.buffers, opts)
vim.keymap.set("n", "<leader>fh", builtin.help_tags, opts)


-- set up LSP mappings
vim.keymap.set("n", "<leader>h", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
vim.keymap.set("n", "<leader>gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
vim.keymap.set("n", "<leader>gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
vim.keymap.set("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
