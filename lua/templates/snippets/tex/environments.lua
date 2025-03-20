local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local c = ls.choice_node

local fmta = require("luasnip.extras.fmt").fmta
local extras = require("luasnip.extras")
local rep = extras.rep

-- local tex = require("templates.snippets.tex.utils.conditions")

return {
  -- stylua: ignore
  s({ trig = "begin", name = "begin/end", desc = "begin/end" },
    fmta([[
          \begin{<>}
            <>
          \end{<>}
    ]], { i(1), i(0), rep(1) })
    -- { condition = tex.in_text, show_condition = tex.in_text }
  ),

  -- stylua: ignore
  s({ trig = "itemize", name = "itemize", desc = "Itemize" },
    fmta([[
        \begin{itemize}<>
          \item <>
        \end{itemize}
    ]], {
      c(1, {
        t("[leftmargin=0.5cm]"),
        i(1),
      }),
      i(0)
    })
    -- { condition = tex.in_text, show_condition = tex.in_text }
  ),

  -- stylua: ignore
  s({ trig = "enumerate", name = "enumerate", desc = "Enumerate" },
    fmta([[
      \begin{enumerate}<>
        \item <>
      \end{enumerate}
    ]], {
      c(1, {
        t("[label=\\arabic*]"),
        t("[label=\\alph*]"),
        t("[label=\\roman*]"),
        i(1),
      }),
      i(0)
    })
    -- { condition = tex.in_text, show_condition = tex.in_text }
  ),

  s({ trig = "item", name = "item", desc = "A signle item" }, t("\\item ")),
}
