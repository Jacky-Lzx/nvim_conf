-- Verilog related plugins

local M = {}

M.plugins = {
  -- {'HonkW93/automatic-verilog'},
  -- {
  --   "mingo99/verilog-autoinst.nvim",
  --   file_type = { "verilog", "systemverilog" },
  --   cmd = "AutoInst",
  --   keys = {
  --     { "<leader>fv", "<cmd>AutoInst<cr>", desc = "Automatic instantiation for verilog" }
  --   },
  --   dependencies = { "nvim-telescope/telescope.nvim" },
  --   opts = {},
  -- },
}

function M.setup(setting_name, extra)
  if setting_name == G.language.lsp then
    require("lspconfig").verible.setup({
      on_attach = extra.on_attach,
      capabilities = extra.capabilities,

      -- filetypes = { "verilog", "systemverilog", "v" },
      root_dir = function(fname)
        -- return vim.fs.dirname(vim.fs.find(".git", { path = fname, upward = true })[1])
        return vim.fs.dirname(fname)
      end,
    })

    -- require("lspconfig").svls.setup({
    --   root_dir = function(fname)
    --     -- return require("lspconfig.util").find_git_ancestor(fname)
    --     return vim.fs.dirname(fname)
    --   end,
    --   cmd = { "svls" },
    --   filetypes = { "verilog", "systemverilog" },
    -- })
    return
  end

  if setting_name == G.language.formatter then
    require("conform").formatters["verible-verilog-format"] = {
      command = "verible-verilog-format",
      args = { "-" },
    }
    return { "verible-verilog-format" }
  end

  if setting_name == G.language.linter then
    local verilator = require("lint").linters.verilator
    verilator.args = {
      "+1800-2017ext+sv",
    }

    -- local pattern = "([%w_%.]+): (%d+): (%w?): (.*)\n"
    -- local pattern = "([^:]+):(%d+): (%w +): (.*)"
    local pattern = "(.-):(%d+): ([%w ]+): (.*)"

    local groups = { "file", "lnum", "severity", "message" }

    local severities = {
      ["error"] = vim.diagnostic.severity.ERROR,
      ["warning"] = vim.diagnostic.severity.WARN,
      ["     "] = vim.diagnostic.severity.INFO,
      ["       "] = vim.diagnostic.severity.INFO,
    }

    require("lint").linters.iverilog = {
      name = "iverilog",
      cmd = "iverilog",
      stdin = false, -- or false if it doesn't support content input via stdin. In that case the filename is automatically added to the arguments.
      append_fname = true, -- Automatically append the file name to `args` if `stdin = false` (default: true)
      args = {
        "-g2012",
        "-Wall",
        "-y",
        ".",
        "-o",
        "/dev/null",
      }, -- list of arguments. Can contain functions with zero arguments that will be evaluated once the linter is used.
      stream = "both", -- ('stdout' | 'stderr' | 'both') configure the stream to which the linter outputs the linting result.
      ignore_exitcode = true, -- set this to true if the linter exits with a code != 0 and that's considered normal.
      env = nil, -- custom environment table to use with the external process. Note that this replaces the *entire* environment, it is not additive.
      parser = require("lint.parser").from_pattern(pattern, groups, severities, { ["source"] = "iverilog" }),
    }

    return { "iverilog" }
    -- return { "verilator" }
  end

  require("notify")("Unknown setting for language `verilog`: " .. setting_name)
end

return M
