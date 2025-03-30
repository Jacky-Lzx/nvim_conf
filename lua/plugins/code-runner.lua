return {
  {
    "stevearc/overseer.nvim",
    dependencies = {
      "rcarriga/nvim-notify",
    },
    keys = {
      { "<F5>", "<CMD>OverseerRun<CR>", desc = "[Overseer] Run" },
      { "<leader>or", "<CMD>OverseerRun<CR>", desc = "[Overseer] Run" },
      -- typos: ignore
      { "<leader>ot", "<CMD>OverseerToggle<CR>", desc = "[Overseer] Toggle" },
    },
    cmd = "OverseerRun",
    opts = {
      template_dirs = { "templates.overseer" },
      templates = {
        "builtin",
        "user.convert_md_to_pdf",
        "user.verilog",
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
