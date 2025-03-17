-- removed
-- vim.g.neovide_input_macos_alt_is_meta = true

-- vim.g.neovide_input_macos_option_key_is_meta = "only_left"

-- vim.g.transparency = 0.2

-- Helper function for transparency formatting
local alpha = function()
  return string.format("%x", math.floor(255 * (vim.g.neovide_transparency or 0.8)))
end
-- g:neovide_transparency should be 0 if you want to unify transparency of content and title bar.
vim.g.neovide_transparency = 0.8
vim.g.transparency = 0.2
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

-- Allow clipboard copy paste in neovim
vim.g.neovide_input_use_logo = 1
vim.api.nvim_set_keymap("", "<D-v>", "+p<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("!", "<D-v>", "<C-R>+", { noremap = true, silent = true })
vim.api.nvim_set_keymap("t", "<D-v>", "<C-R>+", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<D-v>", "<C-R>+", { noremap = true, silent = true })
