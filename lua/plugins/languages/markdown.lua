return {
  {
    "3rd/image.nvim",
    ft = { "markdown" },
    dependencies = {
      {
        "vhyrro/luarocks.nvim",
        priority = 1001, -- this plugin needs to run before anything else
        opts = {
          rocks = { "magick" },
        },
      },
    },
    opts = {},
  },
  -- {
  --   "edluffy/hologram.nvim",
  --   opts = {
  --     auto_display = true, -- WIP automatic markdown image display, may be prone to breaking
  --   },
  -- },

  -- Obsidian Plugin
  {
    "epwalsh/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    lazy = true,
    ft = "markdown",
    -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
    event = {
      -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
      -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
      -- refer to `:h file-pattern` for more examples
      "BufReadPre ~/Documents_lzx/Obsidian/Research/*.md",
      "BufNewFile ~/Documents_lzx/Obsidian/Research/*.md",
    },
    dependencies = {
      -- Required.
      "nvim-lua/plenary.nvim",

      -- see below for full list of optional dependencies 👇
    },
    opts = {
      workspaces = {
        {
          name = "research",
          path = "~/Documents_lzx/Obsidian/Research",
        },
      },

      -- see below for full list of options 👇
    },
  },
}
