local colorscheme = Colorscheme or "gruvbox"

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
        transparent_background = true,
        -- flavour = "mocha"
        integrations = {
          alpha = true,
          gitsigns = true,
          hop = true,
          leap = true,
          cmp = true,
          noice = true,
          notify = true,
          which_key = true,
          nvim_surround = true,
          barbar = true,
          nvimtree = true,
          mini = {
            enabled = true,
            indentscope_color = "blue", -- catppuccin color (eg. `lavender`) Default: text
          },
        },
        custom_highlights = function(colors)
          -- stylua: ignore
          return {
            -- Comment =    { fg = colors.flamingo                   },
            -- TabLineSel = { bg = colors.pink                       },
            -- CmpBorder =  { fg = colors.surface2                   },
            -- Pmenu =      { bg = colors.none                       },
            LineNr =        { fg = colors.surface2                   },
            -- Search =     { bg = colors.flamingo                   },
            Visual =        { bg = colors.overlay0                   },
            Search =        { bg = colors.lavender, fg = colors.base },
            IncSearch =     { bg = colors.flamingo, fg = colors.base },
            CurSearch =     { bg = colors.flamingo, fg = colors.base },
          }
        end,
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
