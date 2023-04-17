--- From nvim-tree
-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true
--- End

vim.opt.number = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.clipboard = ""

vim.g.python3_host_prog = "~/.pyenv/versions/neovim3/bin/python"

-- vim.opt.formatoptions:remove { "r", "o" }
vim.cmd([[ autocmd FileType * set formatoptions-=ro ]])

require("plugins_vscode")

require("keymapping")
