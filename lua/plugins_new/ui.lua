return {
  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      -- require("colorizer").setup()
    end,
  },

  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()
    end,
  },
  {
    "kevinhwang91/nvim-hlslens",
    config = function()
      require("hlslens").setup({
        -- auto_enable = false,
        -- calm_down = true,
        nearest_only = true,
        -- nearest_float_when = "always",
        -- override_lens = function() end,
      })
    end,
  }, -- Conflicted with vscode_nvim, don't know way
  {
    "petertriho/nvim-scrollbar",
    config = function()
      -- require("scrollbar.handlers.search").setup({ nearest_only = true })
      require("scrollbar.handlers.gitsigns").setup()
      require("scrollbar").setup({
        handle = {
          text = " ",
          blend = 60, -- Integer between 0 and 100. 0 for fully opaque and 100 to full transparent. Defaults to 30.
          color = nil,
          color_nr = nil, -- cterm
          -- highlight = "StatusLineNC",
          highlight = "CursorLine",
          hide_if_all_visible = true, -- Hides handle if all lines are visible
        },
      })
    end,
  },

  -- use({ "edluffy/specs.nvim", config = require("plugin-settings.specs") })

  {
    "goolord/alpha-nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VimEnter",
    opts = require("alpha.themes.startify").config,
  },

  {
    "folke/which-key.nvim",
    opts = {},
  },
  {
    "ellisonleao/gruvbox.nvim",
    lazy = false,
    config = function()
      local opts = {
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
      }
      -- require("gruvbox").setup({italic = {comments = false}})
      require("gruvbox").setup(opts)

      vim.o.background = "dark" -- or "light" for light mode
      -- vim.cmd([[colorscheme gruvbox]])
      vim.cmd([[colorscheme gruvbox]])
      vim.cmd([[colorscheme gruvbox]])
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons", lazy = true },
    opts = {
      options = {
        icons_enabled = true,
        theme = "gruvbox",
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
    },
  },
  {
    "kdheepak/tabline.nvim",
    dependencies = { { "nvim-lualine/lualine.nvim", lazy = true }, { "nvim-tree/nvim-web-devicons", lazy = true } },
    config = function()
      opts = {
        -- Defaults configuration options
        enable = true,
        options = {
          -- If lualine is installed tabline will use separators configured in lualine by default.
          -- These options can be used to override those settings.
          section_separators = { "", "" },
          component_separators = { "", "" },
          max_bufferline_percent = 66, -- set to nil by default, and it uses vim.o.columns * 2/3
          show_tabs_always = false, -- this shows tabs only when there are more than one tab or if the first tab is named
          show_devicons = true, -- this shows devicons in buffer section
          show_bufnr = false, -- this appends [bufnr] to buffer section,
          show_filename_only = false, -- shows base filename only instead of relative path in filename
          modified_icon = "+ ", -- change the default modified icon
          modified_italic = false, -- set to true by default; this determines whether the filename turns italic if modified
          show_tabs_only = false, -- this shows only tabs instead of tabs + buffers
        },
      }
      require("tabline").setup(opts)
      vim.cmd([[
        set guioptions-=e " Use showtabline in gui vim
        set sessionoptions+=tabpages,globals " store tabpages and globals in session
      ]])

      -- vim.keymap.set('n', '<TAB>', '<CMD>TablineBufferNext<CR>')
      -- vim.keymap.set('n', '<S-TAB>', '<CMD>TablineBufferPrevious<CR>')

      vim.keymap.set("n", "<leader>l", "<CMD>TablineBufferNext<CR>")
      vim.keymap.set("n", "<leader>h", "<CMD>TablineBufferPrevious<CR>")

      -- vim.keymap.set('n', '<C-L>', '<CMD>TablineBufferNext<CR>')
      -- vim.keymap.set('n', '<C-H>', '<CMD>TablineBufferPrevious<CR>')

      vim.keymap.set("n", "<leader>x", "<CMD>Bdelete<CR>")
    end,
  },

  {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
      "nvim-tree/nvim-web-devicons", -- optional, for file icons
    },
    config = function()
      require("nvim-tree").setup()

      -- vim.keymap.set('n', '<C-n>', '<CMD> NvimTreeToggle <CR>')
      -- vim.keymap.set('n', '<leader>e', '<CMD> NvimTreeFocus <CR>')
      vim.keymap.set("n", "<leader>e", "<CMD> NvimTreeToggle <CR>")
    end,
  },
  {
    "numToStr/FTerm.nvim",
    keys = {
      { "<A-i>", '<CMD>lua require("FTerm").toggle()<CR>', mode = "n", desc = "Toggle float terminal" },
      { "<A-i>", '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>', mode = "t", desc = "Toggle float terminal" },
      { "<C-g>", mode = "n", desc = "Toggle lazygit" },
    },
    opts = {
      border = "double",
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
    "cappyzawa/trim.nvim",
  },

  {
    "nvim-telescope/telescope.nvim",
    version = "0.1.1",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    lazy = true,
    cmd = "Telescope",
    opts = {
      extensions = {
        ["fzf"] = {
          fuzzy = true, -- false will only do exact matching
          override_generic_sorter = true, -- override the generic sorter
          override_file_sorter = true, -- override the file sorter
          case_mode = "smart_case", -- or "ignore_case" or "respect_case", the default case_mode is "smart_case"
        },
        ["ui-select"] = {
          require("telescope.themes").get_cursor(),
        },
      },
    },
    keys = {
      { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "buffers" },
      { "<leader>fd", "<cmd>Telescope lsp_definitions<cr>", desc = "lsp definitions" },
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "find files" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "live grep" },
      { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "help tags" },
      { "<leader>fk", "<cmd>Telescope keymaps<cr>", desc = "keymaps" },
      { "<leader>fq", "<cmd>Telescope quickfix<cr>", desc = "quick fix" },
      { "<leader>fr", "<cmd>Telescope registers<cr>", desc = "registers" },
      { "<leader>fm", "<cmd>Telescope noice<cr>", desc = "noice message history" },
      {
        "<leader>a",
        function()
          vim.lsp.buf.code_action()
        end,
        desc = "code action",
      },
    },
    config = function(_, opts)
      require("telescope").setup(opts)

      require("telescope").load_extension("fzf")
      require("telescope").load_extension("ui-select")
      require("telescope").load_extension("noice")
    end,
  },

  {
    "folke/noice.nvim",
    lazy = false,
    keys = {
      {
        "<leader>nl",
        function()
          require("noice").cmd("last")
        end,
        desc = "noice last message",
      },
      {
        "<leader>nh",
        function()
          require("noice").cmd("history")
        end,
        desc = "noice history",
      },
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
        bottom_search = true, -- use a classic bottom cmdline for search
        command_palette = true, -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false, -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = false, -- add a border to hover docs and signature help
      },
    },
    config = function(_, opts)
      require("noice").setup(opts)
    end,
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      { "rcarriga/nvim-notify", opts = { background_colour = "#282828" } },
    },
  },
}
