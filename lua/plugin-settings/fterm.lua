require'FTerm'.setup({
    border = 'double',
    dimensions  = {
        height = 0.9,
        width = 0.9,
    },
})

-- Example keybindings
vim.keymap.set('n', '<C-i>', '<CMD>lua require("FTerm").toggle()<CR>')
vim.keymap.set('t', '<C-i>', '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>')

vim.api.nvim_create_user_command('FTermToggle', require('FTerm').toggle, { bang = true })

vim.keymap.set('n', '<A-i>', function() require("FTerm").toggle() end)
vim.keymap.set('t', '<A-i>', function() require("FTerm").toggle() end)
