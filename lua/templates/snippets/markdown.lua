local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

return {
  -- stylua: ignore
  s({ trig = "figure", desc = "Image" }, {
    t("!["), i(0, "content"), t({ "](./Figures_markdown/" }), i(1), t(")")
  }),
}
