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

vim.keymap.set("n", "<A-z>", "<CMD>set wrap!<CR>")

vim.api.nvim_create_user_command("ConvertTabToSpace", "%s/\t/  /g", {})
-- vim.keymap.set('n', '<leader>x',function ()
--   bufnr = api.nvim_get_current_buf()
--
-- end)

-- vim.cmd( [[ set formatoptions-=ro ]])

if vim.g.neovide then
  vim.g.neovide_input_macos_alt_is_meta = true
  -- Helper function for transparency formatting
  local alpha = function()
    return string.format("%x", math.floor(255 * (vim.g.neovide_transparency or 0.8)))
  end
  -- g:neovide_transparency should be 0 if you want to unify transparency of content and title bar.
  vim.g.neovide_transparency = 0.4
  vim.g.transparency = 0.8
  vim.g.neovide_background_color = "#282828" .. alpha()
  -- Add keybinds to change transparency
  local change_transparency = function(delta)
    vim.g.neovide_transparency = vim.g.neovide_transparency + delta
    -- vim.g.transparency = vim.g.transparency + delta
    vim.g.neovide_background_color = "#282828" .. alpha()
  end
  vim.keymap.set({ "n", "v", "o" }, "<D-]>", function()
    change_transparency(0.1)
  end)
  vim.keymap.set({ "n", "v", "o" }, "<D-[>", function()
    change_transparency(-0.1)
  end)
end

if vim.g.neovide then
  vim.g.neovide_input_use_logo = 1 -- enable use of the logo (cmd) key
  vim.keymap.set("n", "<D-s>", ":w<CR>") -- Save
  vim.keymap.set("v", "<D-c>", '"+y') -- Copy
  vim.keymap.set("n", "<D-v>", '"+P') -- Paste normal mode
  vim.keymap.set("v", "<D-v>", '"+P') -- Paste visual mode
  vim.keymap.set("c", "<D-v>", "<C-R>+") -- Paste command mode
  vim.keymap.set("i", "<D-v>", '<ESC>l"+Pli') -- Paste insert mode

  vim.g.neovide_scale_factor = 1.0
  local change_scale_factor = function(delta)
    vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
  end
  vim.keymap.set("n", "<D-=>", function()
    change_scale_factor(1.1)
  end)
  vim.keymap.set("n", "<D-->", function()
    change_scale_factor(1 / 1.1)
  end)
end

-- Allow clipboard copy paste in neovim
vim.g.neovide_input_use_logo = 1
vim.api.nvim_set_keymap("", "<D-v>", "+p<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("!", "<D-v>", "<C-R>+", { noremap = true, silent = true })
vim.api.nvim_set_keymap("t", "<D-v>", "<C-R>+", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<D-v>", "<C-R>+", { noremap = true, silent = true })

require("plugins")
