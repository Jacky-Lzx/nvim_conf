--[
-- LuaSnip Conditions
--]

local cond_obj = require("luasnip.extras.conditions")

local M = {}

--- NOTE: useful command `:InspectTree` for treesitter debugging

local MATH_ENV = {
  "inline_formula",
  "displayed_equation",
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
local function in_env(name)
  local buf = vim.api.nvim_get_current_buf()
  local node = vim.treesitter.get_node()

  while node do
    if string.match(node:type(), "environment$") then
      local begin_node = node:named_child(0)
      if begin_node and begin_node:type() == "begin" then
        local text_group_node = begin_node:named_child(0)
        if text_group_node then
          local env_name_node = text_group_node:named_child(0)
          if env_name_node and vim.treesitter.get_node_text(env_name_node, buf) == name then
            return true
          end
        end
      end
    end
    node = node:parent()
  end
  return false
end

M.in_env = cond_obj.make_condition(in_env)

function M.in_preamble()
  return not M.in_env("document")
end

function M.in_text()
  return M.env("document") and not M.in_math()
end

function M.in_tikz()
  return M.env("tikzpicture")
end

local function in_bullets()
  return in_env("itemize") or in_env("enumerate")
end

M.in_bullets = cond_obj.make_condition(in_bullets)

function M.in_align()
  return M.env("align") or M.env("align*") or M.env("aligned")
end

return M
