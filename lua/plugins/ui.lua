return {
  -- Show colors in the text: e.g. "#b3e2a7"
  {
    "norcalli/nvim-colorizer.lua",
    opts = {},
    config = function(_)
      require("colorizer").setup()
    end,
  },

  {
    "lewis6991/gitsigns.nvim",
    opts = {
      signcolumn = false,
      numhl = true,
      current_line_blame = true,
    },
    config = function(_, opts)
      require("gitsigns").setup(opts)
      require("scrollbar.handlers.gitsigns").setup()
    end,
  },

  {
    -- Conflicted with vscode_nvim, don't know why
    "kevinhwang91/nvim-hlslens",
    keys = { "n", "N", "/", "?" },
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
      win = { title = false },
      spec = {
        { "<leader>f", group = "Telescope" },
      },
    },
    keys = {
      -- stylua: ignore
      { "<leader>?", function() require("which-key").show({ global = false }) end, desc = "Buffer Local Keymaps (which-key)", },
    },
  },

  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = function()
      local colorscheme = require("colorscheme")
      return {
        options = {
          icons_enabled = true,
          theme = colorscheme,
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
          disabled_filetypes = {
            statusline = {},
            winbar = {},
          },
          ignore_focus = {},
          always_divide_middle = true,
          globalstatus = false,
          refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
          },
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

  -- This repository has been archived by the owner on Aug 18, 2023. It is now read-only.
  -- {
  --   "kdheepak/tabline.nvim",
  --   lazy = false,
  --   dependencies = { "nvim-tree/nvim-web-devicons" },
  --   opts = {},
  --   -- stylua: ignore
  --   keys = {
  --     { "<leader>l", "<cmd>TablineBufferNext<cr>",     desc = "next buffer"     },
  --     { "<leader>h", "<cmd>TablineBufferPrevious<cr>", desc = "previous buffer" },
  --   },
  --   config = function(_, opts)
  --     require("tabline").setup(opts)
  --
  --     vim.cmd([[
  --       set guioptions-=e " Use showtabline in gui vim
  --       set sessionoptions+=tabpages,globals " store tabpages and globals in session
  --     ]])
  --   end,
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
    },
    event = { "BufAdd", "FileReadPre" },
    keys = {
      { "<leader>h", "<cmd>BufferPrevious<cr>", desc = "Next buffer" },
      { "<leader>l", "<cmd>BufferNext<cr>", desc = "Previous buffer" },
      { "<leader>x", "<cmd>BufferClose<cr>", desc = "Close buffer" },
    },
  },

  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" }, -- optional, for file icons
    -- stylua: ignore
    keys = {
      { "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Toggle nvim-tree" },
    },
    opts = {},
  },

  {
    "numToStr/FTerm.nvim",
    -- stylua: ignore
    keys = {
      { "<A-i>", '<CMD>lua require("FTerm").toggle()<CR>',            mode = "n", desc = "Toggle float terminal" },
      { "<A-i>", '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>', mode = "t", desc = "Toggle float terminal" },
      { "<C-g>",                                                      mode = "n", desc = "Toggle Lazygit" },
    },
    opts = {
      border = "rounded",
      dimensions = {
        height = 0.9,
        width = 0.9,
      },
    },
    init = function()
      local fterm = require("FTerm")
      local lg = fterm:new({
        ft = "lazygit",
        cmd = "lazygit --use-config-file=$HOME/.config/lazygit/config.yml",
        dimensions = {
          height = 0.9,
          width = 0.9,
        },
      })
      -- Use this to toggle lazygit in a floating terminal
      vim.keymap.set("n", "<C-g>", function()
        lg:toggle()
      end)
    end,
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
              ["<M-k>"] = function(...)
                return require("telescope.actions").move_selection_previous(...)
              end,
              ["<M-j>"] = function(...)
                return require("telescope.actions").move_selection_next(...)
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
      { "<leader>fb", "<cmd>Telescope buffers<cr>",                  desc = "buffers" },
      { "<leader>fd", "<cmd>Telescope lsp_definitions<cr>",          desc = "lsp definitions" },
      { "<leader>ff", "<cmd>Telescope find_files<cr>",               desc = "find files" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>",                desc = "live grep" },
      { "<leader>fh", "<cmd>Telescope help_tags<cr>",                desc = "help tags" },
      { "<leader>fk", "<cmd>Telescope keymaps<cr>",                  desc = "keymaps" },
      { "<leader>fq", "<cmd>Telescope quickfix<cr>",                 desc = "quick fix" },
      { "<leader>fr", "<cmd>Telescope registers<cr>",                desc = "registers" },
      -- { "<leader>fc", "<cmd>Telescope colorscheme<cr>",              desc = "colorscheme" },
      { "<leader>fc", "<cmd>Telescope highlights<cr>",               desc = "highlights" },
      { "<leader>fm", "<cmd>Telescope noice<cr>",                    desc = "noice message history" },
      { "<leader>fn", "<cmd>Telescope notify<cr>",                   desc = "notify message history" },
      { "<leader>fs", "<cmd>Telescope lsp_document_symbols<cr>",     desc = "document symbols" },
      -- { "<leader>fs", "<cmd>Telescope lsp_workspace_symbols<cr>", desc = "workspace symbols" },
      -- Set in lspconfig
      -- { "<leader>a", function() vim.lsp.buf.code_action() end,       desc = "code action" },
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
      -- background_colour = "#282828",
      timeout = 3000,
      max_height = function()
        return math.floor(vim.o.lines * 0.5)
      end,
      max_width = function()
        return math.floor(vim.o.columns * 0.5)
      end,
    },
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
