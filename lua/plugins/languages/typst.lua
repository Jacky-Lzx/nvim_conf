local M = {}

function M.setup(setting_name, extra)
  if setting_name == G.language.lsp then
    vim.lsp.enable("tinymist")
    return
  end

  if setting_name == G.language.formatter then
    return
  end

  if setting_name == G.language.linter then
    return
  end

  require("notify")("Unknown setting for language `typst`: " .. setting_name)
end

M.plugins = {
  {
    "chomosuke/typst-preview.nvim",
    ft = "typst",
    version = "1.*",
    opts = {},
  },
}

return M
