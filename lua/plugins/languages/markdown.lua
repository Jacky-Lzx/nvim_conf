local M = {}

function M.setup(setting_name)
  if setting_name == G.language.lsp then
    require("lspconfig").marksman.setup({})
    require("lspconfig").vale_ls.setup({})
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
    --   vim.g.mkdp_filetypes = { "markdown" }
    -- end,
    ft = { "markdown" },
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = "markdown",
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons", "hrsh7th/nvim-cmp" }, -- if you prefer nvim-web-devicons
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {
      completions = { lsp = { enabled = true } },
    },
    config = function(_, opts)
      require("render-markdown").setup(opts)

      local cmp = require("cmp")
      cmp.setup({
        sources = cmp.config.sources({
          { name = "render-markdown" },
        }),
      })
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
  {
    "3rd/image.nvim",
    ft = { "markdown" },
    dependencies = {
      {
        "vhyrro/luarocks.nvim",
        priority = 1001, -- this plugin needs to run before anything else
        opts = {
          rocks = { "magick" },
        },
      },
    },
    opts = {
      window_overlap_clear_enabled = true,
      editor_only_render_when_focused = false, -- auto show/hide images when the editor gains/looses focus
      tmux_show_only_in_active_window = true, -- auto show/hide images in the correct Tmux window (needs visual-activity off)
    },
  },
  -- {
  --   "edluffy/hologram.nvim",
  --   opts = {
  --     auto_display = true, -- WIP automatic markdown image display, may be prone to breaking
  --   },
  -- },

  -- Obsidian Plugin
  {
    "epwalsh/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    lazy = true,
    ft = "markdown",
    -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
    event = {
      -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
      -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
      -- refer to `:h file-pattern` for more examples
      "BufReadPre ~/Documents_lzx/Obsidian/Research/*.md",
      "BufNewFile ~/Documents_lzx/Obsidian/Research/*.md",
    },
    dependencies = {
      -- Required.
      "nvim-lua/plenary.nvim",

      -- see below for full list of optional dependencies 👇
    },
    opts = {
      workspaces = {
        {
          name = "research",
          path = "~/Documents_lzx/Obsidian/Research",
        },
      },

      -- see below for full list of options 👇
    },
  },
}

return M
