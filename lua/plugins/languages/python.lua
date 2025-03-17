-- Python related plugins

local M = {}

M.plugins = {}

function M.setup(name)
  if name == G.language.lsp then
    require("lspconfig").pyright.setup({})
    -- require("lspconfig").pyright.setup({
    --   on_attach = require("lsp").common_on_attach,
    --   settings = {
    --     python = {
    --       analysis = {
    --         autoSearchPaths = true,
    --         useLibraryCodeForTypes = true,
    --       },
    --     },
    --   },
    -- })
  elseif name == G.language.formatter then
    return { "isort", "black" }
  end
end

return M
