require("leap").add_default_mappings()

vim.keymap.del({ "n", "x", "o" }, "s")
vim.keymap.del({ "n", "x", "o" }, "S")
vim.keymap.del({ "x", "o" }, "x")
vim.keymap.del({ "x", "o" }, "X")

vim.keymap.set({ "n", "x", "o" }, "<leader>s", "<Plug>(leap-forward-to)")
vim.keymap.set({ "n", "x", "o" }, "<leader>S", "<Plug>(leap-backward-to)")

-- vim.keymap.set({ "n", "x", "o" }, "<leader>x", "<Plug>(leap-forward-till)")
-- vim.keymap.set({ "n", "x", "o" }, "<leader>X", "<Plug>(leap-backward-till)")

vim.keymap.set({ "n", "x", "o" }, "<leader>gs", "<Plug>(leap-from-window)")
