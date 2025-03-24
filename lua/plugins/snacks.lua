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
      scope = { enabled = true },
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

      explorer = { enabled = false },
      lazygit = {
        enabled = true,
        configure = false,
      },
      terminal = {
        enabled = true,
        keys = {},
      },
      scratch = { enabled = false },
      indent = { enabled = false },

      input = { enabled = true },
      picker = {
        enabled = true,
        previewers = {
          diff = {
            builtin = false, -- use Neovim for previewing diffs (true) or use an external tool (false)
            cmd = { "delta" }, -- example to show a diff with delta
          },
          git = {
            builtin = false, -- use Neovim for previewing git output (true) or use git (false)
            args = {}, -- additional arguments passed to the git command. Useful to set pager options usin `-c ...`
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
          reverse = true,
          layout = {
            box = "horizontal",
            backdrop = false,
            width = 0.8,
            height = 0.9,
            border = "none",
            {
              box = "vertical",
              { win = "list", title = " Results ", title_pos = "center", border = "rounded" },
              { win = "input", height = 1, border = "rounded", title = "{title} {live} {flags}", title_pos = "center" },
            },
            {
              win = "preview",
              title = "{preview:Preview}",
              width = 0.45,
              border = "rounded",
              title_pos = "center",
            },
          },
        },
      },
      scroll = { enabled = false },
      words = { enabled = true },
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
      -- Toggle
      { "<leader>st", function() require("snacks").toggle() end, desc = "[Snack] Toggles" },
      -- Top Pickers & Explorer
      { "<leader><space>", function() require("snacks").picker.smart() end, desc = "Smart Find Files" },
      { "<leader>,", function() require("snacks").picker.buffers() end, desc = "Buffers" },
      { "<leader>sn", function() require("snacks").picker.notifications() end, desc = "Notification History" },
      -- { "<leader>e", function() require("snacks").explorer() end, desc = "File Explorer" },
      -- find
      { "<leader>sb", function() require("snacks").picker.buffers() end, desc = "Buffers" },
      -- { "<leader>sc", function() require("snacks").picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find Config File" },
      { "<leader>sf", function() require("snacks").picker.files() end, desc = "Find Files" },
      -- { "<leader>fg", function() require("snacks").picker.git_files() end, desc = "Find Git Files" },
      { "<leader>sp", function() require("snacks").picker.projects() end, desc = "Projects" },
      { "<leader>sr", function() require("snacks").picker.recent() end, desc = "Recent" },
      -- git
      { "<leader>gb", function() require("snacks").picker.git_branches() end, desc = "Git Branches" },
      { "<leader>gl", function() require("snacks").picker.git_log() end, desc = "Git Log" },
      { "<leader>gL", function() require("snacks").picker.git_log_line() end, desc = "Git Log Line" },
      { "<leader>gs", function() require("snacks").picker.git_status() end, desc = "Git Status" },
      { "<leader>gS", function() require("snacks").picker.git_stash() end, desc = "Git Stash" },
      { "<leader>gd", function() require("snacks").picker.git_diff() end, desc = "Git Diff (Hunks)" },
      { "<leader>gf", function() require("snacks").picker.git_log_file() end, desc = "Git Log File" },
      -- Grep
      -- { "<leader>sb", function() require("snacks").picker.lines() end, desc = "Buffer Lines" },
      -- { "<leader>sB", function() require("snacks").picker.grep_buffers() end, desc = "Grep Open Buffers" },
      { "<leader>sg", function() require("snacks").picker.grep() end, desc = "Grep" },
      -- { "<leader>sw", function() require("snacks").picker.grep_word() end, desc = "Visual selection or word", mode = { "n", "x" } },
      -- search
      { '<leader>s"', function() require("snacks").picker.registers() end, desc = "Registers" },
      { '<leader>s/', function() require("snacks").picker.search_history() end, desc = "Search History" },
      { "<leader>sa", function() require("snacks").picker.autocmds() end, desc = "Autocmds" },
      -- { "<leader>sb", function() require("snacks").picker.lines() end, desc = "Buffer Lines" },
      { "<leader>s:", function() require("snacks").picker.command_history() end, desc = "Command History" },
      { "<leader>sc", function() require("snacks").picker.commands() end, desc = "Commands" },
      { "<leader>sd", function() require("snacks").picker.diagnostics() end, desc = "Diagnostics" },
      { "<leader>sD", function() require("snacks").picker.diagnostics_buffer() end, desc = "Buffer Diagnostics" },
      { "<leader>sH", function() require("snacks").picker.help() end, desc = "Help Pages" },
      { "<leader>sh", function() require("snacks").picker.highlights() end, desc = "Highlights" },
      { "<leader>sI", function() require("snacks").picker.icons() end, desc = "Icons" },
      { "<leader>sj", function() require("snacks").picker.jumps() end, desc = "Jumps" },
      { "<leader>sk", function() require("snacks").picker.keymaps() end, desc = "Keymaps" },
      { "<leader>sl", function() require("snacks").picker.loclist() end, desc = "Location List" },
      { "<leader>sm", function() require("snacks").picker.marks() end, desc = "Marks" },
      { "<leader>sM", function() require("snacks").picker.man() end, desc = "Man Pages" },
      { "<leader>sp", function() require("snacks").picker.lazy() end, desc = "Search for Plugin Spec" },
      { "<leader>sq", function() require("snacks").picker.qflist() end, desc = "Quickfix List" },
      { "<leader>sr", function() require("snacks").picker.resume() end, desc = "Resume" },
      { "<leader>su", function() require("snacks").picker.undo() end, desc = "Undo History" },
      -- { "<leader>sC", function() require("snacks").picker.colorschemes() end, desc = "Colorschemes" },
      -- LSP
      { "gd", function() require("snacks").picker.lsp_definitions() end, desc = "Goto Definition" },
      { "gD", function() require("snacks").picker.lsp_declarations() end, desc = "Goto Declaration" },
      { "gr", function() require("snacks").picker.lsp_references() end, desc = "References" },
      { "gI", function() require("snacks").picker.lsp_implementations() end, desc = "Goto Implementation" },
      { "gy", function() require("snacks").picker.lsp_type_definitions() end, desc = "Goto T[y]pe Definition" },
      { "<leader>ss", function() require("snacks").picker.lsp_symbols() end, desc = "LSP Symbols" },
      { "<leader>sS", function() require("snacks").picker.lsp_workspace_symbols() end, desc = "LSP Workspace Symbols" },
      -- Other
      { "<leader>z",  function() require("snacks").zen() end, desc = "Toggle Zen Mode" },
      { "<leader>Z",  function() require("snacks").zen.zoom() end, desc = "Toggle Zoom" },
      -- { "<leader>.",  function() require("snacks").scratch() end, desc = "Toggle Scratch Buffer" },
      -- { "<leader>S",  function() require("snacks").scratch.select() end, desc = "Select Scratch Buffer" },
      { "<leader>n",  function() require("snacks").notifier.show_history() end, desc = "Notification History" },
      { "<M-w>", function() require("snacks").bufdelete() end, desc = "Delete Buffer" },
      { "<leader>sR", function() require("snacks").rename.rename_file() end, desc = "Rename File" },
      -- { "<leader>gB", function() require("snacks").gitbrowse() end, desc = "Git Browse", mode = { "n", "v" } },
      { "<C-g>", function() require("snacks").lazygit() end, desc = "Lazygit" },
      { "<leader>un", function() require("snacks").notifier.hide() end, desc = "Dismiss All Notifications" },
      { "<A-i>",      function() require("snacks").terminal() end, desc = "Toggle terminal", mode = {"n", "t"} },
      { "]]",         function() require("snacks").words.jump(vim.v.count1) end, desc = "Next Reference", mode = { "n", "t" } },
      { "[[",         function() require("snacks").words.jump(-vim.v.count1) end, desc = "Prev Reference", mode = { "n", "t" } },
      { "<leader>si",         function() require("snacks").image.hover() end, desc = "Display Image", mode = { "n"  } },
    },
    -- config = function(_, opts)
    --   require("snacks").setup(opts)
    --
    -- end,
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
          Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
          Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
          Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
          Snacks.toggle.diagnostics():map("<leader>ud")
          Snacks.toggle.line_number():map("<leader>ul")
          Snacks.toggle
            .option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 })
            :map("<leader>uc")
          Snacks.toggle.treesitter():map("<leader>uT")
          Snacks.toggle.inlay_hints():map("<leader>uh")
          Snacks.toggle.indent():map("<leader>ug")
          Snacks.toggle.dim():map("<leader>uD")

          vim.keymap.del("n", "grn")
          vim.keymap.del("n", "gra")
          vim.keymap.del("n", "grr")
          vim.keymap.del("n", "gri")
        end,
      })
    end,
  },
}
