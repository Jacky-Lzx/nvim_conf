return {

  {
    "nvim-tree/nvim-web-devicons",
    opts = {
      override = {
        copilot = {
          icon = "",
          color = "#cba6f7", -- Catppuccin.mocha.mauve
          name = "Copilot",
        },
      },
    },
  },

  {
    "HiPhish/rainbow-delimiters.nvim",
    event = "BufReadPost",
    submodules = false,
    config = true,
    main = "rainbow-delimiters.setup",
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    dependencies = {
      "HiPhish/rainbow-delimiters.nvim",
    },
    main = "ibl",
    event = "BufReadPost",
    opts = {
      scope = {},
    },
    config = function(_, opts)
      local highlight = {
        "RainbowYellow",
        "RainbowGreen",
        "RainbowOrange",
        "RainbowViolet",
        "RainbowPink",
        "RainbowRosewater",
        "RainbowRed",
      }
      local hooks = require("ibl.hooks")
      -- create the highlight groups in the highlight setup hook, so they are reset
      -- every time the colorscheme changes
      -- stylua: ignore
      hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
        vim.api.nvim_set_hl(0, "RainbowYellow",    { fg = "#f9e2af" })
        vim.api.nvim_set_hl(0, "RainbowGreen",     { fg = "#a6e3a1" })
        vim.api.nvim_set_hl(0, "RainbowOrange",    { fg = "#fab387" })
        vim.api.nvim_set_hl(0, "RainbowViolet",    { fg = "#cba6f7" })
        vim.api.nvim_set_hl(0, "RainbowPink",      { fg = "#f5c2e7" })
        vim.api.nvim_set_hl(0, "RainbowRosewater", { fg = "#f5e0dc" })
        vim.api.nvim_set_hl(0, "RainbowRed",       { fg = "#f38ba8" })
      end)

      vim.g.rainbow_delimiters = { highlight = highlight }
      opts.scope.highlight = highlight
      require("ibl").setup(opts)

      hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
    end,
  },

  {
    "echasnovski/mini.diff",
    event = "BufReadPost",
    version = "*",
    opts = {},
  },

  -- Show colors in the text: e.g. "#b3e2a7"
  {
    "norcalli/nvim-colorizer.lua",
    event = "BufRead",
    opts = {},
    config = function(_)
      require("colorizer").setup()
    end,
  },

  {
    "lewis6991/gitsigns.nvim",
    event = "BufReadPost",
    opts = {
      signcolumn = false,
      numhl = true,
      -- word_diff = true,
      -- Toggle the line blame by `:Gitsigns toggle_current_line_blame`
      current_line_blame = true,
      attach_to_untracked = true,
    },
    config = function(_, opts)
      require("gitsigns").setup(opts)
      -- require("scrollbar.handlers.gitsigns").setup()
    end,
  },

  {
    -- Conflicted with vscode_nvim, don't know why
    "kevinhwang91/nvim-hlslens",
    -- stylua: ignore
    keys = {
      { "n",  "nzz<Cmd>lua require('hlslens').start()<CR>", mode = "n", desc = "Next match",      noremap = true, silent = true },
      { "N",  "Nzz<Cmd>lua require('hlslens').start()<CR>", mode = "n", desc = "Previous match",  noremap = true, silent = true },
      { "*",  "*<Cmd>lua require('hlslens').start()<CR>",   mode = "n", desc = "Next match",      noremap = true, silent = true },
      { "#",  "#<Cmd>lua require('hlslens').start()<CR>",   mode = "n", desc = "Previous match",  noremap = true, silent = true },
      { "g*", "g*<Cmd>lua require('hlslens').start()<CR>",  mode = "n", desc = "Next match",      noremap = true, silent = true },
      { "g#", "g#<Cmd>lua require('hlslens').start()<CR>",  mode = "n", desc = "Previous match",  noremap = true, silent = true },
      { "//", "<Cmd>noh<CR>",                               mode = "n", desc = "Clear highlight", noremap = true, silent = true },

      { "/" },
      { "?" },
    },
    opts = {
      nearest_only = true,
    },
    config = function(_, opts)
      -- require('hlslens').setup() is not required
      require("scrollbar.handlers.search").setup(
        opts -- hlslens config overrides
      )
      -- Set vim highlight group for HlSearchLens
      -- vim.cmd([[highlight link HlSearchLens CurSearch]])
      vim.api.nvim_set_hl(0, "HlSearchLens", { link = "CurSearch" })
    end,
  },

  {
    "petertriho/nvim-scrollbar",
    event = "BufReadPost",
    opts = {
      handle = {
        text = " ",
        blend = 60, -- Integer between 0 and 100. 0 for fully opaque and 100 to full transparent. Defaults to 30.
        color = nil,
        color_nr = nil, -- cterm
        highlight = "Visual",
        hide_if_all_visible = true, -- Hides handle if all lines are visible
      },
      handelers = {
        gitsigns = true, -- for gitsigns
        search = true, -- for hlslens
      },
      marks = {
        Search = {
          color = "#8fc7d6",
        },
        GitAdd = { text = "┃" },
        GitChange = { text = "┃" },
        GitDelete = { text = "_" },
      },
    },
    config = function(_, opts)
      require("scrollbar").setup(opts)
    end,
  },

  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      ---@type false | "classic" | "modern" | "helix"
      preset = "helix",
      win = {
        -- no_overlap = true,
        title = false,
        width = 0.5,
      },
      -- stylua: ignore
      spec = {
        { "<leader>cc", group = "<CodeCompanion>", icon = "" },
        { "<leader>D",  group = "<Dap>",           icon = "" },
        { "<leader>w",  group = "<Workspace>"                   },
        { "<leader>s",  group = "<Snacks>"                    },
        { "<leader>t",  group = "<Snacks> Toggle"             },
        { "<leader>g",  group = "<Trouble> / git"             },
      },
      -- expand all nodes wighout a description
      expand = function(node)
        return not node.desc
      end,
    },
    keys = {
      -- stylua: ignore
      { "<leader>?", function() require("which-key").show({ global = false }) end, desc = "[Which-key] Buffer Local Keymaps", },
    },
  },

  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      { "AndreM222/copilot-lualine" },
    },
    event = "BufWinEnter",
    opts = function()
      local mocha = require("catppuccin.palettes").get_palette("mocha")

      local function show_macro_recording()
        local recording_register = vim.fn.reg_recording()
        if recording_register == "" then
          return ""
        else
          return "󰑋 " .. recording_register
        end
      end

      local macro_recording = {
        show_macro_recording,
        color = { fg = "#333333", bg = mocha.red },
        separator = { left = "", right = "" },
      }
      local mode = {
        "mode",
        -- separator = { left = "", right = "" },
      }
      local location = {
        "location",
        -- separator = { left = "", right = "" },
      }

      local copilot = {
        "copilot",
        show_colors = true,
        symbols = {
          status = {
            hl = {
              enabled = mocha.green,
              sleep = mocha.overlay0,
              disabled = mocha.surface0,
              warning = mocha.peach,
              unknown = mocha.red,
            },
          },
          spinner_color = mocha.mauve,
        },
      }

      return {
        options = {
          -- When set to true, left sections i.e. 'a','b' and 'c'
          -- can't take over the entire statusline even
          -- if neither of 'x', 'y' or 'z' are present.
          always_divide_middle = false,
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
        },
        sections = {
          lualine_a = { mode },
          lualine_b = { "branch", "diff", "diagnostics" },
          lualine_c = { "filename", copilot },
          lualine_x = {
            macro_recording,
          },
          lualine_y = { "encoding", "fileformat", "filetype", "progress" },
          lualine_z = { location },
        },
        -- stylua: ignore
        winbar = {
          lualine_a = {
            "filename"
          },
          lualine_b = {
            { function() return " " end, color = 'Comment'},
          },
          lualine_x = {
            "lsp_status"
          }
        },
        -- stylua: ignore
        inactive_winbar = {
          -- Always show winbar
          lualine_b = { function() return " " end },
        },
      }
    end,
  },

  -- New replacement of tabline
  {
    "romgrk/barbar.nvim",
    version = "^1.0.0", -- optional: only update when a new 1.x version is released
    dependencies = {
      "nvim-tree/nvim-web-devicons", -- OPTIONAL: for file icons
    },
    init = function()
      vim.g.barbar_auto_setup = false
    end,
    opts = {
      animation = false,
      -- Automatically hide the tabline when there are this many buffers left.
      -- Set to any value >=0 to enable.
      auto_hide = 1,
      -- Set the filetypes which barbar will offset itself for
      sidebar_filetypes = {
        -- Default values: {event = 'BufWinLeave', text = '', align = 'left'}
        NvimTree = {
          text = "NvimTree",
          event = "BufWinLeave",
        },
        undotree = {
          text = "UndoTree",
        },
      },
    },
    event = { "VeryLazy" },
    -- stylua: ignore
    keys = {
      { "<A-<>", "<CMD>BufferMovePrevious<CR>", mode = {"n"}, desc = "[Buffer] Move buffer left"  },
      { "<A->>", "<CMD>BufferMoveNext<CR>",     mode = {"n"}, desc = "[Buffer] Move buffer right" },
      { "<A-1>", "<CMD>BufferGoto 1<CR>",       mode = {"n"}, desc = "[Buffer] Go to buffer 1"    },
      { "<A-2>", "<CMD>BufferGoto 2<CR>",       mode = {"n"}, desc = "[Buffer] Go to buffer 2"    },
      { "<A-3>", "<CMD>BufferGoto 3<CR>",       mode = {"n"}, desc = "[Buffer] Go to buffer 3"    },
      { "<A-4>", "<CMD>BufferGoto 4<CR>",       mode = {"n"}, desc = "[Buffer] Go to buffer 4"    },
      { "<A-5>", "<CMD>BufferGoto 5<CR>",       mode = {"n"}, desc = "[Buffer] Go to buffer 5"    },
      { "<A-6>", "<CMD>BufferGoto 6<CR>",       mode = {"n"}, desc = "[Buffer] Go to buffer 6"    },
      { "<A-7>", "<CMD>BufferGoto 7<CR>",       mode = {"n"}, desc = "[Buffer] Go to buffer 7"    },
      { "<A-8>", "<CMD>BufferGoto 8<CR>",       mode = {"n"}, desc = "[Buffer] Go to buffer 8"    },
      { "<A-9>", "<CMD>BufferGoto 9<CR>",       mode = {"n"}, desc = "[Buffer] Go to buffer 9"    },
      { "<A-h>", "<CMD>BufferPrevious<CR>",     mode = {"n"}, desc = "[Buffer] Previous buffer"   },
      { "<A-l>", "<CMD>BufferNext<CR>",         mode = {"n"}, desc = "[Buffer] Next buffer"       },
      -- { "<A-w>", "<CMD>BufferClose<CR>",        mode = {"n"}, desc = "Close buffer"      },
    },
  },

  {
    "kosayoda/nvim-lightbulb",
    event = "LspAttach",
    opts = {
      autocmd = { enabled = true },
      sign = {
        text = "",
      },
      -- virtual_text = { enabled = true },
    },
  },

  {
    "aznhe21/actions-preview.nvim",
    -- stylua: ignore
    keys = {
      { "<leader>a",   function() require("actions-preview").code_actions() end, desc = "[LSP] Code action", noremap = true, silent = true, },
      { "<A-a>",   function() require("actions-preview").code_actions() end, desc = "[LSP] Code action", mode = "i", noremap = true, silent = true, },
      { "<leader>gra", function() require("actions-preview").code_actions() end, desc = "[LSP] Code action", noremap = true, silent = true, },
    },
    opts = function()
      local hl = require("actions-preview.highlight")
      return {
        backend = { "snacks", "telescope" },

        snacks = {
          layout = {
            reverse = false,
            layout = {
              backdrop = false,
              width = 0.5,
              min_width = 80,
              height = 0.4,
              min_height = 3,
              box = "vertical",
              border = "rounded",
              title = "{title}",
              title_pos = "center",
              { win = "input", height = 1, border = "bottom" },
              { win = "list", height = 5, border = "none" },
              { win = "preview", title = "{preview}", height = 0.4, border = "top" },
            },
          },
        },
        -- priority list of external command to highlight diff
        -- disabled by default, must be set by yourself
        highlight_command = {
          -- Highlight diff using delta: https://github.com/dandavison/delta
          -- The argument is optional, in which case "delta" is assumed to be
          -- specified.
          hl.delta("delta --config " .. os.getenv("HOME") .. "/.config/nvim/configs/.gitconfig"),
        },
      }
    end,
  },

  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    keys = {
      { "<leader>sN", "<CMD>Noice pick<CR>", desc = "[Noice] Pick history messages" },
      { "<leader>N", "<CMD>Noice<CR>", desc = "[Noice] Show history messages" },
    },
    opts = {
      routes = {
        {
          filter = {
            event = "msg_show",
            kind = "search_count",
          },
          opts = { skip = true },
        },
        {
          filter = {
            event = "msg_show",
            kind = "",
          },
          opts = { skip = true },
        },
      },
      lsp = {
        progress = {
          enabled = true,
          -- Lsp Progress is formatted using the builtins for lsp_progress. See config.format.builtin
          -- See the section on formatting for more details on how to customize.
          --- @type NoiceFormat|string
          format = "lsp_progress",
          --- @type NoiceFormat|string
          format_done = "lsp_progress_done",
          throttle = 1000 / 30, -- frequency to update lsp progress message
          view = "mini",
        },
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
        message = {
          -- Messages shown by lsp servers
          enabled = true,
          view = "notify",
          opts = {},
        },
      },
      notify = {
        enabled = false,
      },
      -- you can enable a preset for easier configuration
      presets = {
        bottom_search = false, -- use a classic bottom cmdline for search
        command_palette = true, -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false, -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = true, -- add a border to hover docs and signature help
      },
    },
  },
}
