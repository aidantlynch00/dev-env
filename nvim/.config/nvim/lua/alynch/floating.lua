local wrapped_list = function(start, count)
    local list = {}
    for num = start + 1, count do
        table.insert(list, num)
    end

    for num = 1, start do
        table.insert(list, num)
    end

    return list
end

FindFloatingInTab = function()
    local curr_win_num = vim.fn.winnr()
    local win_count = vim.fn.winnr("$")
    local win_num_list = wrapped_list(curr_win_num, win_count)
    for _, win_num in ipairs(win_num_list) do
        win_id = vim.fn.win_getid(win_num)
        if vim.api.nvim_win_get_config(win_id).relative ~= "" then
            vim.fn.win_gotoid(win_id)
            return
        end
    end
end
