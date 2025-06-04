local M = {}

function M.setup(setting_name, extra)
  if setting_name == G.language.lsp then
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

vim.g.tex_flavor = "latex"

vim.lsp.config("texlab", {
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
-- FIXME: TeXLab does not work correctly in terms of formatting
-- vim.lsp.enable("texlab")

M.plugins = {
  -- formatter
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    keys = {},
    opts = {
      formatters_by_ft = {
        tex = { "latexindent" },
        -- bib = { "latexindent" },
      },
      formatters = {
        latexindent = {
          prepend_args = { "--local", vim.env.HOME .. "/.config/latexindent/lzx_settings.yaml" },
        },
      },
    },
  },

  -- Add BibTeX/LaTeX to treesitter
  -- FIXME: Not work, don't know why
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.highlight = opts.highlight or {}
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "bibtex" })
      end
      if type(opts.highlight.disable) == "table" then
        vim.list_extend(opts.highlight.disable, { "latex" })
      else
        opts.highlight.disable = { "latex" }
      end
    end,
  },

  {
    "lervag/vimtex",
    lazy = false, -- lazy-loading will disable inverse search
    config = function()
      -- Viewer options: One may configure the viewer either by specifying a built-in viewer method:
      vim.g.vimtex_view_enabled = true
      vim.g.vimtex_view_method = "skim"

      -- VimTeX uses latexmk as the default compiler backend. If you use it, which is strongly recommended, you probably don't need to configure anything.
      -- If you want another compiler backend, you can change it as follows.
      -- The list of supported backends and further explanation is provided in the documentation, see ":help vimtex-compiler".
      vim.g.vimtex_compiler_method = "latexmk"

      vim.g.vimtex_mappings_disable = { ["n"] = { "K" } } -- disable `K` as it conflicts with LSP hover
      vim.g.vimtex_quickfix_method = vim.fn.executable("pplatex") == 1 and "pplatex" or "latexlog"
    end,
    keys = {
      { "<localLeader>l", "", desc = "[VimTeX]", ft = "tex" },
    },
  },

  {
    "folke/which-key.nvim",
    optional = true,
    opts = {
      spec = {
        { "<leader>l", group = "[VimTeX]" },
      },
    },
  },

  -- Texlab is a popular Language Server for LaTeX, which supports Forward Search and Inverse Search between TeX and PDF files.
  -- nvim-texlabconfig provides some useful snippets to configure this capability for neovim and some viewers and a homonymous executable which allows a fast Inverse Search.
  -- Should setup pdf viewer as well, see the documentation
  {
    "f3fora/nvim-texlabconfig",
    -- build = "go build",
    build = "go build -o ~/.local/bin/", -- if e.g. ~/.local/bin/ is in $PATH
    ft = { "tex", "bib" }, -- Lazy-load on filetype

    opts = {},
    config = function(_, opts)
      require("texlabconfig").setup(opts)
    end,
  },
}

return M
