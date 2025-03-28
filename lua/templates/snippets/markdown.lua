local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local d = ls.dynamic_node
local sn = ls.snippet_node

local autosnippet = ls.extend_decorator.apply(s, { snippetType = "autosnippet" })

local utils = require("templates.snippets.utils.utils")
-- local conds = require("templates.snippets.utils.conditions")
local cond_line_begin = require("luasnip.extras.conditions.expand").line_begin

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

local function generate_list(_, snip, _, user_arg)
  local num = tonumber(snip.captures[1])
  local table = {}
  for index = 1, num do
    if user_arg == "1" then
      table[#table + 1] = t(tostring(index) .. ". ")
    else
      table[#table + 1] = t("- ")
    end

    table[#table + 1] = i(index, tostring(index))

    if index ~= num then
      table[#table + 1] = t({ "", "" })
    end
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
  autosnippet({trig = "table(%d+)x(%d+)%s", desc = "Table generation", regTrig = true, hidden = true},
    {d(1, generate_table, {})}, {condition = cond_line_begin}
  ),

  -- stylua: ignore
  autosnippet({trig = "item(%d+)%s", desc = "Itemize generation", regTrig = true, hidden = true},
    {d(1, generate_list, {}, {user_args = {"-"}})}, {condition = cond_line_begin}
  ),

  -- stylua: ignore
  autosnippet(
    {trig = "enum(%d+)%s", desc = "Enumerate generation", regTrig = true, hidden = true},
    {d(1, generate_list, {}, {user_args = {"1"}})}, {condition = cond_line_begin}
  ),
}
