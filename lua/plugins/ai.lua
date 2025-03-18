return {
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    event = "VeryLazy",

    opts = {
      send_code = true,

      strategies = {
        chat = {
          adapter = "copilot",
        },
        inline = {
          adapter = "copilot",
        },
      },
    },

    config = function(_, opts)
      require("codecompanion").setup(opts)

      vim.keymap.set({ "n", "v" }, "<C-a>", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true })
      vim.keymap.set(
        { "n", "v" },
        "<LocalLeader>a",
        "<cmd>CodeCompanionChat Toggle<cr>",
        { noremap = true, silent = true }
      )
      vim.keymap.set("v", "ga", "<cmd>CodeCompanionChat Add<cr>", { noremap = true, silent = true })

      -- Expand 'cc' into 'CodeCompanion' in the command line
      -- vim.cmd([[cab cc CodeCompanion]])
    end,
  },

  -- {
  --   "CopilotC-Nvim/CopilotChat.nvim",
  --   dependencies = {
  --     -- { "github/copilot.vim" }, -- or zbirenbaum/copilot.lua
  --     { "zbirenbaum/copilot.lua" }, -- or zbirenbaum/copilot.lua
  --     { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
  --   },
  --   build = "make tiktoken", -- Only on MacOS or Linux
  --   cmd = { "CopilotChat", "CopilotChatToggle", "CopilotChatPrompts" },
  --   opts = {
  --     mappings = {
  --       submit_prompt = {
  --         normal = "<Leader>s",
  --         insert = "<C-s>",
  --       },
  --       show_diff = {
  --         -- full_diff = true,
  --       },
  --     },
  --     -- See Configuration section for options
  --   },
  --   -- See Commands section for default commands if you want to lazy load on them
  -- },

  {
    "zbirenbaum/copilot.lua",
    -- cmd = "Copilot",
    event = "VeryLazy",
    config = function()
      require("copilot").setup({
        suggestion = { enabled = false },
        panel = { enabled = false },
        filetypes = {
          markdown = true,
        },
      })
    end,
  },
}
