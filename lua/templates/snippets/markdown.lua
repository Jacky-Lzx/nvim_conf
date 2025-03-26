local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local d = ls.dynamic_node
local sn = ls.snippet_node

local autosnippet = ls.extend_decorator.apply(s, { snippetType = "autosnippet" })

local utils = require("templates.snippets.utils.utils")
local conds = require("templates.snippets.utils.conditions")

local function generate_table(_, snip)
  local rows = tonumber(snip.captures[1])
  local cols = tonumber(snip.captures[2])
  local table = {}

  local insert_index = 0

  -- first line
  table[#table + 1] = t("| ")
  for c = 1, cols do
    insert_index = insert_index + 1
    table[#table + 1] = i(insert_index, tostring(insert_index))
    if c < cols then
      table[#table + 1] = t(" | ")
    end
  end
  table[#table + 1] = t({ " |", "" })

  -- table line
  table[#table + 1] = t("| ")
  for c = 1, cols do
    table[#table + 1] = t("-")
    if c < cols then
      table[#table + 1] = t(" | ")
    end
  end
  table[#table + 1] = t({ " |", "" })

  for _ = 3, rows + 1 do
    -- local row = {}
    table[#table + 1] = t("| ")
    for c = 1, cols do
      insert_index = insert_index + 1
      table[#table + 1] = i(insert_index, tostring(insert_index))
      if c < cols then
        table[#table + 1] = t(" | ")
      end
    end
    table[#table + 1] = t({ " |", "" })
  end

  return sn(nil, table)
end

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

  -- stylua: ignore
  autosnippet({trig = "|(%d+)x(%d+)|", desc = "Table generation", regTrig = true, hidden = true},
    {d(1, generate_table, {})}
  ),
}
