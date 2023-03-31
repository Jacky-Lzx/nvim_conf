require("hop").setup()
local hop = require("hop")

-- local directions = require("hop.hint").HintDirection

-- vim.keymap.set({ 'n', 'v' }, '<leader>f', function()
--   hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
-- end, { remap = true })

-- vim.keymap.set({ 'n', 'v' }, '<leader>s', function()
--   -- hop.hint_char2({current_line_only = false})
--   hop.hint_char2()
-- end, { remap = true })

-- :HopLine
-- vim.keymap.set({ "n", "v" }, "<leader>j", function()
-- 	hop.hint_lines({ direction = directions.AFTER_CURSOR, current_line_only = false })
-- end, { remap = true })

-- vim.keymap.set({ "n", "v" }, "<leader>k", function()
-- 	hop.hint_lines({ direction = directions.BEFORE_CURSOR, current_line_only = false })
-- end, { remap = true })

vim.keymap.set({ "n", "v" }, "<leader>j", function()
	hop.hint_lines({ current_line_only = false })
end, { remap = true })

vim.keymap.set({ "n", "v" }, "<leader>k", function()
	hop.hint_lines({ current_line_only = false })
end, { remap = true })
