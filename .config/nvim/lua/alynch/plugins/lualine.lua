require("lualine").setup {
    options = {
        theme = "tokyonight",
        section_separators = {
            left = "",
            right = ""
        },
    },
    sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch" },
        lualine_c = { "filename", "aerial" },
        lualine_x = { "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" }
    },
}
