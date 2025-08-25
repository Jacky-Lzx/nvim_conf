return {
  {
    "michaelb/sniprun",
    branch = "master",

    build = "sh install.sh",
    -- do 'sh install.sh 1' if you want to force compile locally
    -- (instead of fetching a binary from the github release). Requires Rust >= 1.65
    opts = {},
  },

  {
    "stevearc/overseer.nvim",
    keys = {
      -- Shift+F5
      { "<F17>", "<CMD>OverseerRun<CR>", desc = "[Overseer] Run" },
      { "<leader>or", "<CMD>OverseerRun<CR>", desc = "[Overseer] Run" },
      -- typos: ignore
      { "<leader>ot", "<CMD>OverseerToggle<CR>", desc = "[Overseer] Toggle" }, -- codespell:ignore ot
    },
    cmd = "OverseerRun",
    opts = {
      template_dirs = { "templates.overseer" },
      templates = {
        "builtin",
        "user.convert_md_to_pdf",
        "user.verilog",
        "user.python",
      },
      task_list = {
        -- Width dimensions can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
        -- min_width and max_width can be a single value or a list of mixed integer/float types.
        -- max_width = {100, 0.2} means "the lesser of 100 columns or 20% of total"
        max_width = { 100, 0.2 },
        -- min_width = {40, 0.1} means "the greater of 40 columns or 10% of total"
        min_width = { 40, 0.1 },
        -- optionally define an integer/float for the exact width of the task list
        width = nil,
        max_height = { 30, 0.4 },
        min_height = 10,
        height = nil,
        -- String that separates tasks
        separator = "────────────────────────────────────────",
        -- Default direction. Can be "left", "right", or "bottom"
        direction = "bottom",
        -- Set keymap to false to remove default behavior
        -- You can add custom keymaps here as well (anything vim.keymap.set accepts)
        bindings = {
          ["<A-l>"] = "IncreaseDetail",
          ["<A-h>"] = "DecreaseDetail",
          ["<A-k>"] = "ScrollOutputUp",
          ["<A-j>"] = "ScrollOutputDown",
          ["<C-j>"] = false,
          ["<C-k>"] = false,
        },
      },
    },
    config = function(_, opts)
      require("overseer").setup(opts)

      -- Insert status into lualine
      opts = require("lualine").get_config()
      table.insert(opts.sections.lualine_x, 1, "overseer")
      require("lualine").setup(opts)
    end,
  },
}
