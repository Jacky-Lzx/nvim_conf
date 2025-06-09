require("global")

local utils = {}

---Setup every language defined in `Enabled_languages` by a given setting
---@param setting setting a setting defined in class `Global_settings`
---@param extra table? extra settings to be passed to the language setup
---@return table<string, string[]>
utils.language_setup = function(setting, extra)
  local M = {}
  for _, ft in ipairs(Enabled_languages) do
    require("plugins.languages." .. ft)
    -- if opts and #opts ~= 0 then
    --   M[ft] = opts
    -- end
  end
  return M
end

return utils
