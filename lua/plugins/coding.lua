-- @param t1 table: table to be concatenated
-- @param t2 table: table to be concatenated
-- @return table: concatenated table
local function concat_tables(t1, t2)
  for _, v in ipairs(t2) do
    table.insert(t1, v)
  end
  return t1
end

local M = {}

for i = 1, #Enabled_languages do
  local lang = require("plugins.languages." .. Enabled_languages[i])
  M = concat_tables(M, lang.plugins)
end

return M
