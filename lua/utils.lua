require("global")

local utils = {}

---Setup every language defined in `Enabled_languages` by a given setting
---@param setting setting a setting defined in class `Global_settings`
---@return table<string, string[]>
utils.language_setup = function(setting)
  local M = {}
  for _, ft in ipairs(Enabled_languages) do
    local opts = require("plugins.languages." .. ft).setup(setting)
    if opts and #opts ~= 0 then
      M[ft] = opts
    end
  end
  return M
end

return utils
