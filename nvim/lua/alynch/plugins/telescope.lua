local telescope = require("telescope")
local actions = require("telescope.actions")

telescope.setup {
    defaults = {
        history = {
            limit = 20,
            mappings = {
                i = {
                    ["<C-[>"] = actions.cycle_history_prev,
                    ["<C-]>"] = actions.cycle_history_next
                },
                n = {
                    ["["] = actions.cycle_history_prev,
                    ["]"] = actions.cycle_history_next
                },
            }
        }
    },
    extensions = {
        fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true
        }
    },
}

telescope.load_extension("fzf")
telescope.load_extension("aerial")
