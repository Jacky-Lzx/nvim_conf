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
elseif colorscheme == "catppuccin" then
  return {
    {
      "catppuccin/nvim",
      name = "catppuccin",
      priority = 1000,
      opts = {
        -- flavour = "mocha"
        integrations = {
          alpha = true,
          gitsigns = true,
          hop = true,
          leap = true,
          noice = true,
          notify = true,
          which_key = true,
          nvim_surround = true,
          barbar = true,
          nvimtree = true,
        },
      },
      config = function(_, opts)
        require("catppuccin").setup(opts)

        vim.cmd([[colorscheme catppuccin-mocha]])
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
          comments = false,
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
