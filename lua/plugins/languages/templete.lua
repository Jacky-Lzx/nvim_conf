local M = {}

function M.setup(setting_name)
  if setting_name == G.language.lsp then
    -- require("notify")("Unknown setting for language `python`: " .. setting_name)
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
