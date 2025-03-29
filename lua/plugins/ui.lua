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
    config = function()
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
      require("ibl").setup({ scope = { highlight = highlight } })

      hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
    end,
  },

  {
    "echasnovski/mini.diff",
    event = "BufReadPost",
    version = "*",
    opts = {},
  },

  -- {
  --   -- Distraction-free coding
  --   "folke/zen-mode.nvim",
  --   dependencies = { { "folke/twilight.nvim", opts = { context = 10 } } }, -- Dims inactive portions of the code you're editing.
  --   cmd = "ZenMode",
  --   opts = {
  --     plugins = {
  --       twilight = { enabled = true },
  --     },
  --   },
  -- },

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
      require("scrollbar.handlers.gitsigns").setup()
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

  -- Show where your cursor moves when jumping large distances
  -- use({ "edluffy/specs.nvim", config = require("plugin-settings.specs") })

  -- {
  --   -- Greeting page
  --   "goolord/alpha-nvim",
  --   dependencies = { "nvim-tree/nvim-web-devicons" },
  --   event = "VimEnter",
  --   config = function()
  --     require("alpha").setup(require("alpha.themes.dashboard").config)
  --   end,
  -- },

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
        { "<leader>cc", group = "[CodeCompanion]", icon = "" },
        { "<leader>d",  group = "[Dap]",           icon = "" },
        { "<leader>f",  group = "[Telescope]"                 },
        { "<leader>n",  group = "[Noice]"                     },
        { "<leader>w",  group = "Workspace"                   },
        { "<leader>s",  group = "[Snacks]"                    },
        { "<leader>u",  group = "[Snacks] toggle"             },
        { "<leader>g",  group = "[Trouble] / git"             },
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
      return {
        options = {
          -- When set to true, left sections i.e. 'a','b' and 'c'
          -- can't take over the entire statusline even
          -- if neither of 'x', 'y' or 'z' are present.
          always_divide_middle = false,
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
        },
        -- stylua: ignore
        sections = {
          lualine_a = { "mode"                                           },
          lualine_b = { "branch", "diff", "diagnostics"                  },
          lualine_c = { "filename", { "copilot", show_colors = true }    },
          lualine_x = {                                                  },
          lualine_y = { "encoding", "fileformat", "filetype", "progress" },
          lualine_z = { "location"                                       },
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
            -- "lsp_status"
          }
        },
        -- stylua: ignore
        inactive_winbar = {
          -- Always show winbar
          lualine_b = { function() return " " end }, },
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
      { "<M-<>", "<CMD>BufferMovePrevious<CR>", mode = {"n"}, desc = "[Buffer] Move buffer left"  },
      { "<M->>", "<CMD>BufferMoveNext<CR>",     mode = {"n"}, desc = "[Buffer] Move buffer right" },
      { "<M-1>", "<CMD>BufferGoto 1<CR>",       mode = {"n"}, desc = "[Buffer] Go to buffer 1"    },
      { "<M-2>", "<CMD>BufferGoto 2<CR>",       mode = {"n"}, desc = "[Buffer] Go to buffer 2"    },
      { "<M-3>", "<CMD>BufferGoto 3<CR>",       mode = {"n"}, desc = "[Buffer] Go to buffer 3"    },
      { "<M-4>", "<CMD>BufferGoto 4<CR>",       mode = {"n"}, desc = "[Buffer] Go to buffer 4"    },
      { "<M-5>", "<CMD>BufferGoto 5<CR>",       mode = {"n"}, desc = "[Buffer] Go to buffer 5"    },
      { "<M-6>", "<CMD>BufferGoto 6<CR>",       mode = {"n"}, desc = "[Buffer] Go to buffer 6"    },
      { "<M-7>", "<CMD>BufferGoto 7<CR>",       mode = {"n"}, desc = "[Buffer] Go to buffer 7"    },
      { "<M-8>", "<CMD>BufferGoto 8<CR>",       mode = {"n"}, desc = "[Buffer] Go to buffer 8"    },
      { "<M-9>", "<CMD>BufferGoto 9<CR>",       mode = {"n"}, desc = "[Buffer] Go to buffer 9"    },
      { "<M-h>", "<CMD>BufferPrevious<CR>",     mode = {"n"}, desc = "[Buffer] Previous buffer"   },
      { "<M-l>", "<CMD>BufferNext<CR>",         mode = {"n"}, desc = "[Buffer] Next buffer"       },
      -- { "<M-w>", "<CMD>BufferClose<CR>",        mode = {"n"}, desc = "Close buffer"      },
    },
  },

  {
    "kosayoda/nvim-lightbulb",
    event = "LspAttach",
    opts = {
      autocmd = { enabled = true },
      -- virtual_text = { enabled = true },
    },
  },
  -- {
  --   "VidocqH/lsp-lens.nvim",
  --   event = "LspAttach",
  --   opts = {},
  -- },

  {
    "aznhe21/actions-preview.nvim",
    -- stylua: ignore
    keys = {
      { "<leader>a",   function() require("actions-preview").code_actions() end, desc = "[LSP] Code action", noremap = true, silent = true, },
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

  -- {
  --   "nvim-telescope/telescope.nvim",
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --     "nvim-telescope/telescope-ui-select.nvim",
  --     { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  --   },
  --   lazy = true,
  --   cmd = "Telescope",
  --   opts = function()
  --     return {
  --       defaults = {
  --         -- Flex layout swaps between `horizontal` and `vertical` strategies based on the window width
  --         layout_strategy = "flex",
  --         layout_config = {
  --           width = 0.9,
  --           height = 0.9,
  --           horizontal = {
  --             preview_width = 0.55,
  --           },
  --           vertical = {
  --             preview_height = 0.6,
  --           },
  --         },
  --         -- laygout_config = {},
  --         -- wrap_results = true,
  --         -- prompt_prefix = " ",
  --         -- selection_caret = " ",
  --         -- stylua: ignore
  --         mappings = {
  --           i = {
  --             ["<M-Down>"] = function(...) require("telescope.actions").cycle_history_next(...)                                              end,
  --             ["<M-Up>"]   = function(...) require("telescope.actions").cycle_history_prev(...)                                              end,
  --             ["<C-d>"]    = function(...) require("telescope.actions").preview_scrolling_down(...)                                          end,
  --             ["<C-u>"]    = function(...) require("telescope.actions").preview_scrolling_up(...)                                            end,
  --             ["<C-h>"]    = function(...) require("telescope.actions").preview_scrolling_left(...)                                          end,
  --             ["<C-l>"]    = function(...) require("telescope.actions").preview_scrolling_right(...)                                         end,
  --             ["<M-k>"]    = function(...) require("telescope.actions").move_selection_previous(...)                                         end,
  --             ["<M-j>"]    = function(...) require("telescope.actions").move_selection_next(...)                                             end,
  --             ["<M-d>"]    = function(...) require("telescope.actions").results_scrolling_down(...) require("telescope.actions").center(...) end,
  --             ["<M-u>"]    = function(...) require("telescope.actions").results_scrolling_up(...) require("telescope.actions").center(...)   end,
  --             ["<M-h>"]    = function(...) require("telescope.actions").results_scrolling_left(...)                                          end,
  --             ["<M-l>"]    = function(...) require("telescope.actions").results_scrolling_right(...)                                         end,
  --           },
  --           n = {
  --             ["q"]        = function(...) require("telescope.actions").close(...)                                                           end,
  --           },
  --         },
  --       },
  --       extensions = {
  --         ["fzf"] = {
  --           -- fuzzy = true, -- false will only do exact matching
  --           override_generic_sorter = true, -- override the generic sorter
  --           override_file_sorter = true, -- override the file sorter
  --           case_mode = "smart_case", -- or "ignore_case" or "respect_case", the default case_mode is "smart_case"
  --         },
  --         ["ui-select"] = {
  --           require("telescope.themes").get_cursor(),
  --         },
  --       },
  --     }
  --   end,
  --   -- stylua: ignore
  --   keys = {
  --     { "<leader>fb", "<cmd>Telescope buffers<cr>",                  desc = "Buffers"                },
  --     { "<leader>fd", "<cmd>Telescope lsp_definitions<cr>",          desc = "Lsp definitions"        },
  --     { "<leader>ff", "<cmd>Telescope find_files<cr>",               desc = "Find files"             },
  --     { "<leader>fg", "<cmd>Telescope live_grep<cr>",                desc = "Live grep"              },
  --     { "<leader>fh", "<cmd>Telescope help_tags<cr>",                desc = "Help tags"              },
  --     { "<leader>fk", "<cmd>Telescope keymaps<cr>",                  desc = "Keymaps"                },
  --     { "<leader>fq", "<cmd>Telescope quickfix<cr>",                 desc = "Quick fix"              },
  --     -- { "<leader>fr", "<cmd>Telescope registers<cr>",                desc = "Registers"              },
  --     -- { "<leader>fc", "<cmd>Telescope colorscheme<cr>",           desc = "Colorscheme"            },
  --     { "<leader>fc", "<cmd>Telescope highlights<cr>",               desc = "Highlights"             },
  --     { "<leader>fm", "<cmd>Telescope noice<cr>",                    desc = "Noice message history"  },
  --     { "<leader>fn", "<cmd>Telescope notify<cr>",                   desc = "Notify message history" },
  --     { "<leader>fs", "<cmd>Telescope lsp_document_symbols<cr>",     desc = "Document symbols"       },
  --     -- { "<leader>fs", "<cmd>Telescope lsp_workspace_symbols<cr>", desc = "Workspace symbols"      },
  --   },
  --   config = function(_, opts)
  --     require("telescope").setup(opts)
  --
  --     require("telescope").load_extension("fzf")
  --     require("telescope").load_extension("ui-select")
  --     require("telescope").load_extension("noice")
  --     require("telescope").load_extension("notify")
  --   end,
  -- },

  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      "rcarriga/nvim-notify",
    },
    -- stylua: ignore
    keys = {
      -- { "<leader>nl", function() require("noice").cmd("last")    end, desc = "noice last message" },
      -- { "<leader>nh", function() require("noice").cmd("history") end, desc = "noice history"      },
    },
    opts = {
      notify = {
        -- Noice can be used as `vim.notify` so you can route any notification like other messages
        -- Notification messages have their level and other properties set.
        -- event is always "notify" and kind can be any log level as a string
        -- The default routes will forward notifications to nvim-notify
        -- Benefit of using Noice for this is the routing and consistent history view
        enabled = true,
        view = "notify",
      },
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

  -- {
  --   -- A fancy, configurable, notification manager for NeoVim
  --   "rcarriga/nvim-notify",
  --   opts = {
  --     -- render = "compact",
  --     -- stages = "fade",
  --     fps = 60,
  --     timeout = 3000,
  --     max_height = function()
  --       return math.floor(vim.o.lines * 0.5)
  --     end,
  --     max_width = function()
  --       return math.floor(vim.o.columns * 0.5)
  --     end,
  --   },
  --   config = function(_, opts)
  --     local notify = require("notify")
  --     vim.notify = notify
  --     print = function(...)
  --       local print_safe_args = {}
  --       local args = { ... }
  --       for i = 1, #args do
  --         table.insert(print_safe_args, tostring(args[i]))
  --       end
  --       notify(table.concat(print_safe_args, "\n"), vim.log.levels.INFO, {
  --         title = "Print results",
  --         icon = "󰐪",
  --       })
  --     end
  --
  --     notify.setup(opts)
  --   end,
  -- },

  -- {
  --   "echasnovski/mini.indentscope",
  --   version = "*",
  --   event = { "BufReadPost" },
  --   opts = function()
  --     return {
  --       -- Module mappings. Use `''` (empty string) to disable one.
  --       mappings = {
  --         -- Textobjects
  --         object_scope = "ii",
  --         object_scope_with_border = "ai",
  --
  --         -- Motions (jump to respective border line; if not present - body line)
  --         goto_top = "[i",
  --         goto_bottom = "]i",
  --       },
  --       -- symbol = "▏",
  --       symbol = "│",
  --       options = {
  --         border = "both",
  --         try_as_border = true,
  --       },
  --     }
  --   end,
  --   init = function()
  --     -- vim.api.nvim_create_autocmd("FileType", {
  --     --   pattern = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy", "mason" },
  --     --   callback = function()
  --     --     vim.b.miniindentscope_disable = true
  --     --   end,
  --     -- })
  --   end,
  --   config = function(_, opts)
  --     require("mini.indentscope").setup(opts)
  --   end,
  -- },
}
