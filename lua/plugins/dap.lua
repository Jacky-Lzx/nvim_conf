return {
  {
    "rcarriga/nvim-dap-ui",
    lazy = true,
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    main = "dapui",
    -- stylua: ignore
    keys = {
      { "<leader>Du", function() require("dapui").toggle({reset = true}) end, desc = "[DAP ui] Toggle dapui", },
    },
    opts = {},
  },
  -- {
  --   -- Show variable values as virtual texts
  --   "theHamsta/nvim-dap-virtual-text",
  --   opts = {
  --     virt_text_pos = "eol_right_align",
  --   },
  -- },
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      {
        "nvim-lualine/lualine.nvim",
        optional = true,
        opts = {
          options = {
            disabled_filetypes = { winbar = { "dap-repl" } },
          },
        },
      },
    },
    -- stylua: ignore
    keys = {
      {"<F5>",       function() require("dap").continue() end,                                                        mode = "n",          desc = "[DAP] Continue"},
      {"<F6>",       function() require("dap").step_over() end,                                                       mode = "n",          desc = "[DAP] Step over"},
      {"<F7>",       function() require("dap").step_into() end,                                                       mode = "n",          desc = "[DAP] Step into"},
      {"<F8>",       function() require("dap").step_out() end,                                                        mode = "n",          desc = "[DAP] Step out"},
      {"<F9>",       function() require("dap").pause() end,                                                           mode = "n",          desc = "[DAP] Pause"},
      {"<F10>",      function() require("dap").terminate() end,                                                       mode = "n",          desc = "[DAP] Terminate"},
      {"<Leader>b",  function() require("dap").toggle_breakpoint() end,                                               mode = "n",          desc = "[DAP] Toggle breakpoint"},
      {"<Leader>B",  function() require("dap").set_breakpoint() end,                                                  mode = "n",          desc = "[DAP] Set breakpoint"},
      -- Remove the <leader>D binding in "x" mode
      {"<Leader>D" , mode = "x"},
      {"<Leader>Dr", function() require("dap").repl.open() end,                                                       mode = "n",          desc = "[DAP] Repl open"},
      {"<Leader>Dl", function() require("dap").run_last() end,                                                        mode = "n",          desc = "[DAP] Run last"},
      {"<Leader>Dd", function() require("dap.ui.widgets").hover() end,                                                mode = { "n", "v" }, desc = "[DAP] Widgets hover"},
      {"<Leader>Dp", function() require("dap.ui.widgets").preview() end,                                              mode = { "n", "v" }, desc = "[DAP] Widgets preview"},
      {"<Leader>Df", function() local widgets = require("dap.ui.widgets") widgets.centered_float(widgets.frames) end, mode = {"n"},        desc = "[DAP] Float frames"},
      {"<Leader>Ds", function() local widgets = require("dap.ui.widgets") widgets.centered_float(widgets.scopes) end, mode = {"n"},        desc = "[DAP] Float scopes"},
    },

    config = function()
      local dap, dapui = require("dap"), require("dapui")

      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end

      dap.adapters.codelldb = {
        name = "codelldb",
        type = "executable",
        command = "codelldb", -- or if not in $PATH: "/absolute/path/to/codelldb"

        -- On windows you may have to uncomment this:
        -- detached = false,
      }
      dap.configurations.cpp = {
        {
          name = "Launch file",
          type = "codelldb",
          request = "launch",
          program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
        },
      }
      dap.configurations.c = dap.configurations.cpp

      dap.configurations.rust = {
        {
          name = "Launch file",
          type = "codelldb",
          request = "launch",
          program = function()
            -- Build the project before starting a debug session
            vim.fn.system("cargo build")

            -- Get the file name of the target executable
            local metadata_json = vim.fn.system("cargo metadata --format-version 1 --no-deps")
            local metadata = vim.fn.json_decode(metadata_json)
            local target_name = metadata.packages[1].targets[1].name
            local target_dir = metadata.target_directory
            return target_dir .. "/debug/" .. target_name
          end,
          args = function()
            -- Command line arguments that will be passed to the program
            local inputstr = vim.fn.input("CommandLine Args:", "")
            local params = {}
            for param in string.gmatch(inputstr, "[^%s]+") do
              table.insert(params, param)
            end
            return params
          end,
        },
      }

      dap.adapters.python = function(cb, config)
        if config.request == "attach" then
          ---@diagnostic disable-next-line: undefined-field
          local port = (config.connect or config).port
          ---@diagnostic disable-next-line: undefined-field
          local host = (config.connect or config).host or "127.0.0.1"
          cb({
            type = "server",
            port = assert(port, "`connect.port` is required for a python `attach` configuration"),
            host = host,
            options = {
              source_filetype = "python",
            },
          })
        else
          cb({
            type = "executable",
            -- command = "/opt/homebrew/anaconda3/envs/math/bin/python",
            command = "python",
            args = { "-m", "debugpy.adapter" },
            options = {
              source_filetype = "python",
            },
          })
        end
      end

      dap.configurations.python = {
        {
          -- The first three options are required by nvim-dap
          type = "python", -- the type here established the link to the adapter definition: `dap.adapters.python`
          request = "launch",
          name = "Launch file",

          -- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options

          program = "${file}", -- This configuration will launch the current file if used.

          -- You can also dynamically get arguments, e.g., from user input:
          args = function()
            local args_str = vim.fn.input("Enter arguments (space-separated): ")
            return vim.split(args_str, " ", { plain = true })
          end,
          pythonPath = function()
            -- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
            -- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
            -- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
            -- local cwd = vim.fn.getcwd()
            -- if vim.fn.executable(cwd .. "/venv/bin/python") == 1 then
            --   return cwd .. "/venv/bin/python"
            -- elseif vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
            --   return cwd .. "/.venv/bin/python"
            -- else
            -- return "/opt/homebrew/anaconda3/envs/math/bin/python"
            -- end
          end,
        },
      }

      local dap_breakpoint = {
        breakpoint = {
          text = "", -- Nerd font: nf-cod-activate_breakpoints
          texthl = "DapBreakpoint",
          linehl = "DapBreakpoint",
          numhl = "DapBreakpoint",
        },
        condition = {
          text = "",
          texthl = "DapBreakpoint",
          linehl = "DapBreakpoint",
          numhl = "DapBreakpoint",
        },
        rejected = {
          text = "",
          texthl = "DapBreakpoint",
          linehl = "DapBreakpoint",
          numhl = "DapBreakpoint",
        },
        logpoint = {
          text = "",
          texthl = "DapLogPoint",
          linehl = "DapLogPoint",
          numhl = "DapLogPoint",
        },
        stopped = {
          text = "",
          texthl = "DapStopped",
          linehl = "DapStopped",
          numhl = "DapStopped",
        },
      }
      vim.fn.sign_define("DapBreakpoint", dap_breakpoint.breakpoint)
      vim.fn.sign_define("DapBreakpointCondition", dap_breakpoint.condition)
      vim.fn.sign_define("DapBreakpointRejected", dap_breakpoint.rejected)
      vim.fn.sign_define("DapLogPoint", dap_breakpoint.logpoint)
      vim.fn.sign_define("DapStopped", dap_breakpoint.stopped)
    end,
  },
}
