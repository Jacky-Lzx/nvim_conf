return {
  -- {
  --   "rmagatti/auto-session",
  --   lazy = false,
  --
  --   keys = {
  --     { "<leader>sa", "<CMD>Autosession search<CR>", desc = "[Auto Session] Search session" },
  --   },
  --
  --   ---enables autocomplete for opts
  --   ---@module "auto-session"
  --   ---@type AutoSession.Config
  --   opts = {
  --     suppressed_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
  --   },
  --
  --   config = function(_, opts)
  --     vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
  --
  --     require("auto-session").setup(opts)
  --   end,
  -- },

  -- {
  --   "olimorris/persisted.nvim",
  --   event = "BufReadPre", -- Ensure the plugin loads only when a buffer has been loaded
  --   opts = {
  --     -- Your config goes here ...
  --   },
  --   config = function(_, opts)
  --     require("telescope").load_extension("persisted")
  --
  --     require("persisted").setup(opts)
  --   end,
  -- },

  -- Session management. This saves your session in the background,
  -- keeping track of open buffers, window arrangement, and more.
  -- You can restore sessions when returning through the dashboard.
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = {},
    -- stylua: ignore
    keys = {
      { "<leader>ps", function() require("persistence").load() end, desc = "Restore Session" },
      { "<leader>pS", function() require("persistence").select() end,desc = "Select Session" },
      { "<leader>pl", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session" },
      { "<leader>pd", function() require("persistence").stop() end, desc = "Don't Save Current Session" },
    },
  },
}
