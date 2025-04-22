local ls = require("luasnip")
local s = ls.snippet
-- local sn = ls.snippet_node
local i = ls.insert_node
local t = ls.text_node
local fmta = require("luasnip.extras.fmt").fmta
local d = ls.dynamic_node
local c = ls.choice_node
local sn = ls.snippet_node
-- local f = ls.function_node

return {
  -- stylua: ignore
  s({trig = "main", desc = "Main"},
    fmta([[
    if __name__ == "__main__":
        <args>
    ]], {
      args = i(0),
    })
  ),
}
