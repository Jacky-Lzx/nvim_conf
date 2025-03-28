return {
  -- {
  --   "rmagatti/auto-session",
  --   lazy = false,
  --
  --   ---enables autocomplete for opts
  --   ---@module "auto-session"
  --   ---@type AutoSession.Config
  --   opts = {
  --     suppressed_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
  --     auto_restore = false
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
}
