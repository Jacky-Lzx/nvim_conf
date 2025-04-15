---@meta

---@alias setting string

---@class Global_settings
---@field language table<setting>
G = {
  language = {
    lsp = "lsp",
    formatter = "formatter",
    linter = "linter",
  },
}

---@type table<string>
---Enabled_languages
---  Language-specific settings are stored in `lua/plugins/languages/`
Enabled_languages = {
  "latex",
  "verilog",
  "python",
  "markdown",
  "rust",
  "lua",
  "bash",
}

---@type string
---Enabled colorscheme
Colorscheme = "catppuccin"
