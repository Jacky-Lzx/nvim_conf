local M = {}

function M.setup(setting_name, extra)
  if setting_name == G.language.lsp then
    vim.lsp.config("lua_ls", {
      settings = {
        Lua = {},
      },
    })

    vim.lsp.enable("lua_ls")

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
  {
    "mason-org/mason.nvim",
    optional = true,
    opts_extend = { "ensure_installed" },
    opts = { ensure_installed = { "stylua" } },
  },

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
