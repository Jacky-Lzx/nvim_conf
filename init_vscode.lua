vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

vim.opt.number = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true


-- vim.keymap.set(
--     'n',
--     '<leader>t',
--     [[<Cmd>call VSCodeNotify('workbench.view.explorer')<CR>]]
-- )

require("plugins_vscode")
