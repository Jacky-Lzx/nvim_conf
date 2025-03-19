return {
  {
    "CRAG666/code_runner.nvim",
    cmd = { "RunCode" },
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
          markdown = {
            "cd $dir &&",
            'pandoc $fileName -o $fileNameWithoutExt.pdf --pdf-engine=xelatex -V CJKmainfont="PingFang SC" &&',
            "open $fileNameWithoutExt.pdf",
          },
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
    "stevearc/overseer.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "stevearc/dressing.nvim",
      "rcarriga/nvim-notify",
      "nvim-lualine/lualine.nvim",
    },
    cmd = "OverseerRun",
    opts = {
      template_dirs = { "templates.overseer" },
      -- templates = { "convert_md_to_pdf" },
      templates = { "builtin", "user.convert_md_to_pdf" },
    },
    config = function(_, opts)
      require("overseer").setup(opts)

      require("lualine").setup({
        sections = {
          lualine_x = { "overseer" },
        },
      })
    end,
  },
}
