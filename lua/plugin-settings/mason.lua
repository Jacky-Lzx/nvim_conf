require("mason").setup()
require("mason-lspconfig").setup({ensure_installed = {"lua_ls", "rust_analyzer"}})

require'lspconfig'.pyright.setup {}

require'lspconfig'.lua_ls.setup {
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT'
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = {'vim', 'use'}
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false -- THIS IS THE IMPORTANT LINE TO ADD -- https://github.com/neovim/nvim-lspconfig/issues/1700 -- Disables prompt
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {enable = false}
        }
    }
}

require'lspconfig'.marksman.setup {}
require'lspconfig'.ltex.setup {}

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
