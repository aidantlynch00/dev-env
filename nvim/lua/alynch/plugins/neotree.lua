local neotree = require("neo-tree.command");
local toggle = false

function Neotree ()
    if toggle then
        neotree.execute({ action = "close" })
    else
        neotree.execute({ reveal = true })
    end

    toggle = not toggle
end

