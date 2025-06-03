local M = {}

-- Set the markdown file use the tabindent values set in the config instead of recommended
vim.g.markdown_recommended_style = 0

function M.setup(setting_name, extra)
  if setting_name == G.language.lsp then
    vim.lsp.enable("vale_ls")
    vim.lsp.enable("marksman")

    return
  end

  if setting_name == G.language.formatter then
    return { "prettier" }
  end

  if setting_name == G.language.linter then
    return nil
  end

  require("notify")("Unknown setting for language `markdown`: " .. setting_name)
end

M.plugins = {
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle" },
    build = "cd app && yarn install",
    -- init = function()
    --   -- require("markdown-preview").setup(opts)
    --   vim.g.mkdp_filetypes = { "markdown" }
    -- end,
    ft = { "markdown" },
  },

  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown", "codecompanion" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons", -- if you prefer nvim-web-devicons
    },
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {
      completions = { lsp = { enabled = true } },
      -- Vim modes that will show a rendered view of the markdown file, :h mode(), for all enabled
      -- components. Individual components can be enabled for other modes. Remaining modes will be
      -- unaffected by this plugin.
      -- Default: render_modes = { "n", "c", "t" },
      -- Set to true to enable render in all modes
      render_modes = true,
      checkbox = { checked = { scope_highlight = "@markup.strikethrough" } },
      indent = {
        enabled = true,
        skip_heading = true,
      },
      latex = { enabled = false },
    },
    config = function(_, opts)
      require("render-markdown").setup(opts)

      require("snacks")
        .toggle({
          name = "Render Markdown",
          get = function()
            return require("render-markdown.state").enabled
          end,
          set = function(enabled)
            local m = require("render-markdown")
            if enabled then
              m.enable()
            else
              m.disable()
            end
          end,
        })
        :map("<leader>tm")
    end,
  },

  -- {
  --   "OXY2DEV/markview.nvim",
  --   -- Do not lazy load this plugin as it is already lazy-loaded.
  --   -- Lazy-loading will cause more time for the previews to load when starting Neovim.
  --   lazy = false,
  --
  --   opts = {
  --     preview = {
  --       modes = { "n", "no", "c", "i" },
  --     },
  --   },
  --
  --   -- For blink.cmp's completion
  --   -- source
  --   -- dependencies = {
  --   --     "saghen/blink.cmp"
  --   -- },
  -- },

  {
    "HakonHarnes/img-clip.nvim",
    opts = {
      -- add options here
      -- or leave it empty to use the default settings
      default = {
        dir_path = "Figures_Markdown", ---@type string | fun(): string
      },
    },
    keys = {
      -- suggested keymap
      { "<leader>pi", "<CMD>PasteImage<CR>", desc = "[Img-Clip] Paste image from system clipboard" },
    },
  },

  -- Obsidian Plugin
  -- {
  --   "epwalsh/obsidian.nvim",
  --   version = "*", -- recommended, use latest release instead of latest commit
  --   lazy = true,
  --   ft = "markdown",
  --   -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
  --   event = {
  --     -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
  --     -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
  --     -- refer to `:h file-pattern` for more examples
  --     "BufReadPre ~/Documents_lzx/Obsidian/Research/*.md",
  --     "BufNewFile ~/Documents_lzx/Obsidian/Research/*.md",
  --   },
  --   dependencies = {
  --     -- Required.
  --     "nvim-lua/plenary.nvim",
  --   },
  --   opts = {
  --     workspaces = {
  --       {
  --         name = "research",
  --         path = "~/Documents_lzx/Obsidian/Research",
  --       },
  --     },
  --   },
  -- },
}

return M
