local M = {}

function M.setup(setting_name, extra)
  if setting_name == G.language.lsp then
    vim.g.tex_flavor = "latex"

    require("lspconfig").texlab.setup({
      -- on_attach = extra.on_attach,
      capabilities = extra.capabilities,

      settings = {
        texlab = {
          build = {
            executable = "latexmk",
            args = {
              "%f",
            },
            onSave = true,
            forwardSearchAfter = false,
          },
          -- build = {
          --   executable = "tectonic",
          --   args = {
          --     "-X",
          --     "compile",
          --     "%f",
          --     "--synctex",
          --     "--keep-logs",
          --     "--keep-intermediates",
          --   },
          --   onSave = true,
          --   forwardSearchAfter = false,
          -- },
          -- Use Skim for preview and forward search
          -- The inverse search is configured in "f2fora/nvim-texlabconfig"
          forwardSearch = {
            executable = "/Applications/Skim.app/Contents/SharedSupport/displayline",
            args = { "-r", "%l", "%p", "%f" },
          },
          chktex = {
            onOpenAndSave = true,
            onEdit = false,
            additionalArgs = {
              "-wall",
              "-q",
              "-n1",
              "-n3",
              "-n8",
              "-n9",
              "-n22",
              "-n30",
              "-n24",
              "-n17",
              "-e16",
            },
          },
          bibtexFormatter = "texlab", -- @type "texlab" | "latexindent"; @default "texlab"
          latexFormatter = "latexindent", -- @type "texlab" | "latexindent"; @default "latexindent"
          latexindent = {
            -- ["local"] = "~/.config/latexindent/lzx_settings.yaml", -- local is a reserved keyword
            ["local"] = vim.env.HOME .. "/.config/latexindent/lzx_settings.yaml", -- local is a reserved keyword
            modifyLineBreaks = true, -- @default false
          },
        },
      },
    })

    -- require("notify")("Unknown setting for language `python`: " .. setting_name)
    return
  end

  if setting_name == G.language.formatter then
    return
  end

  if setting_name == G.language.linter then
    return
  end

  require("notify")("Unknown setting for language `LaTex`: " .. setting_name)
end

M.plugins = {
  -- Texlab is a popular Language Server for LaTeX, which supports Forward Search and Inverse Search between TeX and PDF files.
  -- nvim-texlabconfig provides some useful snippets to configure this capability for neovim and some viewers and a homonymous executable which allows a fast Inverse Search.
  -- Should setup pdf viewer as well, see the documentation
  {
    "f3fora/nvim-texlabconfig",
    build = "go build -o ~/.local/bin/", -- if e.g. ~/.local/bin/ is in $PATH
    ft = { "tex", "bib" }, -- Lazy-load on filetype

    opts = {},
    config = function(_, opts)
      require("texlabconfig").setup(opts)
    end,
    -- build = "go build",
  },
  -- {
  --   "lervag/vimtex",
  --   lazy = true,
  --   -- event = "BufEnter *.tex",
  --   ft = "tex",
  --   config = function()
  --     -- Viewer options: One may configure the viewer either by specifying a built-in
  --     -- viewer method:
  --     vim.g.vimtex_view_enabled = true
  --     vim.g.vimtex_view_method = "skim"
  --
  --     -- Or with a generic interface:
  --     -- vim.g.vimtex_view_general_viewer = 'okular'
  --     -- vim.g.vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'
  --
  --     -- VimTeX uses latexmk as the default compiler backend. If you use it, which is
  --     -- strongly recommended, you probably don't need to configure anything. If you
  --     -- want another compiler backend, you can change it as follows. The list of
  --     -- supported backends and further explanation is provided in the documentation,
  --     -- see ":help vimtex-compiler".
  --     vim.g.vimtex_compiler_method = "latexmk"
  --
  --     -- Most VimTeX mappings rely on localleader and this can be changed with the
  --     -- following line. The default is usually fine and is the symbol "\".
  --     vim.cmd([[let maplocalleader = "\\"]])
  --   end,
  -- },
}

return M
