local neotree = require("neo-tree.command");

local winid = nil
function NeotreeToggle()
    if winid ~= nil then
        neotree.execute({ action = "close" })
    else
        neotree.execute({ reveal = true })
    end
end

local handle_open = function(args)
    winid = args.winid
end

local handle_close = function(args)
    winid = nil
end

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
    event_handlers = {
        {
            event = "neo_tree_window_after_open",
            handler = handle_open,
        },
        {
            event = "neo_tree_window_after_close",
            handler = handle_close,
        },
    },
}
