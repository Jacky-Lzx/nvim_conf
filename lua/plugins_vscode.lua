local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local lazy_opts = {
  git = {
    clone_timeout = 600,
    url_format = "git@github.com:%s.git",
  },
}

require("lazy").setup({
  -- {
  --   "phaazon/hop.nvim",
  --   lazy = true,
  --   branch = "v2", -- optional but strongly recommended
  --   keys = {
  --     {
  --       "<leader>j",
  --       function()
  --         require("hop").hint_lines({ current_line_only = false })
  --       end,
  --       mode = { "n", "v" },
  --       desc = "hop jump",
  --     },
  --     {
  --       "<leader>k",
  --       function()
  --         require("hop").hint_lines({ current_line_only = false })
  --       end,
  --       mode = { "n", "v" },
  --       desc = "hop jump",
  --     },
  --   },
  --   opts = {},
  --   config = function(_, opts)
  --     require("hop").setup(opts)
  --   end,
  -- },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      -- flavour = "mocha"
      integrations = {
        hop = true,
        leap = true,
        -- noice = true,
        -- which_key = true,
        nvim_surround = true,
      },
    },
    config = function(_, opts)
      require("catppuccin").setup(opts)

      vim.cmd([[colorscheme catppuccin-mocha]])
    end,
  },
  {
    "smoka7/hop.nvim",
    lazy = true,
    version = "*",
    keys = {
      {
        "<leader>j",
        function()
          require("hop").hint_lines({ current_line_only = false })
        end,
        mode = { "n", "v" },
        desc = "hop jump",
      },
      {
        "<leader>k",
        function()
          require("hop").hint_lines({ current_line_only = false })
        end,
        mode = { "n", "v" },
        desc = "hop jump",
      },
    },
    config = function()
      -- you can configure Hop the way you like here; see :h hop-config
      require("hop").setup({ keys = "etovxqpdygfblzhckisuran" })
    end,
  },
  {
    "ggandor/leap.nvim",
    dependencies = { "tpope/vim-repeat" },
    keys = {
      { "<leader>s", "<Plug>(leap-forward-to)", mode = { "n", "x", "o" }, desc = "leap jump forward" },
      { "<leader>S", "<Plug>(leap-backward-to)", mode = { "n", "x", "o" }, desc = "leap jump backward" },
      { "<leader>gs", "<Plug>(leap-from-window)", mode = { "n", "x", "o" }, desc = "leap jump window" },
    },
  },
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
      })
    end,
  },
  {
    "numToStr/Comment.nvim",
    keys = {
      {
        "<leader>/",
        function()
          require("Comment.api").toggle.linewise.current()
        end,
        desc = "comment current line",
      },
      {
        "<leader>/",
        "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>",
        mode = "v",
        desc = "comment current line",
      },
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
    -- event = "BufWritePre",
    config = function()
      require("trim").setup()
    end,
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
        -- escseq = 'tmux',     -- use tmux escape sequence, only enable if
        -- you're using tmux and have issues (see #4)
        ssh_only = true, -- false to OSC52 yank also in local sessions
        silent = false, -- true to disable the "n chars copied" echo
        echo_hl = "Directory", -- highlight group of the OSC52 echo message
      },
    },
  },
}, lazy_opts)
