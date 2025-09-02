-- Set the markdown file use the tabindent values set in the config instead of recommended
vim.g.markdown_recommended_style = 0

-- FIXME: Vale is not configured correctly. It doesn't work
-- vim.lsp.enable("vale_ls")

-- marksman does not support configure its settings through lsp.
-- You can only create a `.marksman.toml` file in your project root.
vim.lsp.enable("marksman")

vim.lsp.config("harper_ls", {
  filetypes = { "markdown", "text", "tex", "plaintex" },
  settings = {
    ["harper-ls"] = {
      linters = {
        SentenceCapitalization = false,
        SpellCheck = false,
      },
    },
  },
})
vim.lsp.enable("harper_ls")

local M = {
  {
    "mason-org/mason.nvim",
    optional = true,
    opts_extend = { "ensure_installed" },
    opts = { ensure_installed = { "marksman", "harper-ls" } },
  },

  -- formatter
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        markdown = { "prettier" },
      },
    },
  },

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
    keys = {
      { "<leader>tm", desc = "Enable render markdown" },
    },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons", -- if you prefer nvim-web-devicons
    },
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {
      -- Disable by default, use keymap to toggle
      enabled = false,
      -- The plugin also provides a completion method using blink.cmp
      -- However, just enabling the general LSP conmpletions is enough
      completions = {
        lsp = { enabled = true },
      },
      -- Vim modes that will show a rendered view of the markdown file, :h mode(), for all enabled
      -- components. Individual components can be enabled for other modes. Remaining modes will be
      -- unaffected by this plugin.
      -- Default: render_modes = { "n", "c", "t" },
      -- Set to true to enable render in all modes
      render_modes = true,
      checkbox = {
        checked = { scope_highlight = "@markup.strikethrough" },
      },
      indent = {
        enabled = true,
        skip_heading = true,
      },
      latex = { enabled = false },

      code = {
        -- Disable the sign shown on the left of the line numbers
        sign = false,
      },
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

  -- The markview plugin needs to be loaded before nvim-treesitter
  -- {
  --   "nvim-treesitter/nvim-treesitter",
  --   dependencies = {
  --     "OXY2DEV/markview.nvim",
  --   },
  -- },
  --
  -- {
  --   "OXY2DEV/markview.nvim",
  --   -- Do not lazy load this plugin as it is already lazy-loaded.
  --   -- Lazy-loading will cause more time for the previews to load when starting Neovim.
  --   lazy = false,
  --
  --   opts = {
  --     preview = {
  --       modes = { "n", "no", "c", "i" },
  --       filetypes = { "md", "rmd", "quarto", "codecompanion" },
  --       icon_provider = "devicons", -- "internal", "mini" or "devicons"
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
      -- add options here or leave it empty to use the default settings
      default = {
        dir_path = "Figures", ---@type string | fun(): string

        extension = "jpg", ---@type string
        -- process_cmd = "convert - -quality 75 jpg:-", ---@type string

        use_absolute_path = false, ---@type boolean
        relative_to_current_file = false, ---@type boolean

        show_dir_path_in_prompt = true, ---@type boolean

        prompt_for_file_name = false, ---@type boolean
        file_name = "%y-%m-%d_%H-%M-%S", ---@type string
      },
      filetypes = {
        markdown = {
          -- encode spaces and special characters in file path
          url_encode_path = true, ---@type boolean

          template = "![Image]($FILE_PATH)", ---@type string
        },
      },
    },
    keys = {
      -- suggested keymap
      { "<leader>pi", "<CMD>PasteImage<CR>", desc = "[Img-Clip] Paste image from system clipboard" },
      {
        "<leader>pc",
        function()
          Snacks.picker.files({
            ft = { "jpg", "jpeg", "png", "webp" },
            confirm = function(self, item, _)
              self:close()
              require("img-clip").paste_image({}, "./" .. item.file) -- ./ is necessary for img-clip to recognize it as path
            end,
          })
        end,
        desc = "[Img-Clip] Choose an image to paste",
      },
    },
  },

  {
    "obsidian-nvim/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    dependencies = {
      -- Modified img-clip configs for obsidian vaults
      {
        "HakonHarnes/img-clip.nvim",
        optional = true,
        opts = {
          -- add options here or leave it empty to use the default settings
          default = {
            dir_path = "assets/imgs", ---@type string | fun(): string
          },
        },
      },
    },
    -- ft = "markdown",
    cmd = { "Obsidian" },
    keys = {
      { "<leader>OO", "<CMD>Obsidian<CR>", desc = "[Obsidian] Picker" },
      { "<leader>OD", "<CMD>Obsidian dailies<CR>", desc = "[Obsidian] Dailies" },
      { "<leader>Og", "<CMD>Obsidian search<CR>", desc = "[Obsidian] Search" },
      { "<leader>Of", "<CMD>Obsidian quick_switch<CR>", desc = "[Obsidian] Quick switch files" },
      { "<leader>Od", "<CMD>Obsidian follow_link<CR>", desc = "[Obsidian] Follow link" },
      { "<leader>Ob", "<CMD>Obsidian backlinks<CR>", desc = "[Obsidian] Back links" },
      { "<leader>Oq", "<CMD>Obsidian quick_switch<CR>", desc = "[Obsidian] Quick switch" },
      -- typos: ignore
      { "<leader>Ot", "<CMD>Obsidian tags<CR>", desc = "[Obsidian] Tags" }, -- codespell:ignore "Ot"
      { "<leader>Op", "<CMD>Obsidian paste_img<CR>", desc = "[Obsidian] Paste image" },
    },

    ---@module 'obsidian'
    ---@type obsidian.config
    opts = {
      workspaces = {
        {
          name = "Research Workspace",
          path = "~/Research/Obsidian_Workspace",
        },
      },

      -- Keep notes in a specific subdirectory of the vault.
      notes_subdir = "notes",
      -- Where to put new notes. Valid options are
      -- _ "current_dir" - put new notes in same directory as the current buffer.
      -- _ "notes_subdir" - put new notes in the default notes subdirectory.
      new_notes_location = "notes_subdir",
      -- Either 'wiki' or 'markdown'.
      preferred_link_style = "wiki",
      -- Optional, customize how wiki links are formatted. You can set this to one of:
      -- _ "use_alias_only", e.g. '[[Foo Bar]]'
      -- _ "prepend_note_id", e.g. '[[foo-bar|Foo Bar]]'
      -- * "prepend_note_path", e.g. '[[foo-bar.md|Foo Bar]]'
      -- * "use_path_only", e.g. '[[foo-bar.md]]'
      -- Or you can set it to a function that takes a table of options and returns a string
      -- Below is a function that can create the relative path like '[[../subdir/foo-bar.md|Foo Bar]]'
      -- wiki_link_func = function(opts)
      --   -- "prepend_note_path" will not generate the relative path if the note is in a subdirectory
      --   local path_from_workspace = require("obsidian.util").wiki_link_path_prefix(opts)
      --
      --   local rel_path = opts.path
      --   -- Remove the first two chars `[[` from path_from_workspace
      --   path_from_workspace = string.sub(path_from_workspace, 3)
      --
      --   -- Calculate the number of `/` occurred in rel_path
      --   local depth = #vim.split(rel_path, "/") - 1
      --   if depth == 0 then
      --     return "[[./" .. path_from_workspace
      --   end
      --   -- Generate the relative path prefix based on the depth
      --   local relative_path_prefix = string.rep("../", depth)
      --   return "[[" .. relative_path_prefix .. path_from_workspace
      -- end,
      ---@diagnostic disable-next-line: assign-type-mismatch
      wiki_link_func = "prepend_note_path",

      legacy_commands = false,

      footer = { enabled = false },

      daily_notes = {
        -- Optional, if you keep daily notes in a separate directory.
        folder = "dailies",
        -- Optional, if you want to change the date format for the ID of daily notes.
        date_format = "%Y-%m-%d",
        -- Optional, if you want to change the date format of the default alias of daily notes.
        alias_format = "%B %-d, %Y",
        -- Optional, default tags to add to each new daily note created.
        default_tags = { "daily-notes" },
        -- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
        template = nil,
        -- Optional, if you want `Obsidian yesterday` to return the last work day or `Obsidian tomorrow` to return the next work day.
        workdays_only = false,
      },

      completion = {
        -- Enables completion using nvim_cmp
        nvim_cmp = false,
        -- Enables completion using blink.cmp
        blink = true,
        -- Trigger completion at 2 chars.
        min_chars = 2,
        -- Set to false to disable new note creation in the picker
        create_new = true,
      },

      picker = {
        -- Set your preferred picker. Can be one of 'telescope.nvim', 'fzf-lua', 'mini.pick' or 'snacks.pick'.
        name = "snacks.pick",
        -- Optional, configure key mappings for the picker. These are the defaults.
        -- Not all pickers support all mappings.
        note_mappings = {
          -- Create a new note from your query.
          new = "<C-x>",
          -- Insert a link to the selected note.
          insert_link = "<C-l>",
        },
        tag_mappings = {
          -- Add tag(s) to current note.
          tag_note = "<C-l>",
          -- Insert a tag at the current location.
          insert_tag = "",
        },
      },

      -- Optional, for templates (see https://github.com/obsidian-nvim/obsidian.nvim/wiki/Using-templates)
      templates = {
        folder = "templates",
        date_format = "%Y-%m-%d",
        time_format = "%H:%M",
        -- A map for custom variables, the key should be the variable and the value a function.
        -- Functions are called with obsidian.TemplateContext objects as their sole parameter.
        -- See: https://github.com/obsidian-nvim/obsidian.nvim/wiki/Template#substitutions
        substitutions = {},

        -- A map for configuring unique directories and paths for specific templates
        --- See: https://github.com/obsidian-nvim/obsidian.nvim/wiki/Template#customizations
        customizations = {},
      },

      -- Optional, customize how note IDs are generated given an optional title.
      ---@param title string|?
      ---@return string
      note_id_func = function(title)
        -- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
        -- In this case a note with the title 'My new note' will be given an ID that looks
        -- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'.
        -- You may have as many periods in the note ID as you'd like—the ".md" will be added automatically
        local suffix = ""
        if title ~= nil then
          -- If title is given, transform it into valid file name.
          suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
        else
          -- If title is nil, just add 4 random uppercase letters to the suffix.
          for _ = 1, 4 do
            suffix = suffix .. string.char(math.random(65, 90))
          end
        end
        return tostring(os.time()) .. "-" .. suffix
      end,
    },
  },
}

return M
