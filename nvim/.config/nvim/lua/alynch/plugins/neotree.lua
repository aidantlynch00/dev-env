require("neo-tree").setup {
    filesystem = {
        filtered_items = {
            visible = true,
            hide_gitignored = true,
            never_show_by_pattern = {
                "*/.git",
            },
        },
    },
}

local neotree = require("neo-tree.command");
local toggle = false

function NeotreeToggle()
    if toggle then
        neotree.execute({ action = "close" })
    else
        neotree.execute({ reveal = true })
    end

    toggle = not toggle
end

