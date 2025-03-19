-- Python related plugins
local M = {}

M.plugins = {}

function M.setup(setting_name)
  if setting_name == G.language.lsp then
    local capabilities = require("blink.cmp").get_lsp_capabilities()
    require("lspconfig").pyright.setup({
      capabilities = capabilities,
    })
    return

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

    -- require("lspconfig").pylsp.setup({})
    -- require("lspconfig").python_lsp_server.setup({})
  end

  if setting_name == G.language.formatter then
    return { "isort", "black" }
  end

  if setting_name == G.language.linter then
    return
  end

  require("notify")("Unknown setting for language `python`: " .. setting_name)
end

return M
