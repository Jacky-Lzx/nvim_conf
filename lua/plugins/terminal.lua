return {
  {
    "mikavilpas/yazi.nvim",
    dependencies = { "folke/snacks.nvim", lazy = true },
    -- stylua: ignore
    keys = {
      { "<leader>e",  "<CMD>Yazi<CR>",        desc = "[Yazi] open at the current file", mode = { "n", "v" }},
      { "<leader>cw", "<CMD>Yazi cwd<CR>",    desc = "[Yazi] open in working directory"             },
      { "<c-up>",     "<CMD>Yazi toggle<CR>", desc = "[Yazi] Resume the last session"                      },
    },
    ---@type YaziConfig | {}
    opts = {
      -- if you want to open yazi instead of netrw, see below for more info
      open_for_directories = false,
      open_multiple_tabs = true,
      keymaps = {
        show_help = "<f1>",
      },
    },
    -- 👇 if you use `open_for_directories=true`, this is recommended
    init = function()
      -- More details: https://github.com/mikavilpas/yazi.nvim/issues/802
      -- vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1
    end,
  },
  {
    "numToStr/FTerm.nvim",
    -- stylua: ignore
    keys = {
      -- { "<A-i>", '<CMD>lua require("FTerm").toggle()<CR>',            mode = "n", desc = "Toggle float terminal" },
      -- { "<A-i>", '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>', mode = "t", desc = "Toggle float terminal" },
      { "<C-g>",                                                      mode = "n", desc = "Toggle Lazygit" },
    },
    opts = {
      border = "rounded",
      dimensions = {
        height = 0.9,
        width = 0.9,
      },
    },
    config = function(_, opts)
      local fterm = require("FTerm")
      local lg = fterm:new({
        ft = "lazygit",
        cmd = "lazygit --use-config-file=$HOME/.config/lazygit/config.yml",
        dimensions = {
          height = 0.9,
          width = 0.9,
        },
      })

      require("FTerm").setup(opts)

      -- Use this to toggle lazygit in a floating terminal
      vim.keymap.set("n", "<C-g>", function()
        lg:toggle()
      end)
    end,
  },
}
