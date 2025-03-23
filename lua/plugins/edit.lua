return {

  {
    -- Extende `a`/`i` textobjects
    "echasnovski/mini.ai",
    version = "*",
    event = "BufReadPost",
    config = true,
  },

  {
    "echasnovski/mini.bracketed",
    version = "*",
    event = "BufReadPost",
    config = true,
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
    "echasnovski/mini.operators",
    version = "*",
    event = "BufReadPost",
    opts = {
      replace = { prefix = "cr" },
    },
  },

  {
    "echasnovski/mini.pairs",
    version = "*",
    event = { "InsertEnter" },
    config = true,
  },

  {
    "echasnovski/mini.align",
    version = "*",
    event = "BufRead",
    opts = {
      mappings = {
        start = "gA",
        start_with_preview = "ga",
      },
    },
    config = function(_, opts)
      require("mini.align").setup(opts)
    end,
  },

  {
    "echasnovski/mini.cursorword",
    version = false,
    event = "BufRead",
    config = function()
      require("mini.cursorword").setup()
    end,
  },

  -- {
  --   "kylechui/nvim-surround",
  --   version = "*", -- Use for stability; omit to use `main` branch for the latest features
  --   event = "VeryLazy",
  --   opts = {},
  -- },

  {
    "cappyzawa/trim.nvim",
    event = "BufWritePre",
    opts = {},
  },

  {
    "mbbill/undotree",
    keys = {
      { "<leader>ut", "<cmd>UndotreeToggle<cr>", desc = "toggle undo-tree" },
    },
    init = function()
      vim.cmd([[
      if has("persistent_undo")
         let target_path = expand('~/.undodir')

          " create the directory and any parent directories
          " if the location does not exist.
          if !isdirectory(target_path)
              call mkdir(target_path, "p", 0700)
          endif

          let &undodir=target_path
          set undofile
      endif
      ]])
    end,
  },

  {
    "numToStr/Comment.nvim",
    -- stylua: ignore
    keys = {
      { "<leader>/", function() require("Comment.api").toggle.linewise.current() end,                 mode = "n", desc = "Comment current line", },
      { "<leader>/", "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>", mode = "v", desc = "Comment current line", },
      -- control + / keymappings
      { "<C-_>",     function() require("Comment.api").toggle.linewise.current() end,                 mode = "n", desc = "Comment current line", },
      { "<C-_>",     "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>", mode = "v", desc = "Comment current line", },
    },
    config = function()
      require("Comment").setup()
    end,
  },

  { "wakatime/vim-wakatime", lazy = false },

  {
    -- Highlight and search for todo comments like TODO, HACK, BUG in your code base.
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
    event = "BufReadPost",
    -- stylua: ignore
    keys = {
      { "<leader>td", "<cmd>TodoTelescope<cr>", desc = "List todo comments" },
    },
    config = true,
  },

  {
    "ibhagwan/smartyank.nvim",
    event = { "BufReadPost" },
    opts = {
      highlight = {
        enabled = true, -- highlight yanked text
        higroup = "IncSearch", -- highlight group of yanked text
        timeout = 500, -- timeout for clearing the highlight
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

  {
    "smoka7/hop.nvim",
    lazy = true,
    version = "*",
    -- stylua: ignore
    keys = {
      { "<leader>j", function() require("hop").hint_lines_skip_whitespace({ current_line_only = false }) end, mode = { "n", "v" }, desc = "Hop jump", },
      { "<leader>k", function() require("hop").hint_lines_skip_whitespace({ current_line_only = false }) end, mode = { "n", "v" }, desc = "Hop jump", },
    },
    opts = {
      keys = "etovxqpdygfblzhckisuran",
    },
  },
  {
    "ggandor/leap.nvim",
    dependencies = { "tpope/vim-repeat" },
    -- stylua: ignore
    keys = {
      { "<leader>s",  "<Plug>(leap-forward-to)",  mode = { "n", "x", "o" }, desc = "Leap jump forward" },
      { "<leader>S",  "<Plug>(leap-backward-to)", mode = { "n", "x", "o" }, desc = "leap jump backward" },
      -- { "<leader>gs", "<Plug>(leap-from-window)", mode = { "n", "x", "o" }, desc = "leap jump window" },
    },
    opts = {
      equivalence_classes = { " \t\r\n", "([{", ")]}", "'\"`" },
    },
  },
}
