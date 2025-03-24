return {
  {
    "stevearc/overseer.nvim",
    dependencies = {
      -- "nvim-telescope/telescope.nvim",
      "stevearc/dressing.nvim",
      "rcarriga/nvim-notify",
      "nvim-lualine/lualine.nvim",
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
