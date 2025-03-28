-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

vim.opt.number = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = false

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.clipboard = ""

-- vim.g.python3_host_prog = "~/.pyenv/versions/neovim3/bin/python"

-- vim.opt.formatoptions:remove { "r", "o" }
vim.cmd([[ autocmd FileType * set formatoptions-=ro ]])

require("vscode_setting.plugins_vscode")

require("keymapping")
