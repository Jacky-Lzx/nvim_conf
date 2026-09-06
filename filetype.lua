-- Keep zsh separate from sh so Bash formatters are not used for zsh syntax.
vim.filetype.add({
  extension = {
    zsh = "zsh",
  },
  filename = {
    [".zshrc"] = "zsh",
    [".zshenv"] = "zsh",
  },
})
