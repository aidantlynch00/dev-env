local telescope = require("telescope")
local actions = require("telescope.actions")

telescope.setup {
    defaults = {
        layout_strategy = "vertical",
        layout_config = {
            anchor = "N",
            width = 0.60,
            height = 0.75,
            scroll_speed = 3,
        },
        mappings = {
            i = {
                ["<C-D>"] = false,
                ["<C-U>"] = false,
                ["<C-E>"] = actions.preview_scrolling_down,
                ["<C-Y>"] = actions.preview_scrolling_up,
            },
        },
    },
    pickers = {
        buffers = {
            mappings = {
                i = {
                    ["<C-D>"] = actions.delete_buffer
                },
            },
        },
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
