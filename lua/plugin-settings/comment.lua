require('Comment').setup()

vim.keymap.set('n', '<leader>/', function () require("Comment.api").toggle.linewise.current() end)
vim.keymap.set('v', '<leader>/', '<ESC><CMD>lua require("Comment.api").toggle.linewise(vim.fn.visualmode())<CR>')
