local M = {}

function M.setup(setting_name, extra)
  if setting_name == G.language.lsp then
    -- on_attach = extra.on_attach,
    -- capabilities = extra.capabilities,

    return
  end

  if setting_name == G.language.formatter then
    return
  end

  if setting_name == G.language.linter then
    return
  end

  require("notify")("Unknown setting for language `template`: " .. setting_name)
end

M.plugins = {}

return M
