-- make zsh files recognized as sh for bash-ls & treesitter
vim.filetype.add({
  extension = {
    zsh = "sh",
    sh = "sh", -- force sh-files with zsh-shebang to still get sh as filetype
  },
  filename = {
    [".zshrc"] = "sh",
    [".zshenv"] = "sh",
  },
})

local M = {}

function M.setup(setting_name, extra)
  if setting_name == G.language.lsp then
    -- on_attach = extra.on_attach,
    -- capabilities = extra.capabilities,
    require("lspconfig").bashls.setup({
      filetypes = { "sh", "zsh", "bash" },
      capabilities = extra.capabilities,
    })

    return
  end

  if setting_name == G.language.formatter then
    return { "shfmt" }
  end

  if setting_name == G.language.linter then
    return
  end

  require("notify")("Unknown setting for language `sh|bash|zsh`: " .. setting_name)
end

M.plugins = {
  {
    "mason-org/mason.nvim",
    optional = true,
    opts_extend = { "ensure_installed" },
    opts = { ensure_installed = { "shfmt" } },
  },
}

return M
