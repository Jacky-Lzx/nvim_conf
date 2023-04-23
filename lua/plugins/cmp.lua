-- require("plugin-settings.cmp")
return {
  {
    "L3MON4D3/LuaSnip",
    lazy = true,
    event = "InsertEnter",
    -- follow latest release.
    -- version = "v<CurrentMajor>.*",
    version = "v1.*",
    -- install jsregexp (optional!:).
    build = "make install_jsregexp",
    cmd = "SnippetList",
    -- stylua: ignore
    keys = {
      { "<M-l>" , function() require('luasnip').jump(1) end,                         mode = { "i", "s" }, silent = true, desc = "luasnip jump 1" },
      { "<M-h>" , function() require('luasnip').jump(-1) end,                        mode = { "i", "s" }, silent = true, desc = "luasnip jump -1" },
      { "<C-E>" , "luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'", mode = { "i", "s" }, silent = true, desc = "luasnip choise", remap = true, expr = true },
    },
    opts = {
      history = true,
      delete_check_events = "TextChanged",
    },
    config = function(_, opts)
      require("luasnip.loaders.from_vscode").load({ paths = { "./my_snippets" } }) -- Load snippets from my-snippets folder

      require("luasnip").setup(opts)

      vim.api.nvim_create_user_command("SnippetList", require("luasnip.extras.snippet_list").open, {})
    end,
  },

  {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup()
    end,
  },

  -- {
  --   "echasnovski/mini.pairs",
  --   event = "VeryLazy",
  --   config = function(_, opts)
  --     require("mini.pairs").setup(opts)
  --   end,
  -- },

  {
    "hrsh7th/nvim-cmp",
    version = false, -- last release is way too old
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      -- "hrsh7th/cmp-path",
      "FelipeLema/cmp-async-path", -- { name = 'async_path' }
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-cmdline", -- { name = 'cmdline' }
      "saadparwaiz1/cmp_luasnip",
      "onsails/lspkind-nvim",
    },
    opts = function()
      local cmp = require("cmp")
      local lspkind = require("lspkind")
      return {
        completion = {
          completeopt = "menu,menuone,noinsert",
        },
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          -- ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
          -- ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
          -- ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          -- ["<C-f>"] = cmp.mapping.scroll_docs(4),
          -- ["<C-Space>"] = cmp.mapping.complete(),
          -- ["<C-e>"] = cmp.mapping.abort(),
          -- ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
          -- ["<S-CR>"] = cmp.mapping.confirm({
          --   behavior = cmp.ConfirmBehavior.Replace,
          --   select = true,
          -- }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
          ["<C-k>"] = cmp.mapping.select_prev_item(),
          ["<M-k>"] = cmp.mapping.select_prev_item(),
          ["<S-TAB>"] = cmp.mapping.select_prev_item(),
          -- 下一个
          ["<C-j>"] = cmp.mapping.select_next_item(),
          ["<M-j>"] = cmp.mapping.select_next_item(),
          ["<TAB>"] = cmp.mapping.select_next_item(),
          -- 出现补全
          ["<A-/>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
          -- 取消
          ["<A-,>"] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
          }),
          -- 确认
          -- Accept currently selected item. If none selected, `select` first item.
          -- Set `select` to `false` to only confirm explicitly selected items.
          -- ["<CR>"] = cmp.mapping.confirm({
          --   select = false,
          --   -- behavior = cmp.ConfirmBehavior.Replace,
          -- }),
          -- ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
          ["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
          ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),

          ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
          ["<S-CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        }),
        sources = cmp.config.sources({
          -- { name = "nvim_lsp" },
          {
            name = "nvim_lsp",
            entry_filter = function(entry, ctx)
              return require("cmp").lsp.CompletionItemKind.Text ~= entry:get_kind()
            end,
          },
          { name = "luasnip" },
          -- { name = "buffer" },
          { name = "async_path" },
        }),
        formatting = {
          -- format = function(_, item)
          --   local icons = require("lazyvim.config").icons.kinds
          --   if icons[item.kind] then
          --     item.kind = icons[item.kind] .. item.kind
          --   end
          --   return item
          -- end,
          format = lspkind.cmp_format({
            with_text = true, -- do not show text alongside icons
            -- mode = 'symbol', -- show only symbol annotations
            maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
            ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
            before = function(entry, vim_item)
              vim_item.menu = "[" .. entry.source.name .. "]"
              return vim_item
            end,
          }),
        },
        enabled = function()
          -- disable completion in comments
          local context = require("cmp.config.context")
          -- keep command mode completion enabled when cursor is in a comment
          if vim.api.nvim_get_mode().mode == "c" then
            return true
          else
            return not context.in_treesitter_capture("comment") and not context.in_syntax_group("Comment")
          end
        end,
        experimental = {
          ghost_text = {
            hl_group = "LspCodeLens",
          },
        },
      }
    end,
    config = function(_, opts)
      local cmp = require("cmp")
      cmp.setup(opts)

      -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline({ "/", "?" }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" },
        },
      })

      -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "async_path" },
        }, {
          { name = "cmdline" },
        }),
      })

      -- If you want insert `(` after select function or method item
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      -- cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
      local handlers = require("nvim-autopairs.completion.handlers")

      cmp.event:on(
        "confirm_done",
        cmp_autopairs.on_confirm_done({
          filetypes = {
            -- "*" is a alias to all filetypes
            ["*"] = {
              ["("] = {
                kind = {
                  cmp.lsp.CompletionItemKind.Function,
                  cmp.lsp.CompletionItemKind.Method,
                },
                handler = handlers["*"],
              },
            },
            -- Disable for tex
            tex = false,
          },
        })
      )
    end,
  },
}
