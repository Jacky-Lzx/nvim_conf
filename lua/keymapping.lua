vim.keymap.set("i", "<C-h>", "<Left>")
vim.keymap.set("i", "<C-l>", "<Right>")
vim.keymap.set("i", "<C-j>", "<Down>")
vim.keymap.set("i", "<C-k>", "<Up>")

vim.keymap.set("i", "jk", "<Esc>")

vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-l>", "<C-w>l")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")

-- Defined at `nvim-hlslens`
-- vim.keymap.set({ "n", "v" }, "n", "nzz", { noremap = true, desc = "Next search" })
-- vim.keymap.set({ "n", "v" }, "N", "Nzz", { noremap = true, desc = "Previous search" })
-- vim.keymap.set("n", "<C-d>", "<C-d>zz")
-- vim.keymap.set("n", "<C-u>", "<C-u>zz")
-- vim.keymap.set("n", "//", "<CMD>:set hlsearch!<CR>")
-- vim.keymap.set("n", "//", "<CMD>:noh<CR>", { desc = "Clear search highlight" })

vim.keymap.set({ "n", "x", "o" }, "<S-H>", "^", { desc = "Start of line" })
vim.keymap.set({ "n", "x", "o" }, "<S-L>", "$", { desc = "End of line" })

vim.keymap.set({ "n", "x" }, "Q", "<CMD>:qa<CR>")
vim.keymap.set({ "n", "x" }, "qq", "<CMD>:q<CR>")
-- vim.keymap.set("n", "Q", "<CMD>:q<CR>")

vim.keymap.set("n", "<A-z>", "<CMD>set wrap!<CR>", { desc = "Toggle line wrap" })
vim.keymap.set("n", "<A-u>", "<NOP>", { desc = "Disabled" })
vim.keymap.set("n", "<A-d>", "<NOP>", { desc = "Disabled" })

vim.keymap.set("v", "<M-m>", 'c\\( <c-r>" \\)')
vim.keymap.set("i", "<M-m>", "\\(  \\)<esc>hhi")

vim.api.nvim_create_user_command("ConvertTabToSpace", "%s/\t/  /g", {})

vim.keymap.set({ "i", "n" }, "<M-m>", function()
  local is_inside = vim.api.nvim_eval("vimtex#syntax#in_mathzone()")
  require("snacks.debug").inspect(is_inside)
end, { desc = "test" })
