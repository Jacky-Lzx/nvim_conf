require("plugins")

-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

vim.opt.number = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true


vim.o.background = "dark" -- or "light" for light mode
vim.cmd([[colorscheme gruvbox]])

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.wo.wrap = false

vim.bo.tabstop = 2

-- vim.wo.cursorline = true

vim.opt.clipboard = ""

local hop = require('hop')
local directions = require('hop.hint').HintDirection

vim.keymap.set({ 'n', 'v' }, '<leader>f', function()
  hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
end, { remap = true })

vim.keymap.set({ 'n', 'v' }, '<leader>s', function()
  -- hop.hint_char2({current_line_only = false})
  hop.hint_char2()
end, { remap = true })

-- :HopLine
vim.keymap.set({ 'n', 'v' }, '<leader>j', function()
  hop.hint_lines({ direction = directions.AFTER_CURSOR, current_line_only = false })
end, { remap = true })

vim.keymap.set({ 'n', 'v' }, '<leader>k', function()
  hop.hint_lines({ direction = directions.BEFORE_CURSOR, current_line_only = false })
end, { remap = true })

vim.keymap.set({ 'n', 'v' }, '<leader>j', function()
  hop.hint_lines({ current_line_only = false })
end, { remap = true })

vim.keymap.set({ 'n', 'v' }, '<leader>k', function()
  hop.hint_lines({ current_line_only = false })
end, { remap = true })

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
--
-- Example keybindings
vim.keymap.set('n', '<C-i>', '<CMD>lua require("FTerm").toggle()<CR>')
vim.keymap.set('t', '<C-i>', '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>')

vim.api.nvim_create_user_command('FTermToggle', require('FTerm').toggle, { bang = true })



vim.keymap.set('n', '<C-n>', '<CMD> NvimTreeToggle <CR>')
vim.keymap.set('n', '<leader>e', '<CMD> NvimTreeFocus <CR>')


vim.keymap.set('i', '<C-h>', '<Left>')
vim.keymap.set('i', '<C-l>', '<Right>')
vim.keymap.set('i', '<C-j>', '<Down>')
vim.keymap.set('i', '<C-k>', '<Up>')

vim.keymap.set('n', '<C-h>', '<C-w>h')
vim.keymap.set('n', '<C-l>', '<C-w>l')
vim.keymap.set('n', '<C-j>', '<C-w>j')
vim.keymap.set('n', '<C-k>', '<C-w>k')


vim.keymap.set('n', '<leader>/', function () require("Comment.api").toggle.linewise.current() end)
vim.keymap.set('v', '<leader>/', '<ESC><CMD>lua require("Comment.api").toggle.linewise(vim.fn.visualmode())<CR>')

vim.keymap.set('n', '<A-i>', function() require("FTerm").toggle() end)
vim.keymap.set('t', '<A-i>', function() require("FTerm").toggle() end)


vim.keymap.set('n', '<TAB>', '<CMD>TablineBufferNext<CR>')
vim.keymap.set('n', '<S-TAB>', '<CMD>TablineBufferPrevious<CR>')

  --   ["<TAB>"] = {
  --     function()
  --       require("nvchad_ui.tabufline").tabuflineNext()
  --     end,
  --     "goto next buffer",
  --   },
  --
  --   ["<S-Tab>"] = {
  --     function()
  --       require("nvchad_ui.tabufline").tabuflinePrev()
  --     end,
  --     "goto prev buffer",
  --   },
  --
  --   -- pick buffers via numbers
  --   ["<Bslash>"] = { "<cmd> TbufPick <CR>", "Pick buffer" },
  --
  --   -- close buffer + hide terminal buffer
  --   ["<leader>x"] = {
  --     function()
  --       require("nvchad_ui.tabufline").close_buffer()
  --     end,
  --     "close buffer",
  --   },
  -- },
  --

-- vim.keymap.set('n', '<leader>x',function ()
--   bufnr = api.nvim_get_current_buf()
--
-- end)
