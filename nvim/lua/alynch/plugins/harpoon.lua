local harpoon = require("harpoon")

harpoon:setup({})

-- set up telescope support
local telescope_conf = require("telescope.config").values
function Harpoon()
    local file_paths = {}
    for _, item in ipairs(harpoon:list().items) do
        table.insert(file_paths, item.value)
    end

    require("telescope.pickers").new({}, {
        prompt_title = "Harpoon",
        finder = require("telescope.finders").new_table({ results = file_paths }),
        previewer = telescope_conf.file_previewer({}),
        sorter = telescope_conf.generic_sorter({}),
    }):find()
end
