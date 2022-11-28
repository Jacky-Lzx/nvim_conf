-- empty setup using defaults
require("nvim-tree").setup()

vim.keymap.set('n', '<C-n>', '<CMD> NvimTreeToggle <CR>')
-- vim.keymap.set('n', '<leader>e', '<CMD> NvimTreeFocus <CR>')
vim.keymap.set('n', '<leader>e', '<CMD> NvimTreeToggle <CR>')
