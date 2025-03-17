require("global")

local utils = {}

utils.language_setup_return_table = function(setting)
  local M = {}
  for _, ft in ipairs(Enabled_languages) do
    local opts = require("plugins.languages." .. ft).setup(setting)
    if opts then
      M[ft] = opts
    end
    -- M[ft] = require("plugins.languages." .. ft).setup(setting)
  end
  return M
end

utils.language_setup = function(setting)
  for _, ft in ipairs(Enabled_languages) do
    require("plugins.languages." .. ft).setup(setting)
  end
end

return utils
