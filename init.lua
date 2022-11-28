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

vim.keymap.set('i', '<C-h>', '<Left>')
vim.keymap.set('i', '<C-l>', '<Right>')
vim.keymap.set('i', '<C-j>', '<Down>')
vim.keymap.set('i', '<C-k>', '<Up>')

vim.keymap.set('n', '<C-h>', '<C-w>h')
vim.keymap.set('n', '<C-l>', '<C-w>l')
vim.keymap.set('n', '<C-j>', '<C-w>j')
vim.keymap.set('n', '<C-k>', '<C-w>k')



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
--
require("plugins")
