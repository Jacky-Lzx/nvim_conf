--[
-- LuaSnip Conditions
--]

local cond_obj = require("luasnip.extras.conditions")

local has_treesitter, ts = pcall(require, "vim.treesitter")
local _, query = pcall(require, "vim.treesitter.query")

local M = {
  fn = {},
  obj = {},
}

--- NOTE: useful commands
--- Visualize treesitter: `<CMD>InspectTree<CR>`
--- Get current buffer: `local buf = vim.api.nvim_get_current_buf()`
--- Get the test of a node: `vim.treesitter.get_node_text(class_include, buf)`

local MATH_ENV = {
  inline_formula = true,
  displayed_equation = true,
  math_environment = true,
  text_mode = false,
}

-- math / not math zones
local function in_math()
  local node = vim.treesitter.get_node()
  while node do
    local result = MATH_ENV[node:type()]
    if result ~= nil and not result then
      return false
    end
    if result then
      return true
    end
    node = node:parent()
  end
  return false
end
M.fn.in_math = in_math

-- comment detection
local function in_comment()
  if not has_treesitter then
    return nil
  end

  local node = vim.treesitter.get_node()
  while node do
    if node:type() == "line_comment" then
      return true
    end
    node = node:parent()
  end
  return false
end
M.fn.in_comment = in_comment

-- document class
local function in_beamer()
  if not has_treesitter then
    return nil
  end

  local buf = vim.api.nvim_get_current_buf()

  local node = vim.treesitter.get_node()
  while node do
    if node:type() == "source_file" then
      local class_include = node:named_child(0)
      if class_include then
        -- require("snacks.debug").inspect(vim.treesitter.get_node_text(class_include, buf))
        local class_path = class_include:field("path")[1]
        if class_path then
          local field_path = class_path:field("path")[1]
          if vim.treesitter.get_node_text(field_path, buf) == "beamer" then
            return true
          end
        end
      end
    end
    node = node:parent()
  end
  return false
end
M.fn.in_beamer = in_beamer

-- general env function
local function in_env(name)
  if not has_treesitter then
    return nil
  end

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
