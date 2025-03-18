-- @param t1 table: table to be concatenated
-- @param t2 table: table to be concatenated
-- @return table: concatenated table
local function concat_tables(t1, t2)
  for _, v in ipairs(t2) do
    table.insert(t1, v)
  end
  return t1
end

local M = {
  {
    -- highlight and search for todo comments like TODO, HACK, BUG in your code base.
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
    -- stylua: ignore
    keys = {
      { "<leader>td", "<cmd>TodoTelescope<cr>", desc = "List todo comments" },
    },
    config = true,
  },

  {
    "echasnovski/mini.align",
    version = "*",
    opts = {
      mappings = {
        start = "gA",
        start_with_preview = "ga",
      },
    },
    config = function(_, opts)
      require("mini.align").setup(opts)
    end,
  },

  {
    "CRAG666/code_runner.nvim",
    config = function()
      require("code_runner").setup({
        options = {
          -- term = {
          --   position = "vert",
          --   size = 20,
          --   winblend = 10,
          --   hide_numbers = true,
          --   list = true,
          -- },
        },
        filetype = {
          -- java = {
          --   "cd $dir &&",
          --   "javac $fileName &&",
          --   "java $fileNameWithoutExt",
          -- },
          -- python = "python3 -u",
          -- typescript = "deno run",
          -- rust = {
          --   "cd $dir &&",
          --   "rustc $fileName &&",
          --   "$dir/$fileNameWithoutExt",
          -- },
          -- c = function(...)
          --   c_base = {
          --     "cd $dir &&",
          --     "gcc $fileName -o",
          --     "/tmp/$fileNameWithoutExt",
          --   }
          --   local c_exec = {
          --     "&& /tmp/$fileNameWithoutExt &&",
          --     "rm /tmp/$fileNameWithoutExt",
          --   }
          --   vim.ui.input({ prompt = "Add more args:" }, function(input)
          --     c_base[4] = input
          --     vim.print(vim.tbl_extend("force", c_base, c_exec))
          --     require("code_runner.commands").run_from_fn(vim.list_extend(c_base, c_exec))
          --   end)
          -- end,
          -- verilog = {
          --   "cd $dir &&",
          --   "sh compile.sh &&",
          --   "./$fileNameWithoutExt",
          -- },
          verilog = function()
            local verilog_compile = {
              "cd $dir &&",
              "sh compile.sh",
            }
            local verilog_exec = {
              "&&",
            }
            -- Set default name to current file name without extension
            local default_name = vim.fn.expand("%:t:r")
            -- Replace the last '_' in default_name with '.'
            default_name = default_name:gsub("_(%w+)$", ".%1")

            vim.ui.input({ prompt = "Executable name:", default = default_name }, function(input)
              verilog_exec[2] = "./" .. input
            end)
            require("code_runner.commands").run_from_fn(vim.list_extend(verilog_compile, verilog_exec))
          end,
        },
      })
    end,
  },

  {
    "echasnovski/mini.cursorword",
    version = false,
    config = function()
      require("mini.cursorword").setup()
    end,
  },

  -- {
  --   "preservim/tagbar",
  --   lazy = true,
  --   -- stylua: ignore
  --   keys = {
  --     { "<leader>tt", "<cmd>TagbarToggle<cr>", desc = "toggle tagbar" }
  --   },
  --   config = function() end,
  -- },

  -- "mg979/vim-visual-multi",

  {
    "cappyzawa/trim.nvim",
    event = "BufWritePre",
    opts = {},
  },

  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    opts = {},
  },

  {
    "mbbill/undotree",
    lazy = false,
    keys = {
      { "<leader>ut", "<cmd>UndotreeToggle<cr>", desc = "toggle undo-tree" },
    },
    init = function()
      vim.cmd([[
      if has("persistent_undo")
         let target_path = expand('~/.undodir')

          " create the directory and any parent directories
          " if the location does not exist.
          if !isdirectory(target_path)
              call mkdir(target_path, "p", 0700)
          endif

          let &undodir=target_path
          set undofile
      endif
      ]])
    end,
  },

  {
    "numToStr/Comment.nvim",
    -- stylua: ignore
    keys = {
      { "<leader>/", function() require("Comment.api").toggle.linewise.current() end,                 mode = "n", desc = "comment current line", },
      { "<leader>/", "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>", mode = "v", desc = "comment current line", },
    },
    config = function()
      require("Comment").setup()
    end,
  },

  -- {
  --   "mhartington/formatter.nvim",
  --   event = "BufWritePre",
  --   init = function()
  --     vim.cmd([[
  --     augroup FormatAutogroup
  --       autocmd!
  --       autocmd BufWritePost * FormatWrite
  --     augroup END
  --     ]])
  --   end,
  --   config = function()
  --     -- Utilities for creating configurations
  --     local util = require("formatter.util")
  --
  --     -- Provides the Format, FormatWrite, FormatLock, and FormatWriteLock commands
  --     require("formatter").setup({
  --       -- Enable or disable logging
  --       logging = false,
  --       -- Set the log level
  --       log_level = vim.log.levels.WARN,
  --       -- All formatter configurations are opt-in
  --       filetype = {
  --         -- Formatter configurations for filetype "lua" go here
  --         -- and will be executed in order
  --         cpp = {
  --           -- prettier
  --           function()
  --             return {
  --               exe = "clang-format",
  --               args = {},
  --               stdin = true,
  --             }
  --           end,
  --         },
  --
  --         python = {
  --           function()
  --             return {
  --               exe = "yapf",
  --               args = {},
  --               stdin = true,
  --             }
  --           end,
  --         },
  --
  --         rust = {
  --           require("formatter.filetypes.rust").rustfmt,
  --
  --           -- function()
  --           --   return {
  --           --     exe = "rustfmt",
  --           --     args = {},
  --           --     stdin = true,
  --           --   }
  --           -- end,
  --         },
  --
  --         lua = {
  --           -- "formatter.filetypes.lua" defines default configurations for the
  --           -- "lua" filetype
  --           require("formatter.filetypes.lua").stylua,
  --
  --           -- You can also define your own configuration
  --           function()
  --             -- Supports conditional formatting
  --             if util.get_current_buffer_file_name() == "special.lua" then
  --               return nil
  --             end
  --
  --             -- Full specification of configurations is down below and in Vim help
  --             -- files
  --             return {
  --               exe = "stylua",
  --               args = {
  --                 "--search-parent-directories",
  --                 "--stdin-filepath",
  --                 util.escape_path(util.get_current_buffer_file_path()),
  --                 "--",
  --                 "-",
  --               },
  --               stdin = true,
  --             }
  --           end,
  --         },
  --
  --         verilog = {
  --           function()
  --             return {
  --               exe = "verible-verilog-format",
  --               args = {},
  --               stdin = true,
  --             }
  --           end,
  --         },
  --
  --         -- Use the special "*" filetype for defining formatter configurations on
  --         -- any filetype
  --         ["*"] = {
  --           -- "formatter.filetypes.any" defines default configurations for any
  --           -- filetype
  --           require("formatter.filetypes.any").remove_trailing_whitespace,
  --         },
  --       },
  --     })
  --
  --     vim.keymap.set("n", "<leader>gf", "<CMD>Format<CR>", {})
  --   end,
  -- },

  { "wakatime/vim-wakatime", lazy = false },

  -- {
  --   "Vonr/align.nvim",
  --   -- stylua: ignore
  --   keys = {
  --     { "aa" , function() require("align").align_to_char(1, true)             end,            mode = "x", noremap = true, silent = true, desc = "align to 1 char" },
  --     { "as" , function() require("align").align_to_char(2, true, true)       end,            mode = "x", noremap = true, silent = true, desc = "align to 2 char" },
  --     { "as" , function() require'align'.align_to_string({ preview = true, regex = true, }) end, mode = "x", noremap = true, silent = true, desc = "align to string" },
  --   },
  -- },
}

for i = 1, #Enabled_languages do
  local lang = require("plugins.languages." .. Enabled_languages[i])
  concat_tables(M, lang.plugins)
end

return M
