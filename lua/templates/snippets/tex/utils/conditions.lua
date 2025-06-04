--[
-- LuaSnip Conditions
--]

local cond_obj = require("luasnip.extras.conditions")

local M = {
  fn = {},
  obj = {},
}

local function false_fn()
  return false
end
M.fn.false_fn = false_fn

-- math / not math zones
local function in_math()
  -- require("snacks.debug").inspect(vim.api.nvim_eval("vimtex#syntax#in_mathzone()"))
  return vim.api.nvim_eval("vimtex#syntax#in_mathzone()") == 1
end
M.fn.in_math = in_math

-- comment detection
local function in_comment()
  return vim.fn["vimtex#syntax#in_comment"]() == 1
end
M.fn.in_comment = in_comment

-- document class
local function in_beamer()
  return vim.b.vimtex["documentclass"] == "beamer"
end
M.fn.in_beamer = in_beamer

-- general env function
local function in_env(name)
  local is_inside = vim.fn["vimtex#env#is_inside"](name)
  return (is_inside[1] > 0 and is_inside[2] > 0)
end
M.fn.in_env = in_env

local function in_preamble()
  return not in_env("document")
end
M.fn.in_preamble = in_preamble

local function in_text()
  return in_env("document") and not in_math()
end
M.fn.in_text = in_text

local function in_tikz()
  return in_env("tikzpicture")
end
M.fn.in_tikz = in_tikz

local function in_bullets()
  return in_env("itemize") or in_env("enumerate")
end
M.fn.in_bullets = in_bullets

local function in_align()
  return in_env("align") or in_env("align*") or in_env("aligned")
end
M.fn.in_align = in_align

local function in_figure()
  return in_env("figure") or in_env("figure*")
end
M.fn.in_figure = in_figure

-- traverse all key-value pairs in M.fn
for k, v in pairs(M.fn) do
  M.obj[k] = cond_obj.make_condition(v)
end

return M
