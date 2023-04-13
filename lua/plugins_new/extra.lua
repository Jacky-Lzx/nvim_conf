return {
  {
    "folke/neoconf.nvim",
    cmd = "Neoconf",
  },
  {
    "folke/neodev.nvim",
    config = function()
      require("neodev").setup()
    end,
  },

  -- use({ "stevearc/aerial.nvim", config = require("aerial").setup() })
  {
    "lervag/vimtex",
    lazy = true,
    event = "BufEnter *.tex",
    config = function()
      -- Viewer options: One may configure the viewer either by specifying a built-in
      -- viewer method:
      vim.g.vimtex_view_enabled = true
      vim.g.vimtex_view_method = "skim"

      -- Or with a generic interface:
      -- vim.g.vimtex_view_general_viewer = 'okular'
      -- vim.g.vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'

      -- VimTeX uses latexmk as the default compiler backend. If you use it, which is
      -- strongly recommended, you probably don't need to configure anything. If you
      -- want another compiler backend, you can change it as follows. The list of
      -- supported backends and further explanation is provided in the documentation,
      -- see ":help vimtex-compiler".
      vim.g.vimtex_compiler_method = "latexmk"

      -- Most VimTeX mappings rely on localleader and this can be changed with the
      -- following line. The default is usually fine and is the symbol "\".
      vim.cmd([[let maplocalleader = "\\"]])
    end,
  },
  {
    "dstein64/vim-startuptime",
    cmd = "StartupTime",
    config = function()
      vim.g.startuptime_tries = 10
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
    -- config = function()
    --   require("smartyank").setup({
    --     highlight = {
    --       enabled = true, -- highlight yanked text
    --       higroup = "IncSearch", -- highlight group of yanked text
    --       timeout = 400, -- timeout for clearing the highlight
    --     },
    --     clipboard = {
    --       enabled = true,
    --     },
    --     tmux = {
    --       enabled = true,
    --       -- remove `-w` to disable copy to host client's clipboard
    --       cmd = { "tmux", "set-buffer", "-w" },
    --     },
    --     osc52 = {
    --       enabled = true,
    --       -- escseq = 'tmux',     -- use tmux escape sequence, only enable if
    --       -- you're using tmux and have issues (see #4)
    --       ssh_only = true, -- false to OSC52 yank also in local sessions
    --       silent = false, -- true to disable the "n chars copied" echo
    --       echo_hl = "Directory", -- highlight group of the OSC52 echo message
    --     },
    --   })
    -- end,
  },
  {
    "folke/neoconf.nvim",
    cmd = "Neoconf",
  },
  "folke/neodev.nvim",

  -- use 'easymotion/vim-easymotion'
  {
    "phaazon/hop.nvim",
    lazy = true,
    branch = "v2", -- optional but strongly recommended
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
    opts = {},
    config = function(_, opts)
      require("hop").setup(opts)
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
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      -- char = "▏",
      char = "│",
      filetype_exclude = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy" },
      show_trailing_blankline_indent = false,
      show_current_context = false,
      show_current_context_start = false,
    },
  },
  {
    "echasnovski/mini.indentscope",
    version = false, -- wait till new 0.7.0 release to put it back on semver
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      -- symbol = "▏",
      symbol = "│",
      options = { try_as_border = true },
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
