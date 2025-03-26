local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node

return {
  s({ trig = "date", desc = "Date" }, { t(os.date("%Y.%m.%d")) }),

  s({ trig = "datetime", desc = "Date & time" }, { t(os.date("%Y.%m.%d %H:%M:%S")) }),
}
