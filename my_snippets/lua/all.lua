local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node

return {
  s("trig", t("loaded!!")),
  --   "module block": {
  --     "prefix": "module",
  --     "body": [
  --       "module ${1:FILENAME} (\n\t${2}\n);",
  --       "\t${0}",
  --       "\nendmodule"
  --     ],
  --     "description": "Module Block"
  --   },
  -- s("module", t("module "), i("test"), t(" (\n\t"), i(1), t("\n);"), t("\n"), i(0), t("\nendmodule")),
}
