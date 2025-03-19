local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node

return {
  -- stylua: ignore
  s({ trig = "stylua-ignore", desc = "Ignore stylua", wordTrig = false }, {
    t("-- stylua: ignore"),
  }),
}
