-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

local opts = {
  spec = {
    { import = "plugins" },
  },
  custom_keys = {
    -- you can define custom key maps here.
    -- To disable one of the defaults, set it to false

    -- open lazygit log
    ["<localleader>l"] = false,

    -- open a terminal for the plugin dir
    ["<localleader>t"] = false,
  },
  install = {
    -- install missing plugins on startup. This doesn't increase startup time.
    missing = true,
    -- try to load one of these colorschemes when starting an installation during startup
    colorscheme = { "gruvbox" },
  },
  -- automatically check for plugin updates
  checker = { enabled = true },
  git = {
    clone_timeout = 600,
    -- url_format = "git@github.com:%s.git",
  },
  ui = {
    -- The border to use for the UI window. Accepts same border values as |nvim_open_win()|.
    border = "rounded",
    icons = {
      cmd = "",
      config = "",
      event = "󱐋",
      ft = "",
      init = "",
      import = "",
      keys = "",
      lazy = "󰒲 ",
      loaded = "●",
      not_loaded = "○",
      plugin = "",
      runtime = "",
      source = "",
      start = "",
      task = "✔",
      list = {
        "●",
        "➜",
        "★",
        "‒",
      },
    },
  },
}

require("lazy").setup(opts)

vim.keymap.set("n", "<leader>L", "<cmd>Lazy<cr>")
