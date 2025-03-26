local ls = require("luasnip")
local s = ls.snippet
-- local sn = ls.snippet_node
local i = ls.insert_node
local t = ls.text_node
local fmta = require("luasnip.extras.fmt").fmta
local d = ls.dynamic_node
-- local f = ls.function_node

local utils = require("templates.snippets.utils.utils")
local conds = require("templates.snippets.utils.conditions")
-- local autosnippet = ls.extend_decorator.apply(s, { snippetType = "autosnippet" })

return {
  -- stylua: ignore
  s({trig = "stylua-ignore", desc = "Ignore stylua"},
    {t("-- stylua: ignore")},
    {show_condition = conds.line_begin}
  ),

  -- stylua: ignore
  s({trig = "req", desc = "Require module"},
    fmta([[
      local <> = require("<>")
      ]], {
        d(2, utils.fun_i_node(utils.ext), {1}),
        i(1),
      }
    )
  ),

  -- stylua: ignore
  s({trig = "lfun", desc = "Local function" },
    fmta([[
      local function(<>)
        <>
      end
      ]],
      { i(1), i(0) }
    )
  ),
  -- stylua: ignore
  s({trig = "mfun", desc = "Method function" },
    fmta([[
      <>.<> = function(<>)
        <>
      end
      ]],
      { i(1, "M"), i(2), i(3), i(0) }
    )
  ),

  -- stylua: ignore
  s({trig = "fun", desc = "Function" },
    fmta([[
      function(<>)
        <>
      end
      ]],
      { i(1), i(0) }
    )
  ),

  s(
    { trig = "inspect", desc = "Inspect variable using snacks.debug" },
    { t('require("snacks.debug").inspect('), i(0), t(")") }
  ),

  s(
    { trig = "print", desc = "Print variable using snacks.notify" },
    { t('require("snacks.notify").info('), i(0), t(")") }
  ),
}
