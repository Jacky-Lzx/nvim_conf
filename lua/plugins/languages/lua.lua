local M = {}

function M.setup(setting_name)
  if setting_name == G.language.lsp then
    local capabilities = require("blink.cmp").get_lsp_capabilities()
    require("lspconfig").lua_ls.setup({
      capabilities = capabilities,
      settings = {
        Lua = {},
      },
    })
    return
  end

  if setting_name == G.language.formatter then
    return { "stylua" }
  end

  if setting_name == G.language.linter then
    return
  end

  require("notify")("Unknown setting for language `lua`: " .. setting_name)
end

M.plugins = {
  -- Provide neovim config completion
  -- Have its settings in blink.cmp in `completion.lua`
  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
}

return M
