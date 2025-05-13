-- Python related plugins
local M = {}

M.plugins = {}

function M.setup(setting_name, extra)
  if setting_name == G.language.lsp then
    vim.lsp.config("pyright", {
      capabilities = extra.capabilities,
    })

    -- require("lspconfig").pylsp.setup({
    --   -- on_attach = extra.on_attach,
    --   capabilities = extra.capabilities,
    --   settings = {
    --     pylsp = {
    --       plugins = {
    --         pycodestyle = {
    --           enabled = false,
    --         },
    --       },
    --     },
    --   },
    -- })

    return
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
