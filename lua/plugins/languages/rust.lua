local M = {}

function M.setup(setting_name, extra)
  if setting_name == G.language.lsp then
    vim.lsp.config("rust_analyzer", {
      settings = {
        ["rust-analyzer"] = {
          diagnostics = {
            enable = true,
          },
        },
      },
    })

    vim.lsp.enable("rust_analyzer")

    return
  end

  if setting_name == G.language.formatter then
    return { "rustfmt", lsp_format = "fallback" }
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
}

return M
