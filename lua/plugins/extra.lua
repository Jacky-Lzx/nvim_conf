return {
  -- use({ "stevearc/aerial.nvim", config = require("aerial").setup() })

  {
    "dstein64/vim-startuptime",
    cmd = "StartupTime",
    config = function()
      vim.g.startuptime_tries = 10
    end,
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

  -- use 'easymotion/vim-easymotion'
  -- {
  --   "phaazon/hop.nvim",
  --   lazy = true,
  --   branch = "v2", -- optional but strongly recommended
  --   -- stylua: ignore
  --   keys = {
  --     { "<leader>j", function() require("hop").hint_lines({ current_line_only = false }) end, mode = { "n", "v" }, desc = "hop jump" },
  --     { "<leader>k", function() require("hop").hint_lines({ current_line_only = false }) end, mode = { "n", "v" }, desc = "hop jump" },
  --   },
  --   opts = {},
  --   config = function(_, opts)
  --     require("hop").setup(opts)
  --   end,
  -- },

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

  -- {
  --   "lukas-reineke/indent-blankline.nvim",
  --   event = { "BufReadPost", "BufNewFile" },
  --   opts = {
  --     -- char = "▏",
  --     char = "│",
  --     filetype_exclude = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy" },
  --     show_trailing_blankline_indent = false,
  --     show_current_context = false,
  --     show_current_context_start = false,
  --   },
  -- },
  {
    "echasnovski/mini.indentscope",
    version = false, -- wait till new 0.7.0 release to put it back on semver
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      -- Module mappings. Use `''` (empty string) to disable one.
      mappings = {
        -- Textobjects
        object_scope = "ii",
        object_scope_with_border = "ai",

        -- Motions (jump to respective border line; if not present - body line)
        goto_top = "[i",
        goto_bottom = "]i",
      },
      -- symbol = "▏",
      symbol = "│",
      options = {
        border = "both",
        try_as_border = true,
      },
    },
    init = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy", "mason" },
        callback = function()
          vim.b.miniindentscope_disable = true
        end,
      })
    end,
    config = function(_, opts)
      require("mini.indentscope").setup(opts)
    end,
  },
}
