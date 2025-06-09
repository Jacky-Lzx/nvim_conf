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

vim.lsp.config("bashls", {
  filetypes = { "sh", "zsh", "bash" },
})

local M = {
  {
    "mason-org/mason.nvim",
    optional = true,
    opts_extend = { "ensure_installed" },
    opts = { ensure_installed = { "shfmt" } },
  },
}

return M
