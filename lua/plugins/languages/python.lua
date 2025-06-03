local M = {}

M.plugins = {
  {
    "mason-org/mason.nvim",
    opts = { ensure_installed = { "ruff", "pyright" } },
  },

  -- formatter
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        rust = { "ruff" },
      },
    },
  },

  -- linter
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = {
      linters_by_ft = {
        python = { "ruff" },
      },
    },
  },
}

function M.setup(setting_name, extra) end

vim.lsp.enable("pyright")

return M
