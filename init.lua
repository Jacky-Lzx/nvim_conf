--- From nvim-tree
-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true
--- End

require("impatient")

vim.opt.number = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.wo.wrap = false

vim.bo.tabstop = 2

vim.wo.cursorline = true

vim.opt.clipboard = ""

vim.g.python3_host_prog = "~/.pyenv/versions/neovim3/bin/python"

-- vim.opt.formatoptions:remove { "r", "o" }
vim.cmd([[ autocmd FileType * set formatoptions-=ro ]])

-- vim.keymap.set('v', '<leader>/', function()
--   vim.api.nvim_exec([[
--     call VSCodeNotifyVisual('editor.action.commentLine', 1)
--   ]], false)
-- end)
--
-- vim.keymap.set('v', '<C-/>', function()
--   vim.api.nvim_exec([[
--     call VSCodeNotifyVisual('editor.action.commentLine', 1)
--   ]], false)
-- end)

vim.keymap.set("i", "<C-h>", "<Left>")
vim.keymap.set("i", "<C-l>", "<Right>")
vim.keymap.set("i", "<C-j>", "<Down>")
vim.keymap.set("i", "<C-k>", "<Up>")

vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-l>", "<C-w>l")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")

vim.keymap.set("n", "n", "nzz")
vim.keymap.set("n", "N", "Nzz")

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

vim.keymap.set("n", "<S-H>", "^")
vim.keymap.set("n", "<S-L>", "$")

-- vim.keymap.set("n", "//", "<CMD>:set hlsearch!<CR>")
vim.keymap.set("n", "//", "<CMD>:noh<CR>")

vim.keymap.set("n", "<C-q>", "<CMD>:qa<CR>")
vim.keymap.set("n", "qq", "<CMD>:q<CR>")
vim.keymap.set("n", "Q", "<CMD>:q<CR>")

vim.api.nvim_create_user_command("ConvertTabToSpace", "%s/\t/  /g", {})
-- vim.keymap.set('n', '<leader>x',function ()
--   bufnr = api.nvim_get_current_buf()
--
-- end)

-- vim.cmd( [[ set formatoptions-=ro ]])

require("plugins")
