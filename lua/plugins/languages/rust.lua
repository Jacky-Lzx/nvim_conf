local M = {}

function M.setup(setting_name, extra)
  if setting_name == G.language.lsp then
    require("lspconfig").rust_analyzer.setup({
      -- on_attach = extra.on_attach,
      capabilities = extra.capabilities,

      settings = {
        ["rust-analyzer"] = {
          diagnostics = {
            enable = true,
          },
        },
      },
    })
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
