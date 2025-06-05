vim.g.tex_flavor = "latex"

vim.lsp.config("texlab", {
  settings = {
    texlab = {
      build = {
        executable = "latexmk",
        args = {
          "%f",
        },
        onSave = false,
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
        onOpenAndSave = false,
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
      bibtexFormatter = "none", -- @type "texlab" | "latexindent" | "none"; @default "texlab"
      latexFormatter = "none", -- @type "texlab" | "latexindent" | "none"; @default "latexindent"
      -- latexindent = {
      -- ["local"] = "~/.config/latexindent/lzx_settings.yaml", -- local is a reserved keyword
      -- ["local"] = vim.env.HOME .. "/.config/latexindent/lzx_settings.yaml", -- local is a reserved keyword
      -- modifyLineBreaks = true, -- @default false
      -- },
    },
  },
})
-- NOTE: Currently TeXLab does not work correctly in terms of formatting
vim.lsp.enable("texlab")

local M = {
  -- Add BibTeX/LaTeX to treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.highlight = opts.highlight or {}
      opts.ensure_installed = { "latex", "bibtex" }
      opts.highlight.disable = { "latex" }
    end,
  },

  {
    "mason-org/mason.nvim",
    optional = true,
    opts_extend = { "ensure_installed" },
    opts = { ensure_installed = { "tex-fmt" } },
  },

  -- formatter
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    keys = {},
    opts = {
      formatters_by_ft = {
        tex = { "tex-fmt" },
        -- tex = { "latexindent" },
        bib = { "tex-fmt" },
      },
      formatters = {
        ["tex-fmt"] = {
          prepend_args = { "-n" },
        },
        latexindent = {
          prepend_args = { "--local", vim.env.HOME .. "/.config/latexindent/lzx_settings.yaml" },
        },
      },
    },
  },

  -- linter
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = function(_, opts)
      opts.linters_by_ft = { tex = { "chktex" } }
      local chktex_l = require("lint").linters.chktex
      -- stylua: ignore
      chktex_l.args = {
        "-wall", "-q", "-n1", "-n3", "-n8", "-n9", "-n22", "-n30", "-n24", "-n17", "-e16",
        "-v0", "-I0", "-s", ":", "-f", "%l%b%c%b%d%b%k%b%n%b%m%b%b%b",
      }
      chktex_l.ignore_exitcode = true
    end,
  },

  {
    "lervag/vimtex",
    lazy = false, -- lazy-loading will disable inverse search
    keys = {
      { "<localLeader>l", "", desc = "[VimTeX]", ft = "tex" },
    },

    config = function()
      -- Viewer options: One may configure the viewer either by specifying a built-in viewer method:
      vim.g.vimtex_view_enabled = true
      vim.g.vimtex_view_zathura_use_synctex = 0
      vim.g.vimtex_view_method = "zathura_simple"
      -- vim.g.vimtex_view_method = "skim"

      -- VimTeX uses latexmk as the default compiler backend. If you use it, which is strongly recommended, you probably don't need to configure anything.
      -- If you want another compiler backend, you can change it as follows.
      -- The list of supported backends and further explanation is provided in the documentation, see ":help vimtex-compiler".
      vim.g.vimtex_compiler_method = "latexmk"

      vim.g.vimtex_mappings_disable = { ["n"] = { "K" } } -- disable `K` as it conflicts with LSP hover
      vim.g.vimtex_quickfix_method = vim.fn.executable("pplatex") == 1 and "pplatex" or "latexlog"

      vim.g.vimtex_syntax_conceal = {
        accents = 1,
        ligatures = 1,
        cites = 1,
        fancy = 1,
        spacing = 1,
        greek = 0,
        math_bounds = 1,
        math_delimiters = 1,
        math_fracs = 0,
        math_super_sub = 0,
        math_symbols = 0,
        sections = 0,
        styles = 1,
      }

      vim.g.vimtex_fold_enabled = 1
    end,
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
