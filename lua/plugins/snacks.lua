return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      bigfile = { enabled = true },
      quickfile = { enabled = true },
      dashboard = { enabled = true },
      -- Keymaps: ii and ai for textobject, [i and ]i for jump
      notifier = {
        enabled = true,
        style = "notification",
      },

      statuscolumn = {
        enabled = true,
        left = { "sign", "mark" }, -- priority of signs on the left (high to low)
        right = { "fold", "git" }, -- priority of signs on the right (high to low) },
      },

      -- Show images in the file
      image = {
        enabled = true,
        doc = { inline = false, float = false, max_width = 80, max_height = 40 },
        math = { latex = { font_size = "small" } },
      },

      explorer = { enabled = true },
      lazygit = {
        enabled = true,
        configure = false,
      },
      terminal = {
        enabled = true,
        keys = {},
      },
      scratch = { enabled = false },
      indent = {
        indent = {
          enabled = false,
          priority = 100,
        },
        scope = {
          enabled = false,
          underline = true,
        },
        animate = {
          enabled = false,
        },
      },

      input = { enabled = true },
      picker = {
        enabled = true,
        sources = {
          explorer = {
            follow_file = false,
            layout = {
              reverse = false,
              preview = "main",
              -- preview = true,
              layout = {
                backdrop = false,
                width = 30,
                min_width = 40,
                height = 0,
                position = "left",
                border = "none",
                box = "vertical",
                {
                  win = "input",
                  height = 1,
                  border = "rounded",
                  title = "{title} {live} {flags}",
                  title_pos = "center",
                },
                { win = "list", border = "none" },
                { win = "preview", title = "{preview}", height = 0.4, border = "top" },
              },
            },
            win = {
              list = {
                keys = {
                  ["<BS>"] = "explorer_up",
                  ["o"] = "confirm",
                  ["l"] = "confirm",
                  ["h"] = "explorer_close", -- close directory
                  ["a"] = "explorer_add",
                  ["d"] = "explorer_del",
                  ["r"] = "explorer_rename",
                  ["c"] = "explorer_copy",
                  ["m"] = "explorer_move",
                  ["O"] = "explorer_open", -- open with system application
                  ["P"] = "toggle_preview",
                  ["y"] = { "explorer_yank", mode = { "n", "x" } },
                  ["p"] = "explorer_paste",
                  ["u"] = "explorer_update",
                  ["<c-c>"] = "tcd",
                  ["<leader>/"] = "picker_grep",
                  ["<c-t>"] = "terminal",
                  ["."] = "explorer_focus",
                  ["I"] = "toggle_ignored",
                  ["H"] = "toggle_hidden",
                  ["Z"] = "explorer_close_all",
                  ["]g"] = "explorer_git_next",
                  ["[g"] = "explorer_git_prev",
                  ["]d"] = "explorer_diagnostic_next",
                  ["[d"] = "explorer_diagnostic_prev",
                  ["]w"] = "explorer_warn_next",
                  ["[w"] = "explorer_warn_prev",
                  ["]e"] = "explorer_error_next",
                  ["[e"] = "explorer_error_prev",
                },
              },
            },
          },
        },
        previewers = {
          diff = {
            builtin = false, -- use Neovim for previewing diffs (true) or use an external tool (false)
            cmd = { "delta" }, -- example to show a diff with delta
          },
          git = {
            builtin = false, -- use Neovim for previewing git output (true) or use git (false)
            args = {}, -- additional arguments passed to the git command. Useful to set pager options using `-c ...`
          },
        },
        win = {
          input = {
            keys = {
              ["<A-Up>"] = { "history_back", mode = { "n", "i" } },
              ["<A-Down>"] = { "history_forward", mode = { "n", "i" } },

              ["<A-j>"] = { "list_down", mode = { "n", "i" } },
              ["<A-k>"] = { "list_up", mode = { "n", "i" } },

              ["<C-u>"] = { "preview_scroll_up", mode = { "n", "i" } },
              ["<C-d>"] = { "preview_scroll_down", mode = { "n", "i" } },

              ["<A-u>"] = { "list_scroll_up", mode = { "n", "i" } },
              ["<A-d>"] = { "list_scroll_down", mode = { "n", "i" } },

              ["<c-j>"] = {},
              ["<c-k>"] = {},
            },
          },
        },
        layout = {
          preset = "telescope",
        },
        layouts = {
          select = {
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
              { win = "list", border = "none" },
            },
          },
        },
      },
      scroll = { enabled = false },
      words = { enabled = false },
      toggle = { enabled = true },
      styles = {
        terminal = {
          relative = "editor",
          border = "rounded",
          position = "float",
          backdrop = 60,
          height = 0.9,
          width = 0.9,
          zindex = 50,
        },
      },
    },
    -- stylua: ignore
    keys = {
      -- Top Pickers & Explorer
      { "<leader><space>", function() require("snacks").picker.smart() end,         desc = "[Snacks] Smart Find Files" },
      { "<leader>,",       function() require("snacks").picker.buffers() end,       desc = "[Snacks] Buffers" },
      { "<leader>sn",      function() require("snacks").picker.notifications() end, desc = "[Snacks] Notification History" },
      { "<leader>e",       function() require("snacks").explorer.reveal() end,      desc = "[Snacks] File Explorer" },
      -- find
      { "<leader>sb",    function() require("snacks").picker.buffers() end,                                 desc = "[Snacks] Buffers" },
      -- { "<leader>sc", function() require("snacks").picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "[Snacks] Find Config File" },
      { "<leader>sf",    function() require("snacks").picker.files() end,                                   desc = "[Snacks] Find Files" },
      -- { "<leader>fg", function() require("snacks").picker.git_files() end,                               desc = "[Snacks] Find Git Files" },
      { "<leader>sp",    function() require("snacks").picker.projects() end,                                desc = "[Snacks] Projects" },
      { "<leader>sr",    function() require("snacks").picker.recent() end,                                  desc = "[Snacks] Recent" },
      -- git
      { "<leader>gb", function() require("snacks").picker.git_branches() end, desc = "[Snacks] Git Branches" },
      { "<leader>gl", function() require("snacks").picker.git_log() end,      desc = "[Snacks] Git Log" },
      { "<leader>gL", function() require("snacks").picker.git_log_line() end, desc = "[Snacks] Git Log Line" },
      { "<leader>gs", function() require("snacks").picker.git_status() end,   desc = "[Snacks] Git Status" },
      { "<leader>gS", function() require("snacks").picker.git_stash() end,    desc = "[Snacks] Git Stash" },
      { "<leader>gd", function() require("snacks").picker.git_diff() end,     desc = "[Snacks] Git Diff (Hunks)" },
      { "<leader>gf", function() require("snacks").picker.git_log_file() end, desc = "[Snacks] Git Log File" },
      -- Grep
      -- { "<leader>sb", function() require("snacks").picker.lines() end,        desc = "[Snacks] Buffer Lines" },
      -- { "<leader>sB", function() require("snacks").picker.grep_buffers() end, desc = "[Snacks] Grep Open Buffers" },
      { "<leader>sg",    function() require("snacks").picker.grep() end,         desc = "[Snacks] Grep" },
      -- { "<leader>sw", function() require("snacks").picker.grep_word() end,    desc = "[Snacks] Visual selection or word", mode = { "n", "x" } },
      -- search
      { '<leader>s"',    function() require("snacks").picker.registers() end,          desc = "[Snacks] Registers" },
      { '<leader>s/',    function() require("snacks").picker.search_history() end,     desc = "[Snacks] Search History" },
      { "<leader>sa",    function() require("snacks").picker.autocmds() end,           desc = "[Snacks] Autocmds" },
      -- { "<leader>sb", function() require("snacks").picker.lines() end,              desc = "[Snacks] Buffer Lines" },
      { "<leader>s:",    function() require("snacks").picker.command_history() end,    desc = "[Snacks] Command History" },
      { "<leader>sc",    function() require("snacks").picker.commands() end,           desc = "[Snacks] Commands" },
      { "<leader>sd",    function() require("snacks").picker.diagnostics() end,        desc = "[Snacks] Diagnostics" },
      { "<leader>sD",    function() require("snacks").picker.diagnostics_buffer() end, desc = "[Snacks] Buffer Diagnostics" },
      { "<leader>sH",    function() require("snacks").picker.help() end,               desc = "[Snacks] Help Pages" },
      { "<leader>sh",    function() require("snacks").picker.highlights() end,         desc = "[Snacks] Highlights" },
      { "<leader>sI",    function() require("snacks").picker.icons() end,              desc = "[Snacks] Icons" },
      { "<leader>sj",    function() require("snacks").picker.jumps() end,              desc = "[Snacks] Jumps" },
      { "<leader>sk",    function() require("snacks").picker.keymaps() end,            desc = "[Snacks] Keymaps" },
      { "<leader>sl",    function() require("snacks").picker.loclist() end,            desc = "[Snacks] Location List" },
      { "<leader>sm",    function() require("snacks").picker.marks() end,              desc = "[Snacks] Marks" },
      { "<leader>sM",    function() require("snacks").picker.man() end,                desc = "[Snacks] Man Pages" },
      { "<leader>sp",    function() require("snacks").picker.lazy() end,               desc = "[Snacks] Search for Plugin Spec" },
      { "<leader>sq",    function() require("snacks").picker.qflist() end,             desc = "[Snacks] Quickfix List" },
      { "<leader>sr",    function() require("snacks").picker.resume() end,             desc = "[Snacks] Resume" },
      { "<leader>su",    function() require("snacks").picker.undo() end,               desc = "[Snacks] Undo History" },
      -- { "<leader>sC", function() require("snacks").picker.colorschemes() end,       desc = "[Snacks] Colorschemes" },
      -- LSP
      { "gd",         function() require("snacks").picker.lsp_definitions() end,       desc = "[Snacks] Goto Definition" },
      { "gD",         function() require("snacks").picker.lsp_declarations() end,      desc = "[Snacks] Goto Declaration" },
      { "gr",         function() require("snacks").picker.lsp_references() end,        desc = "[Snacks] References" },
      { "gI",         function() require("snacks").picker.lsp_implementations() end,   desc = "[Snacks] Goto Implementation" },
      { "gy",         function() require("snacks").picker.lsp_type_definitions() end,  desc = "[Snacks] Goto T[y]pe Definition" },
      { "<leader>ss", function() require("snacks").picker.lsp_symbols() end,           desc = "[Snacks] LSP Symbols" },
      { "<leader>sS", function() require("snacks").picker.lsp_workspace_symbols() end, desc = "[Snacks] LSP Workspace Symbols" },
      -- Other
      { "<leader>z",     function() require("snacks").zen() end,                     desc = "[Snacks] Toggle Zen Mode" },
      { "<leader>Z",     function() require("snacks").zen.zoom() end,                desc = "[Snacks] Toggle Zoom" },
      -- { "<leader>.",  function() require("snacks").scratch() end,                 desc = "[Snacks] Toggle Scratch Buffer" },
      -- { "<leader>S",  function() require("snacks").scratch.select() end,          desc = "[Snacks] Select Scratch Buffer" },
      { "<leader>n",     function() require("snacks").notifier.show_history() end,   desc = "[Snacks] Notification History" },
      { "<M-w>",         function() require("snacks").bufdelete() end,               desc = "[Snacks] Delete Buffer" },
      { "<leader>sR",    function() require("snacks").rename.rename_file() end,      desc = "[Snacks] Rename File" },
      -- { "<leader>gB", function() require("snacks").gitbrowse() end,               desc = "[Snacks] Git Browse",               mode = { "n", "v" } },
      { "<C-g>",         function() require("snacks").lazygit() end,                 desc = "[Snacks] Lazygit" },
      { "<leader>un",    function() require("snacks").notifier.hide() end,           desc = "[Snacks] Dismiss All Notifications" },
      { "<A-i>",         function() require("snacks").terminal() end,                desc = "[Snacks] Toggle terminal", mode = {"n",  "t"} },
      { "]]",            function() require("snacks").words.jump(vim.v.count1) end,  desc = "[Snacks] Next Reference",  mode = { "n", "t" } },
      { "[[",            function() require("snacks").words.jump(-vim.v.count1) end, desc = "[Snacks] Prev Reference",  mode = { "n", "t" } },
      { "<leader>si",    function() require("snacks").image.hover() end,             desc = "[Snacks] Display Image",   mode = { "n"  } },
    },

    config = function(_, opts)
      require("snacks").setup(opts)

      vim.api.nvim_set_hl(0, "SnacksPickerListCursorLine", { bg = "#313244" })
    end,

    init = function()
      vim.api.nvim_create_autocmd("User", {
        pattern = "VeryLazy",
        callback = function()
          local Snacks = require("snacks")
          -- Setup some globals for debugging (lazy-loaded)
          _G.dd = function(...)
            Snacks.debug.inspect(...)
          end
          _G.bt = function()
            Snacks.debug.backtrace()
          end
          vim.print = _G.dd -- Override print to use snacks for `:=` command

          -- Create some toggle mappings
          Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>ts")
          Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>tw")
          Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>tL")
          Snacks.toggle.diagnostics():map("<leader>td")
          Snacks.toggle.line_number():map("<leader>tl")
          Snacks.toggle
            .option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 })
            :map("<leader>tc")
          Snacks.toggle.treesitter():map("<leader>tT")
          Snacks.toggle.inlay_hints():map("<leader>th")
          Snacks.toggle.inlay_hints():map("<leader>h")
          Snacks.toggle.indent():map("<leader>tg")
          Snacks.toggle.dim():map("<leader>tD")

          vim.keymap.del("n", "grn")
          vim.keymap.del("n", "gra")
          vim.keymap.del("n", "grr")
          vim.keymap.del("n", "gri")
        end,
      })
    end,
  },
}
