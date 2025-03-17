local utils = require("utils")

local signs = { Error = "", Warn = "", Hint = "", Info = "" }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

return {
  {
    "ray-x/lsp_signature.nvim",
    event = "InsertEnter",
    opts = {
      bind = true,
      handler_opts = {
        border = "rounded",
      },
    },
    -- stylua: ignore
    keys = {
      { "gk", function() vim.lsp.buf.signature_help()  end, mode = { "n" }, desc = "toggle signature", noremap = true, silent = true },
      -- No use
      -- { "<C-i>", function() require("lsp_signature").toggle_float_win() end, mode = { "i" }, desc = "toggle signature", noremap = true, silent = true },
    },
    config = function(_, opts)
      require("lsp_signature").setup(opts)
    end,
  },
  -- cmdline tools and lsp servers
  {

    "williamboman/mason.nvim",
    cmd = "Mason",
    -- keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
    opts = {
      ensure_installed = {
        "stylua",
        "shfmt",
        -- "flake8",
      },
    },
    ---@param opts MasonSettings | {ensure_installed: string[]}
    config = function(_, opts)
      require("mason").setup(opts)
      local mr = require("mason-registry")
      local function ensure_installed()
        for _, tool in ipairs(opts.ensure_installed) do
          local p = mr.get_package(tool)
          if not p:is_installed() then
            p:install()
          end
        end
      end
      if mr.refresh then
        mr.refresh(ensure_installed)
      else
        ensure_installed()
      end
    end,
  },

  -- formatters
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    opts = {
      formatters_by_ft = utils.language_setup_return_table(G.language.formatter),
      format_on_save = {
        -- These options will be passed to conform.format()
        timeout_ms = 500,
        lsp_format = "fallback",
      },
    },
    config = function(_, opts)
      opts["formatters_by_ft"].javascript = { "prettierd", "prettier", stop_after_first = true }

      require("conform").setup(opts)
    end,
  },

  {
    "mfussenegger/nvim-lint",
    config = function()
      require("lint").linters_by_ft = utils.language_setup_return_table(G.language.linter)

      vim.api.nvim_create_autocmd({ "BufWritePost" }, {
        callback = function()
          -- try_lint without arguments runs the linters defined in `linters_by_ft`
          -- for the current filetype
          require("lint").try_lint()

          -- You can call `try_lint` with a linter name or a list of names to always
          -- run specific linters, independent of the `linters_by_ft` configuration
          -- require("lint").try_lint("cspell")
        end,
      })
    end,
  },

  {
    "jose-elias-alvarez/null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "mason.nvim" },
    opts = function()
      local nls = require("null-ls")
      return {
        root_dir = require("null-ls.utils").root_pattern(".null-ls-root", ".neoconf.json", "Makefile", ".git"),
        sources = {
          nls.builtins.formatting.fish_indent,
          nls.builtins.diagnostics.fish,
          nls.builtins.formatting.stylua,
          nls.builtins.formatting.shfmt,
          -- nls.builtins.formatting.verible_verilog_format,
          -- nls.builtins.diagnostics.flake8,
        },
      }
    end,
  },

  {
    -- LSP Configuration & Plugins
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "folke/neoconf.nvim", cmd = "Neoconf", config = true },
      { "folke/neodev.nvim", opts = { experimental = { pathStrict = true } } },
      "mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
      -- Useful status updates for LSP
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { "j-hui/fidget.nvim", opts = {} },
      "SmiteshP/nvim-navic",
    },
    opts = {
      -- options for vim.diagnostic.config()
      diagnostics = {
        underline = false,
        signs = false,
        update_in_insert = false,
        virtual_text = { spacing = 4, prefix = "●" },
        severity_sort = true,
      },
    },
    config = function(_, opts)
      vim.diagnostic.config(opts.diagnostics)

      local navic = require("nvim-navic")
      -- require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "rust_analyzer", "marksman", "jsonls" },
      })

      utils.language_setup(G.language.lsp)

      require("lspconfig").jsonls.setup({})

      -- require("lspconfig").ltex.setup({})
      require("lspconfig").clangd.setup({
        on_attach = function(client, bufnr)
          navic.attach(client, bufnr)
        end,
        cmd = {
          "clangd",
          -- "--header-insertion=never",
        },
      })

      -- require"lspconfig".efm.setup {
      --     init_options = {documentFormatting = true},
      --     filetypes = {"lua"},
      --     settings = {
      --         rootMarkers = {".git/"},
      --         languages = {
      --             lua = {
      --                 {
      --                     formatCommand = "lua-format -i --no-keep-simple-function-one-line --no-break-after-operator --column-limit=150 --break-after-table-lb",
      --                     formatStdin = true
      --                 }
      --             }
      --         }
      --     }
      -- }

      -- vim.keymap.set('n', '<leader>gf', vim.lsp.buf.format(), {})

      vim.keymap.set("n", "<space>E", vim.diagnostic.open_float, { desc = "Open diagnostic float" })
      vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic" })
      vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic" })
      vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, { desc = "List all diagnostics" })

      -- Use LspAttach autocommand to only map the following keys
      -- after the language server attaches to the current buffer
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(ev)
          -- Buffer local mappings.
          -- See `:help vim.lsp.*` for documentation on any of the below functions
          -- local opts_local = { buffer = ev.buf }
          local opts_local = {}
          vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts_local)
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts_local)
          -- vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
          vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts_local)
          -- vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
          vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts_local)
          vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts_local)
          vim.keymap.set("n", "<space>wl", function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          end, opts_local)
          vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts_local)
          vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, { buffer = ev.buf, desc = "Rename" })
          -- vim.keymap.set("n", "<leader>a", vim.lsp.buf.code_action, { buffer = ev.buf, desc = "Code actions" })
          vim.keymap.set("n", "gr", vim.lsp.buf.references, opts_local)
          -- vim.keymap.set("n", "<space>f", function()
          -- 	vim.lsp.buf.format({ async = true })
          -- end, opts)
        end,
      })
    end,
  },
  {
    "lewis6991/hover.nvim",
    config = function()
      require("hover").setup({
        init = function()
          -- Require providers
          require("hover.providers.lsp")
          -- require('hover.providers.gh')
          -- require('hover.providers.gh_user')
          -- require('hover.providers.jira')
          -- require('hover.providers.man')
          -- require('hover.providers.dictionary')
        end,
        preview_opts = {
          border = nil,
        },
        -- Whether the contents of a currently open hover window should be moved
        -- to a :h preview-window when pressing the hover keymap.
        preview_window = false,
        title = true,
      })

      -- Setup keymaps
      vim.keymap.set("n", "K", require("hover").hover, { desc = "hover.nvim" })
      vim.keymap.set("n", "gK", require("hover").hover_select, { desc = "hover.nvim (select)" })
    end,
  },
}
