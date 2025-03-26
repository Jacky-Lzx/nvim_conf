local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local d = ls.dynamic_node

local utils = require("templates.snippets.utils.utils")

return {
  -- stylua: ignore
  s({ trig = "figure", desc = "Image" }, {
    t("!["),
    -- i(0, "content"),
    d(2, utils.get_insert_with_formulated_path_text, {1}),
    t({ "](./Figures_markdown/" }),
    i(1),
    t(")"),
    i(0)
  }),
}
