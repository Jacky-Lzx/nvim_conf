return {
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      -- "nvim-treesitter/nvim-treesitter",
      "echasnovski/mini.diff",
    },
    event = "VeryLazy",

    -- stylua: ignore
    keys = {
      {"<leader>cca", "<CMD>CodeCompanionActions<CR>", mode = {"n", "v"}, noremap = true, silent = true, desc = "CodeCompanion actions"},
      {"<leader>cci", "<CMD>CodeCompanion<CR>", mode = {"n", "v"}, noremap = true, silent = true, desc = "CodeCompanion inline"},
      {"<leader>ccc", "<CMD>CodeCompanionChat Toggle<CR>", mode = {"n", "v"}, noremap = true, silent = true, desc = "CodeCompanion chat (toggle)"},
      {"<leader>ccp", "<CMD>CodeCompanionChat Add<CR>", mode = { "v"}, noremap = true, silent = true, desc = "CodeCompanion chat add code"},
    },

    opts = {
      send_code = true,

      display = {
        chat = {
          -- If show settings, can not change adapter during the chat
          show_settings = false,
        },
        diff = {
          layout = "vertical", -- vertical|horizontal split for default provider
          opts = { "internal", "filler", "closeoff", "algorithm:patience", "followwrap", "linematch:120" },
          provider = "mini_diff", -- default|mini_diff
        },
      },

      adapters = {
        deepseek = function()
          return require("codecompanion.adapters").extend("deepseek", {
            env = {
              api_key = function()
                return os.getenv("DEEPSEEK_API_KEY_NEOVIM")
              end,
            },
          })
        end,
      },
      strategies = {
        chat = {
          adapter = "copilot",
        },
        inline = {
          adapter = "copilot",
        },
      },

      opts = {
        language = "English",
        -- language = "Chinese",
      },
    },

    config = function(_, opts)
      require("codecompanion").setup(opts)

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

    -- dependencies = {
    --   {
    --     "zbirenbaum/copilot-cmp",
    --     config = function()
    --       require("copilot_cmp").setup()
    --     end,
    --   },
    -- },
    -- cmd = "Copilot",
    event = "VeryLazy",
    opts = {
      suggestion = { enabled = false },
      panel = { enabled = false },
      filetypes = {
        markdown = true,
        help = true,
      },
    },
  },
}
