-- set filetype xml for extension .axaml
vim.api.nvim_create_autocmd('BufRead', {
    desc = 'set xml filetype for axaml',
    pattern = '*.axaml',
    callback = function() vim.bo.filetype = 'xml' end,
})
