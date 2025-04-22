local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local c = ls.choice_node
local fmta = require("luasnip.extras.fmt").fmta

local temple = require("templates.snippets.utils.utils")

return {
  s(
    { trig = "frame", desc = "Frame" },
    fmta(
      [[
        \begin{frame}<>
          <>
        \end{frame}
      ]],
      { c(1, { sn(nil, { t("{"), i(1, "Title"), t("}") }), t("") }), i(0) }
    )
  ),
}
