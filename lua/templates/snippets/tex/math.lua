local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local c = ls.choice_node
local f = ls.function_node
local d = ls.dynamic_node
local ms = ls.multi_snippet

local fmta = require("luasnip.extras.fmt").fmta
local extras = require("luasnip.extras")
local rep = extras.rep
local m = extras.match

local autosnippet = ls.extend_decorator.apply(s, { snippetType = "autosnippet" })

local conds = require("templates.snippets.tex.utils.conditions")
local cond_line_begin = require("luasnip.extras.conditions.expand").line_begin

return {
  -- stylua: ignore
  autosnippet({ trig = "mk", name = "inline_math", desc = "In-line math block" }, fmta([[ \( <> \) <>]], { i(1), i(0) })),
  -- stylua: ignore
  autosnippet({ trig = "dm", name = "inline_math", desc = "In-line math block" },
    fmta( [[
      \[
        <>
      \]
    ]], {i(0)}),
    {condition = cond_line_begin}
  ),

  -- stylua: ignore
  s({ trig = "align", name = "align environment", dscr = "Align environment\n  Insert align in text and aligned in math environment" },
    fmta([[
        \begin{align<>}
          <>
        \end{align<>}
      ]], {
        m(nil, conds.in_math, "ed"),
        i(0),
        m(nil, conds.in_math, "ed"),
      }
    )
  ),

  -- stylua: ignore
  -- TODO: If not use "*", add \label automatically
  s({ trig = "equation", name = "equation environment", dscr = "Equation environment" },
    fmta([[
        \begin{equation<>}
          <>
        \end{equation<>}
    ]], {c(1, {t(""), t("*")}), i(0), rep(1)})
  ),

  -- fractions
  autosnippet(
    { trig = "//", name = "fraction", dscr = "Fraction" },
    fmta(
      [[
    \frac{<>}{<>}<>
    ]],
      { i(1), i(2), i(0) }
    ),
    { condition = conds.in_math, show_condition = conds.in_math }
  ),

  -- TODO: auto fraction
  -- autosnippet(
  --   {
  --     trig = "((\\d+)|(\\d*)(\\\\)?([A-Za-z]+)((\\^|_)(\\{\\d+\\}|\\d))*)\\/",
  --     name = "fraction",
  --     dscr = "auto fraction 1",
  --     trigEngine = "ecma",
  --   },
  --   fmta(
  --     [[
  --   \frac{<>}{<>}<>
  --   ]],
  --     { f(function(_, snip)
  --       return snip.captures[1]
  --     end), i(1), i(0) }
  --   ),
  --   { condition = cond.in_math, show_condition = cond.in_math }
  -- ),
  -- autosnippet(
  --   { trig = "(^.*\\))/", name = "fraction", dscr = "auto fraction 2", trigEngine = "ecma" },
  --   { d(1, generate_fraction) },
  --   { condition = cond.in_math, show_condition = cond.in_math }
  -- ),
}
