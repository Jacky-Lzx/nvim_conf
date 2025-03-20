return {

  {
    "https://github.com/HiPhish/rainbow-delimiters.nvim",
    event = "BufReadPost",
    config = true,
    main = "rainbow-delimiters.setup",
  },

  {
    "echasnovski/mini.diff",
    event = "BufReadPost",
    version = "*",
    opts = {},
  },

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
    -- Distraction-free coding
    "folke/zen-mode.nvim",
    dependencies = { { "folke/twilight.nvim", opts = { context = 10 } } }, -- Dims inactive portions of the code you're editing.
    cmd = "ZenMode",
    opts = {
      plugins = {
        twilight = { enabled = true },
      },
    },
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
      -- wrod_diff = true,
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
      { "n", "nzz<Cmd>lua require('hlslens').start()<CR>", mode = "n", desc = "Next match", noremap = true, silent = true },
      { "N", "Nzz<Cmd>lua require('hlslens').start()<CR>", mode = "n", desc = "Previous match", noremap = true, silent = true },
      { "*", "*<Cmd>lua require('hlslens').start()<CR>", mode = "n", desc = "Next match", noremap = true, silent = true },
      { "#", "#<Cmd>lua require('hlslens').start()<CR>", mode = "n", desc = "Previous match", noremap = true, silent = true },
      { "g*", "g*<Cmd>lua require('hlslens').start()<CR>", mode = "n", desc = "Next match", noremap = true, silent = true },
      { "g#", "g#<Cmd>lua require('hlslens').start()<CR>", mode = "n", desc = "Previous match", noremap = true, silent = true },
      { "//", "<Cmd>noh<CR>", mode = "n", desc = "Clear highlight", noremap = true, silent = true },

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

  {
    -- Greeting page
    "goolord/alpha-nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VimEnter",
    config = function()
      require("alpha").setup(require("alpha.themes.dashboard").config)
    end,
  },

  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      ---@type false | "classic" | "modern" | "helix"
      preset = "modern",
      win = {
        no_overlap = false,
        title = false,
      },
      -- stylua: ignore
      spec = {
        { "<leader>cc", group = "CodeCompanion", icon = "" },
        { "<leader>d",  group = "Dap",           icon = "" },
        { "<leader>f",  group = "Telescope"                 },
        { "<leader>n",  group = "Noice"                     },
        { "<leader>w",  group = "Workspace"                 },
      },
      -- expand all nodes wighout a description
      expand = function(node)
        return not node.desc
      end,
    },
    keys = {
      -- stylua: ignore
      { "<leader>?", function() require("which-key").show({ global = false }) end, desc = "Buffer Local Keymaps (which-key)", },
    },
  },

  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "BufWinEnter",
    opts = function()
      return {
        options = {
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
        },
      }
    end,
  },

  -- {
  --   "echasnovski/mini.bufremove",
  --     -- stylua: ignore
  --     keys = {
  --       { "<leader>x", function() require("mini.bufremove").delete(0, false) end, desc = "Delete Buffer"         },
  --       { "<leader>X", function() require("mini.bufremove").delete(0, true)  end, desc = "Delete Buffer (Force)" },
  --     },
  -- },

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
    event = { "BufAdd", "FileReadPre" },
    -- stylua: ignore
    keys = {
      -- { "<leader>e" }, -- When NvimTree is loaded, also load barbar
      -- { "<leader>h", "<cmd>BufferPrevious<cr>", desc = "Previous buffer" },
      -- { "<leader>l", "<cmd>BufferNext<cr>", desc = "Next buffer" },
      -- { "<leader>x", "<cmd>BufferClose<cr>", desc = "Close buffer" },
      { "<M-h>", "<cmd>BufferPrevious<cr>", mode = { "n" }, desc = "Previous buffer" },
      { "<M-l>", "<cmd>BufferNext<cr>",     mode = { "n" }, desc = "Next buffer"     },
      { "<M-w>", "<cmd>BufferClose<cr>",    mode = { "n" }, desc = "Close buffer"    },
    },
  },

  -- {
  --   "nvim-tree/nvim-tree.lua",
  --   lazy = true,
  --   dependencies = { "nvim-tree/nvim-web-devicons" }, -- optional, for file icons
  --   -- stylua: ignore
  --   keys = {
  --     { "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Toggle nvim-tree" },
  --   },
  --   opts = {},
  -- },

  {
    "kosayoda/nvim-lightbulb",
    event = "LspAttach",
    opts = {
      autocmd = { enabled = true },
      -- virtual_text = { enabled = true },
    },
  },
  {
    "rachartier/tiny-code-action.nvim",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-telescope/telescope.nvim" },
    },
    -- stylua: ignore
    keys = {
      { "<leader>a", function() require("tiny-code-action").code_action() end, desc = "Code action", noremap = true, silent = true, },
    },
    opts = {
      --- The backend to use, currently only "vim", "delta" and "difftastic" are supported
      backend = "delta",
      backend_opts = {
        delta = {
          -- Header from delta can be quite large.
          -- You can remove them by setting this to the number of lines to remove
          header_lines_to_remove = 4,
          args = {
            "--config",
            os.getenv("HOME") .. "/.config/nvim/configs/.gitconfig",
          },
        },
      },
    },
  },

  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    lazy = true,
    cmd = "Telescope",
    opts = function()
      return {
        defaults = {
          -- Flex layout swaps between `horizontal` and `vertical` strategies based on the window width
          layout_strategy = "flex",
          layout_config = {
            width = 0.9,
            height = 0.9,
            horizontal = {
              preview_width = 0.55,
            },
            vertical = {
              preview_height = 0.6,
            },
          },
          -- laygout_config = {},
          -- wrap_results = true,
          -- prompt_prefix = " ",
          -- selection_caret = " ",
          mappings = {
            i = {
              ["<M-Down>"] = function(...)
                return require("telescope.actions").cycle_history_next(...)
              end,
              ["<M-Up>"] = function(...)
                return require("telescope.actions").cycle_history_prev(...)
              end,
              ["<C-d>"] = function(...)
                require("telescope.actions").preview_scrolling_down(...)
              end,
              ["<C-u>"] = function(...)
                require("telescope.actions").preview_scrolling_up(...)
              end,
              ["<C-h>"] = function(...)
                require("telescope.actions").preview_scrolling_left(...)
              end,
              ["<C-l>"] = function(...)
                require("telescope.actions").preview_scrolling_right(...)
              end,
              ["<M-k>"] = function(...)
                return require("telescope.actions").move_selection_previous(...)
              end,
              ["<M-j>"] = function(...)
                return require("telescope.actions").move_selection_next(...)
              end,
              ["<M-d>"] = function(...)
                require("telescope.actions").results_scrolling_down(...)
                -- require("telescope.actions").move_to_middle(...)
                require("telescope.actions").center(...)
              end,
              ["<M-u>"] = function(...)
                require("telescope.actions").results_scrolling_up(...)
                -- require("telescope.actions").move_to_middle(...)
                require("telescope.actions").center(...)
              end,
              ["<M-h>"] = function(...)
                require("telescope.actions").results_scrolling_left(...)
              end,
              ["<M-l>"] = function(...)
                require("telescope.actions").results_scrolling_right(...)
              end,
            },
            n = {
              ["q"] = function(...)
                return require("telescope.actions").close(...)
              end,
            },
          },
        },
        extensions = {
          ["fzf"] = {
            -- fuzzy = true, -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true, -- override the file sorter
            case_mode = "smart_case", -- or "ignore_case" or "respect_case", the default case_mode is "smart_case"
          },
          ["ui-select"] = {
            require("telescope.themes").get_cursor(),
          },
        },
      }
    end,
    -- stylua: ignore
    keys = {
      { "<leader>fb", "<cmd>Telescope buffers<cr>",                  desc = "Buffers" },
      { "<leader>fd", "<cmd>Telescope lsp_definitions<cr>",          desc = "Lsp definitions" },
      { "<leader>ff", "<cmd>Telescope find_files<cr>",               desc = "Find files" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>",                desc = "Live grep" },
      { "<leader>fh", "<cmd>Telescope help_tags<cr>",                desc = "Help tags" },
      { "<leader>fk", "<cmd>Telescope keymaps<cr>",                  desc = "Keymaps" },
      { "<leader>fq", "<cmd>Telescope quickfix<cr>",                 desc = "Quick fix" },
      { "<leader>fr", "<cmd>Telescope registers<cr>",                desc = "Registers" },
      -- { "<leader>fc", "<cmd>Telescope colorscheme<cr>",           desc = "Colorscheme" },
      { "<leader>fc", "<cmd>Telescope highlights<cr>",               desc = "Highlights" },
      { "<leader>fm", "<cmd>Telescope noice<cr>",                    desc = "Noice message history" },
      { "<leader>fn", "<cmd>Telescope notify<cr>",                   desc = "Notify message history" },
      { "<leader>fs", "<cmd>Telescope lsp_document_symbols<cr>",     desc = "Document symbols" },
      -- { "<leader>fs", "<cmd>Telescope lsp_workspace_symbols<cr>", desc = "Workspace symbols" },
    },
    config = function(_, opts)
      require("telescope").setup(opts)

      require("telescope").load_extension("fzf")
      require("telescope").load_extension("ui-select")
      require("telescope").load_extension("noice")
      require("telescope").load_extension("notify")
    end,
  },

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
      { "<leader>nl", function() require("noice").cmd("last")    end, desc = "noice last message" },
      { "<leader>nh", function() require("noice").cmd("history") end, desc = "noice history"      },
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

  {
    -- A fancy, configurable, notification manager for NeoVim
    "rcarriga/nvim-notify",
    opts = {
      -- render = "compact",
      -- stages = "fade",
      fps = 60,
      timeout = 3000,
      max_height = function()
        return math.floor(vim.o.lines * 0.5)
      end,
      max_width = function()
        return math.floor(vim.o.columns * 0.5)
      end,
    },
    config = function(_, opts)
      local notify = require("notify")
      vim.notify = notify
      print = function(...)
        local print_safe_args = {}
        local args = { ... }
        for i = 1, #args do
          table.insert(print_safe_args, tostring(args[i]))
        end
        notify(table.concat(print_safe_args, "\n"), vim.log.levels.INFO, {
          title = "Print results",
          icon = "󰐪",
        })
      end

      notify.setup(opts)
    end,
  },

  -- Forgot why installing this plugin. Uninstalling it seems no change
  -- {
  --   "stevearc/dressing.nvim",
  --   lazy = true,
  --   init = function()
  --     ---@diagnostic disable-next-line: duplicate-set-field
  --     vim.ui.select = function(...)
  --       require("lazy").load({ plugins = { "dressing.nvim" } })
  --       return vim.ui.select(...)
  --     end
  --     ---@diagnostic disable-next-line: duplicate-set-field
  --     vim.ui.input = function(...)
  --       require("lazy").load({ plugins = { "dressing.nvim" } })
  --       return vim.ui.input(...)
  --     end
  --   end,
  -- },

  -- { "Bekaboo/dropbar.nvim" },
}
