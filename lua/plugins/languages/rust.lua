local M = {}

function M.setup(setting_name, extra)
  if setting_name == G.language.lsp then
    return
  end

  if setting_name == G.language.formatter then
    return
  end

  if setting_name == G.language.linter then
    return
  end

  require("notify")("Unknown setting for language `rust`: " .. setting_name)
end

M.plugins = {
  {
    "Saecki/crates.nvim",
    event = { "BufRead Cargo.toml" },
    opts = {
      completion = {
        crates = {
          enabled = true,
        },
      },
      lsp = {
        enabled = true,
        actions = true,
        completion = true,
        hover = true,
      },
    },
  },

  {
    "mrcjkb/rustaceanvim",
    version = "^6", -- Recommended
    ft = "rust",
  },

  {
    "mason-org/mason.nvim",
    optional = true,
    opts_extend = { "ensure_installed" },
    opts = { ensure_installed = { "rust-analyzer" } },
  },

  -- formatter
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        rust = { "rustfmt", lsp_format = "fallback" },
      },
    },
  },
}

return M
