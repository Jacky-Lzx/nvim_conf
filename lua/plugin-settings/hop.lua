require("hop").setup()
local hop = require("hop")
local directions = require("hop.hint").HintDirection

-- vim.keymap.set({ 'n', 'v' }, '<leader>f', function()
--   hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
-- end, { remap = true })

-- vim.keymap.set({ 'n', 'v' }, '<leader>s', function()
--   -- hop.hint_char2({current_line_only = false})
--   hop.hint_char2()
-- end, { remap = true })

-- :HopLine
vim.keymap.set({ "n", "v" }, "<leader>j", function()
	hop.hint_lines({ direction = directions.AFTER_CURSOR, current_line_only = false })
end, { remap = true })

vim.keymap.set({ "n", "v" }, "<leader>k", function()
	hop.hint_lines({ direction = directions.BEFORE_CURSOR, current_line_only = false })
end, { remap = true })

vim.keymap.set({ "n", "v" }, "<leader>j", function()
	hop.hint_lines({ current_line_only = false })
end, { remap = true })

vim.keymap.set({ "n", "v" }, "<leader>k", function()
	hop.hint_lines({ current_line_only = false })
end, { remap = true })

-- Settings for Leap
require("leap").add_default_mappings()

vim.keymap.del({ "n", "x", "o" }, "s")
vim.keymap.del({ "n", "x", "o" }, "S")
vim.keymap.del({ "x", "o" }, "x")
vim.keymap.del({ "x", "o" }, "X")

vim.keymap.set({ "n", "x", "o" }, "<leader>s", "<Plug>(leap-forward-to)")
vim.keymap.set({ "n", "x", "o" }, "<leader>S", "<Plug>(leap-backward-to)")

vim.keymap.set({ "n", "x", "o" }, "<leader>x", "<Plug>(leap-forward-till)")
vim.keymap.set({ "n", "x", "o" }, "<leader>X", "<Plug>(leap-backward-till)")

vim.keymap.set({ "n", "x", "o" }, "<leader>gs", "<Plug>(leap-from-window)")
