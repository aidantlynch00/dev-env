local aerial = require("aerial")

local winid = nil
function AerialToggle()
    if winid ~= nil then
        vim.api.nvim_win_close(winid, true)
        winid = nil
    else
        aerial.toggle({ focus = true })
        winid = vim.api.nvim_get_current_win()
        vim.cmd("wincmd L")
    end
end

aerial.setup({
    placement = "edge",
    default_direction = "right",
    attach_mode = "global",
    filter_kind = false,
    show_guides = true,
})
