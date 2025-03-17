-- Verilog related plugins

local M = {}

M.plugins = {
  -- {'HonkW93/automatic-verilog'},
  -- {
  --   "mingo99/verilog-autoinst.nvim",
  --   file_type = { "verilog", "systemverilog" },
  --   cmd = "AutoInst",
  --   -- stylua: ignore
  --   keys = {
  --     { "<leader>fv", "<cmd>AutoInst<cr>", desc = "Automatic instantiation for verilog" }
  --   },
  --   dependencies = { "nvim-telescope/telescope.nvim" },
  --   opts = {},
  -- },
}

function M.setup(setting_name)
  if setting_name == G.language.lsp then
    require("lspconfig").verible.setup({
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
    return
  end

  if setting_name == G.language.linter then
    local verilator = require("lint").linters.verilator
    verilator.args = {
      "+1800-2017ext+sv",
    }

    return { "verilator" }
  end

  require("notify")("Unknown setting for language `verilog`: " .. setting_name)
end

return M
