return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = "VeryLazy",
    opts = {
      auto_install = true,
      highlight = {
        enable = true,
        -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
        -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
        -- the name of the parser)
        -- list of language that will be disabled
        -- disable = { "verilog" },
        -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
        disable = function(_, buf)
          local max_filesize = 100 * 1024 -- 100 KB
          local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
          if ok and stats and stats.size > max_filesize then
            return true
          end

          if vim.bo[buf].filetype == "verilog" or vim.bo[buf].filetype == "systemverilog" then
            return true
          end
        end,
      },
      indent = {
        enabale = true,
        disable = {
          "markdown", -- indentation at bullet points is worse
        },
      },
    },
    config = function(_, opts)
      local configs = require("nvim-treesitter.configs")

      configs.setup(opts)
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "BufReadPost",
    opts = {
      enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
      max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
      min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
      line_numbers = true,
      multiline_threshold = 20, -- Maximum number of lines to collapse for a single context line
      trim_scope = "outer", -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
      mode = "cursor", -- Line used to calculate context. Choices: 'cursor', 'topline'
      -- Separator between context and content. Should be a single character string, like '-'.
      -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
      -- separator = nil,
      separator = "─",
      zindex = 20, -- The Z-index of the context window
    },
    -- stylua: ignore
    keys = {
      { "[c", function() require("treesitter-context").go_to_context(vim.v.count1) end, mode = { "n" }, desc = "TS go to context", silent = true, },
    },
    config = function(_, opts)
      local configs = require("treesitter-context")

      -- vim.keymap.set("n", "[c", function()
      --   require("treesitter-context").go_to_context(vim.v.count1)
      -- end, { silent = true })

      configs.setup(opts)
    end,
  },

  -- {
  --   "nvim-treesitter/nvim-tree-docs",
  --   keys = {
  --     { "gdd" },
  --   },
  --   opts = {
  --     tree_docs = {
  --       enable = true,
  --     },
  --   },
  --   config = function(_, opts)
  --     require("nvim-treesitter.configs").setup(opts)
  --   end,
  -- },

  -- TODO
  -- {
  --   "nvim-treesitter/nvim-treesitter-refactor",
  --
  --   opts = {
  --     refactor = {
  --       highlight_definitions = {
  --         enable = true,
  --         -- Set to false if you have an `updatetime` of ~100.
  --         clear_on_cursor_move = true,
  --       },
  --       smart_rename = {
  --         enable = true,
  --         -- Assign keymaps to false to disable them, e.g. `smart_rename = false`.
  --         keymaps = {
  --           smart_rename = "grr",
  --         },
  --       },
  --       highlight_current_scope = {
  --         -- enable = true,
  --       },
  --     },
  --   },
  --
  --   config = function(_, opts)
  --     require("nvim-treesitter.configs").setup(opts)
  --   end,
  -- },
  -- { "nvim-treesitter/nvim-treesitter-textobjects" },
}
