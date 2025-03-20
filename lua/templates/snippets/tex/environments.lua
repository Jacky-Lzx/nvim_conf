local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local c = ls.choice_node
local f = ls.function_node

local fmta = require("luasnip.extras.fmt").fmta
local extras = require("luasnip.extras")
local rep = extras.rep
local autosnippet = ls.extend_decorator.apply(s, { snippetType = "autosnippet" })

local conds = require("templates.snippets.tex.utils.conditions")
local cond_line_begin = require("luasnip.extras.conditions.expand").line_begin

-- local tex = require("templates.snippets.tex.utils.conditions")

return {
  -- stylua: ignore
  s({ trig = "begin", name = "begin/end", desc = "begin/end" },
    fmta([[
          \begin{<>}
            <>
          \end{<>}
    ]], { i(1), i(0), rep(1) })
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
      }
    )
    -- { condition = tex.in_text, show_condition = tex.in_text }
  ),

  s(
    { trig = "item", name = "item", desc = "A signle item" },
    { t("\\item ") },
    { condition = conds.in_bullets, show_condition = conds.in_bullets }
  ),
  -- autosnippet(
  --   { trig = "--", hidden = true },
  --   { t("\\item ") },
  --   { condition = conds.in_bullets * cond_line_begin, show_condition = conds.in_bullets * cond_line_begin }
  --   -- { condition = cond_line_begin, show_condition = cond_line_begin }
  -- ),



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
      }
    )
    -- { condition = tex.in_text, show_condition = tex.in_text }
  ),

  -- stylua: ignore
  s({ trig = "figure", name = "figure", desc = "Figure environment" },
    fmta([[
        \begin{figure}[<>]
          \centering
          \includegraphics[width=<>\linewidth]{<><>}
          \caption{<>}%
          \label{fig:<>}
        \end{figure}
      ]],{
        c(1, { t("H"), t("htbp") }),
        i(2, "0.6"),
        t("Figures/"),
        i(3),
        i(4),
        f(function(args, _, _)
          -- Remove extension str
          return args[1][1]:gsub("%.[^.]*$", "")
        end, { 3 }),
      }
    )
  ),

  -- stylua: ignore
  s({ trig = "table", name = "table", desc = "Table environment" },
    fmta([[
        \begin{table}[<>]
          \centering
          \begin{tabular}{<>}
            <>
          \end{tabular}
          \caption{<>}
          \label{tab:<>}
        \end{table}
      ]], {
        c(1, { t("H"), t("htbp") }),
        i(2, "cc"),
        i(0),
        i(3),
        i(4),
      }
    )
  ),
}
