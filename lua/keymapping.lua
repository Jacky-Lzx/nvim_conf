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

-- vim.keymap.set("n", "<C-d>", "<C-d>zz")
-- vim.keymap.set("n", "<C-u>", "<C-u>zz")

vim.keymap.set({ "n", "x" }, "<S-H>", "^", { desc = "start of line" })
vim.keymap.set({ "n", "x" }, "<S-L>", "$", { desc = "end of line" })
vim.keymap.set("n", "y<S-H>", "y^", { desc = "yank from start of line" })
vim.keymap.set("n", "y<S-L>", "y$", { desc = "yank to end of line" })

-- vim.keymap.set("n", "//", "<CMD>:set hlsearch!<CR>")
vim.keymap.set("n", "//", "<CMD>:noh<CR>")

vim.keymap.set("n", "Q", "<CMD>:qa<CR>")
vim.keymap.set("n", "qq", "<CMD>:q<CR>")
-- vim.keymap.set("n", "Q", "<CMD>:q<CR>")

vim.keymap.set("n", "<A-z>", "<CMD>set wrap!<CR>")

vim.keymap.set("v", "<M-m>", 'c\\( <c-r>" \\)')
vim.keymap.set("i", "<M-m>", "\\(  \\)<esc>hhi")

vim.api.nvim_create_user_command("ConvertTabToSpace", "%s/\t/  /g", {})
