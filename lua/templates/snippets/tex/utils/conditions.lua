--[
-- LuaSnip Conditions
--]

local cond_obj = require("luasnip.extras.conditions")

local has_treesitter, _ = pcall(require, "vim.treesitter")

local M = {}

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
function M.in_math()
  local node = vim.treesitter.get_node()
  while node do
    if not MATH_ENV[node:type()] then
      return false
    end
    if MATH_ENV[node:type()] then
      return true
    end
    node = node:parent()
  end
  return false
end

-- comment detection
function M.in_comment()
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

-- document class
function M.in_beamer()
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
