local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end
-- require("plugin-settings.cmp")
return {

  {
    "L3MON4D3/LuaSnip",
    lazy = true,
    event = "InsertEnter",
    -- follow latest release.
    -- version = "v<CurrentMajor>.*",
    version = "v2.*",
    -- install jsregexp (optional!:).
    build = "make install_jsregexp",
    cmd = "SnippetList",
    -- stylua: ignore
    keys = {
      { "<A-l>" , function() require('luasnip').jump(1) end,                         mode = { "i", "s" }, silent = true, desc = "luasnip jump 1" },
      { "<A-h>" , function() require('luasnip').jump(-1) end,                        mode = { "i", "s" }, silent = true, desc = "luasnip jump -1" },
      { "<A-j>" , function() local ls = require('luasnip'); if ls.choice_active() then ls.change_choice(1) end end,                mode = { "i", "s" }, silent = true, desc = "luasnip jump 1" },
      { "<A-k>" , function() local ls = require('luasnip'); if ls.choice_active() then ls.change_choice(-1) end end,               mode = { "i", "s" }, silent = true, desc = "luasnip jump -1" },
      { "<C-E>" , "luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'", mode = { "i", "s" }, silent = true, desc = "luasnip choise", remap = true, expr = true },
    },
    opts = function()
      local types = require("luasnip.util.types")
      return {
        history = true,
        delete_check_events = "TextChanged",
        exit_roots = true,
        ext_opts = {
          [types.choiceNode] = {
            active = {
              virt_text = { { "", "BlinkCmpKindEnum" } },
            },
            snippet_passive = {
              virt_text = { { "", "BlinkCmpLabel" } },
            },
            passive = {
              virt_text = { { "", "BlinkCmpLabel" } },
            },
          },
        },
        enable_autosnippets = true,
      }
    end,
    config = function(_, opts)
      require("luasnip").setup(opts)

      require("luasnip.loaders.from_vscode").lazy_load({ paths = { "./my_snippets/snippets" } }) -- Load snippets from my-snippets folder
      -- require("luasnip.loaders.from_vscode").lazy_load({ paths = { "./my_snippets/friendly-snippets" } })
      require("luasnip.loaders.from_lua").lazy_load({ paths = { "./lua/templates/snippets" } })

      -- local ls = require("luasnip")
      -- ls.filetype_extend("systemverilog", { "verilog" })

      vim.api.nvim_create_user_command("SnippetList", require("luasnip.extras.snippet_list").open, {})
    end,
  },

  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
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

  -- Integrate copilot completion in cmp

  -- {
  --   "hrsh7th/nvim-cmp",
  --   version = false, -- last release is way too old
  --   event = { "InsertEnter", "CmdlineEnter" },
  --   dependencies = {
  --     "hrsh7th/cmp-nvim-lsp",
  --     "hrsh7th/cmp-buffer",
  --     "hrsh7th/cmp-path",
  --     "FelipeLema/cmp-async-path", -- { name = 'async_path' }
  --     -- "saadparwaiz1/cmp_luasnip",
  --     "hrsh7th/cmp-cmdline", -- { name = 'cmdline' }
  --     "saadparwaiz1/cmp_luasnip",
  --     "onsails/lspkind-nvim",
  --     "lukas-reineke/cmp-under-comparator",
  --   },
  --   opts = function()
  --     local cmp = require("cmp")
  --     local lspkind = require("lspkind")
  --     return {
  --       completion = {
  --         completeopt = "menu,menuone,noinsert",
  --       },
  --       snippet = {
  --         expand = function(args)
  --           require("luasnip").lsp_expand(args.body)
  --         end,
  --       },
  --       window = {
  --         completion = cmp.config.window.bordered(),
  --         documentation = cmp.config.window.bordered(),
  --       },
  --       -- stylua: ignore
  --       mapping = cmp.mapping.preset.insert({
  --         ["<M-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
  --         ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
  --         ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
  --         ["<M-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
  --         -- Show/Remove completion
  --         ["<A-/>"] = cmp.mapping(function(_) if cmp.visible() then cmp.abort() else cmp.complete() end end, { "i", "c" }),
  --         -- ["<A-/>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
  --
  --         -- ["<C-m>"] = cmp.mapping(cmp.complete(), { "i", "c" }),
  --
  --         ["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
  --         ["<M-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
  --         ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
  --         ["<M-d>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
  --
  --         ["<Tab>"] = cmp.mapping.confirm({ select = false }),
  --         ["<CR>"] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  --         -- Close current completion and insert a newline
  --         ["<S-CR>"] = cmp.mapping(function(fallback) if cmp.visible() then cmp.close() end fallback() end, { "i", "s" }),
  --       }),
  --       -- stylua: ignore
  --       sources = cmp.config.sources({
  --         { name = "copilot", group_indx = 2 },
  --         -- Don't use this one, it conflicts with marksman lsp
  --         -- { name = "nvim_lsp", entry_filter = function(entry, _) return require("cmp").lsp.CompletionItemKind.Text ~= entry:get_kind() end, },
  --         { name = "nvim_lsp" },
  --         { name = "luasnip" },
  --         { name = "async_path" },
  --         -- { name = "buffer" },
  --       }),
  --       formatting = {
  --         -- format = function(entry, vim_item)
  --         --   if entry.source.name == "nvim_lsp" then
  --         --     -- Display which LSP servers this item came from.
  --         --     local lspserver_name = nil
  --         --     pcall(function()
  --         --       lspserver_name = entry.source.source.client.name
  --         --       vim_item.menu = lspserver_name
  --         --     end)
  --         --   end
  --         --   return vim_item
  --         -- end,
  --         format = lspkind.cmp_format({
  --           mode = "symbol_text",
  --           maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
  --           ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
  --           symbol_map = { Copilot = "" },
  --           before = function(entry, vim_item)
  --             if entry.source.name == "nvim_lsp" then
  --               -- Display which LSP servers this item came from.
  --               local lspserver_name = nil
  --               pcall(function()
  --                 lspserver_name = entry.source.source.client.name
  --                 vim_item.menu = lspserver_name
  --               end)
  --             end
  --             return vim_item
  --           end,
  --         }),
  --       },
  --       enabled = true,
  --       experimental = {
  --         ghost_text = {
  --           hl_group = "LspCodeLens",
  --         },
  --       },
  --       -- sorting = {
  --       --   comparators = {
  --       --     cmp.config.compare.offset,
  --       --     cmp.config.compare.exact,
  --       --     cmp.config.compare.score,
  --       --     require("cmp-under-comparator").under,
  --       --     cmp.config.compare.kind,
  --       --     cmp.config.compare.sort_text,
  --       --     cmp.config.compare.length,
  --       --     cmp.config.compare.order,
  --       --   },
  --       -- },
  --     }
  --   end,
  --
  --   config = function(_, opts)
  --     local cmp = require("cmp")
  --     cmp.setup(opts)
  --
  --     local commandline_keymappings = {
  --       ["<Tab>"] = { c = cmp.mapping.confirm({ select = true }) },
  --       ["<M-j>"] = { c = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }) },
  --       ["<C-n>"] = { c = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }) },
  --       ["<C-p>"] = { c = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }) },
  --       ["<M-k>"] = { c = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }) },
  --     }
  --
  --     -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
  --     cmp.setup.cmdline({ "/", "?" }, {
  --       mapping = cmp.mapping.preset.cmdline(commandline_keymappings),
  --       sources = {
  --         { name = "buffer" },
  --       },
  --     })
  --
  --     -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  --     cmp.setup.cmdline(":", {
  --       mapping = cmp.mapping.preset.cmdline(commandline_keymappings),
  --       sources = cmp.config.sources({
  --         { name = "async_path" },
  --       }, {
  --         { name = "cmdline" },
  --       }),
  --       -- matching = { disallow_symbol_nonprefix_matching = false },
  --     })
  --
  --     -- If you want insert `(` after select function or method item
  --     local cmp_autopairs = require("nvim-autopairs.completion.cmp")
  --     -- cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
  --     local handlers = require("nvim-autopairs.completion.handlers")
  --     cmp.event:on(
  --       "confirm_done",
  --       cmp_autopairs.on_confirm_done({
  --         filetypes = {
  --           -- "*" is a alias to all filetypes
  --           ["*"] = {
  --             ["("] = {
  --               kind = {
  --                 cmp.lsp.CompletionItemKind.Function,
  --                 cmp.lsp.CompletionItemKind.Method,
  --               },
  --               handler = handlers["*"],
  --             },
  --           },
  --           -- Disable for tex
  --           tex = false,
  --         },
  --       })
  --     )
  --   end,
  -- },
}
