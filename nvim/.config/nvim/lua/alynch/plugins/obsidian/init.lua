local success, workspaces = pcall(require, "alynch.plugins.obsidian.workspaces")
if not success then
    workspaces = {}
end

if not vim.tbl_isempty(workspaces) then
    require("obsidian").setup({
        legacy_commands = false,
        ui = {
            enable = false
        },
        picker = {
            name = "telescope.nvim",
        },
        workspaces = workspaces,
    })
end
