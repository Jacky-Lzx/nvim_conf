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
          barbar = true,
          blink_cmp = true,
          fidget = true,
          flash = true,
          gitsigns = true,
          markdown = true,
          mason = true,
          noice = true,
          copilot_vim = true,
          dap = true,
          dap_ui = true,
          native_lsp = {
            enabled = true,
            virtual_text = {
              errors = { "italic" },
              hints = { "italic" },
              warnings = { "italic" },
              information = { "italic" },
              ok = { "italic" },
            },
            underlines = {
              errors = { "underline" },
              hints = { "underline" },
              warnings = { "underline" },
              information = { "underline" },
              ok = { "underline" },
            },
            inlay_hints = {
              background = true,
            },
          },
          nvim_surround = true,
          treesitter = true,
          treesitter_context = true,
          overseer = true,
          rainbow_delimiters = true,
          render_markdown = true,
          snacks = {
            enabled = true,
            indent_scope_color = "lavender", -- catppuccin color (eg. `lavender`) Default: text
          },
          lsp_trouble = true,
          which_key = true,
        },
        custom_highlights = function(colors)
          -- stylua: ignore
          return {
            -- Comment                  = { fg = colors.flamingo },
            -- TabLineSel               = { bg = colors.pink     },
            -- CmpBorder                = { fg = colors.surface2 },
            -- Pmenu                    = { bg = colors.none     },
            LineNr                      = { fg = colors.surface2 },
            -- Search                   = { bg = colors.flamingo },
            Visual                      = { bg = colors.overlay0 },
            Search                      = { bg = colors.surface2 },
            IncSearch                   = { bg = colors.lavender },
            CurSearch                   = { bg = colors.lavender },
            -- CursorLine               = { bg = colors.falmingo }
            LspSignatureActiveParameter = { bg = colors.overlay0 },
            MatchParen                  = { bg = colors.lavender, fg = colors.base, bold = true},
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
