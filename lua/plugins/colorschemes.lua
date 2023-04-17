local colorscheme = require("colorscheme")

if colorscheme == "dracula" then
  return {
    {
      "Mofiqul/dracula.nvim",
      priority = 1000,
      lazy = false,
      opts = {},
      config = function(_, opts)
        require("dracula").setup(opts)
        vim.cmd([[colorscheme dracula]])
      end,
    },
  }
elseif colorscheme == "tokyonight" then
  return {
    {
      "folke/tokyonight.nvim",
      priority = 1000,
      lazy = false,
      opts = { style = "night" },
      config = function(_, opts)
        require("tokyonight").setup(opts)

        vim.cmd([[colorscheme tokyonight]])
      end,
    },
  }
else
  -- Fallback to gruvbox
  return {
    {
      "ellisonleao/gruvbox.nvim",
      priority = 1000,
      lazy = false,
      opts = {
        undercurl = true,
        underline = true,
        bold = true,
        italic = {
          strings = true,
          comments = true,
          operators = false,
          folds = true,
        },
        strikethrough = true,
        invert_selection = false,
        invert_signs = false,
        invert_tabline = false,
        invert_intend_guides = false,
        inverse = true, -- invert background for search, diffs, statuslines and errors
        contrast = "", -- can be "hard", "soft" or empty string
        palette_overrides = {},
        overrides = {},
        dim_inactive = false,
        -- transparent_mode = false,
        transparent_mode = true,
      },
      config = function(_, opts)
        require("gruvbox").setup(opts)

        vim.o.background = "dark" -- or "light" for light mode
        vim.cmd([[colorscheme gruvbox]])
        vim.cmd([[colorscheme gruvbox]])
      end,
    },
  }
end
