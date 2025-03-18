local M = {}

function M.setup(setting_name)
  if setting_name == G.language.lsp then
    require("lspconfig").rust_analyzer.setup({
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

M.plugins = {}

return M
