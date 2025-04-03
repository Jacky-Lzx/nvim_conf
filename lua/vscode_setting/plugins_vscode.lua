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

local lazy_opts = {
  git = {
    clone_timeout = 600,
    -- url_format = "git@github.com:%s.git",
  },
}

require("lazy").setup({
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      -- flavour = "mocha"
      integrations = {
        -- alpha = true,
        -- gitsigns = true,
        noice = true,
        -- notify = true,
        -- which_key = true,
        nvim_surround = true,
        -- barbar = true,
        -- nvimtree = true,
        -- mini = {
        --   enabled = true,
        --   indentscope_color = "blue", -- catppuccin color (eg. `lavender`) Default: text
        -- },
      },
    },
    config = function(_, opts)
      require("catppuccin").setup(opts)

      vim.cmd([[colorscheme catppuccin-mocha]])
    end,
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {
      modes = {
        char = {
          enabled = false,
        },
      },
    },
    -- stylua: ignore
    keys = {
      { "<leader>f", mode = { "n", "x", "o" }, function() require("flash").jump() end,                                                                                               desc = "[Flash] Jump"              },
      { "<leader>F", mode = { "n", "x", "o" }, function() require("flash").treesitter() end,                                                                                         desc = "[Flash] Treesitter"        },
      -- { "r",      mode = "o",               function() require("flash").remote() end,                                                                                             desc = "Remote Flash"              },
      { "<leader>F", mode = { "o", "x" },      function() require("flash").treesitter_search() end,                                                                                  desc = "[Flash] Treesitter Search" },
      { "<c-s>",     mode = { "c" },           function() require("flash").toggle() end,                                                                                             desc = "[Flash] Toggle Search"     },
      { "<leader>j", mode = { "n", "x", "o" }, function() require("flash").jump({ search = { mode = "search", max_length = 0 }, label = { after = { 0, 0 } }, pattern = "^", }) end, desc = "[Flash] Line jump"         },
      { "<leader>k", mode = { "n", "x", "o" }, function() require("flash").jump({ search = { mode = "search", max_length = 0 }, label = { after = { 0, 0 } }, pattern = "^", }) end, desc = "[Flash] Line jump"         },
    },
  },
  {
    "echasnovski/mini.surround",
    version = "*",
    event = "BufReadPost",
    config = true,
    keys = {
      -- Disable the vanilla `s` keybinding
      { "s", "<NOP>", mode = { "n", "x", "o" } },
    },
  },
  {
    "numToStr/Comment.nvim",
    -- stylua: ignore
    keys = {
      { "<leader>/", function() require("Comment.api").toggle.linewise.current() end,                 mode = "n", desc = "comment current line", },
      { "<leader>/", "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>", mode = "v", desc = "comment current line", },
    },
    config = function()
      require("Comment").setup()

      local ft = require("Comment.ft")
      ft.cpp = { "//%s", "/*%s*/" }
      ft.c = { "//%s", "/*%s*/" }
      ft.python = { "#%s" }
    end,
  },
  {
    "cappyzawa/trim.nvim",
    event = "BufWritePre",
    opts = {},
  },
  {
    "ibhagwan/smartyank.nvim",
    opts = {
      highlight = {
        enabled = true, -- highlight yanked text
        higroup = "IncSearch", -- highlight group of yanked text
        timeout = 400, -- timeout for clearing the highlight
      },
      clipboard = {
        enabled = true,
      },
      tmux = {
        enabled = true,
        -- remove `-w` to disable copy to host client's clipboard
        cmd = { "tmux", "set-buffer", "-w" },
      },
      osc52 = {
        enabled = true,
        -- escseq = 'tmux',     -- use tmux escape sequence, only enable if you're using tmux and have issues (see #4)
        ssh_only = true, -- false to OSC52 yank also in local sessions
        silent = false, -- true to disable the "n chars copied" echo
        echo_hl = "Directory", -- highlight group of the OSC52 echo message
      },
    },
  },
}, lazy_opts)
