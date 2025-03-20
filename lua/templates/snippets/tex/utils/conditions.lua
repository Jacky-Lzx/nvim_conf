--[
-- LuaSnip Conditions
--]

local M = {}

local MATH_ENV = {
  "inline_formula",
  "math_environment",
}
local NOT_MATH_ENV = {
  "text_mode",
}

-- math / not math zones

function M.in_math()
  local node = vim.treesitter.get_node()
  while node do
    if vim.tbl_contains(NOT_MATH_ENV, node:type()) then
      return false
    end
    if vim.tbl_contains(MATH_ENV, node:type()) then
      return true
    end
    node = node:parent()
  end
  return false
end

-- comment detection
function M.in_comment()
  return vim.fn["vimtex#syntax#in_comment"]() == 1
end

-- document class
function M.in_beamer()
  return vim.b.vimtex["documentclass"] == "beamer"
end

-- general env function
local function env(name)
  local is_inside = vim.fn["vimtex#env#is_inside"](name)
  return (is_inside[1] > 0 and is_inside[2] > 0)
end

function M.in_preamble()
  return not env("document")
end

function M.in_text()
  return env("document") and not M.in_math()
end

function M.in_tikz()
  return env("tikzpicture")
end

function M.in_bullets()
  return env("itemize") or env("enumerate")
end

function M.in_align()
  return env("align") or env("align*") or env("aligned")
end

return M
