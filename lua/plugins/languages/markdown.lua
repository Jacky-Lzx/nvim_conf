local M = {}

function M.setup(setting_name, extra)
  if setting_name == G.language.lsp then
    require("lspconfig").marksman.setup({
      on_attach = extra.on_attach,
      capabilities = extra.capabilities,
    })
    require("lspconfig").vale_ls.setup({
      on_attach = extra.on_attach,
      capabilities = extra.capabilities,
    })
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
    end,
  },

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
      { "<leader>p", "<cmd>PasteImage<cr>", desc = "Paste image from system clipboard" },
    },
  },
  -- {
  --   "adelarsq/image_preview.nvim",
  --   event = "VeryLazy",
  --   config = function()
  --     require("image_preview").setup()
  --   end,
  -- },
  -- {
  --   "3rd/image.nvim",
  --   ft = { "markdown" },
  --   opts = {
  --     processor = "magick_cli",
  --     window_overlap_clear_enabled = true,
  --     editor_only_render_when_focused = true, -- auto show/hide images when the editor gains/looses focus
  --     tmux_show_only_in_active_window = true, -- auto show/hide images in the correct Tmux window (needs visual-activity off)
  --   },
  -- },

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
