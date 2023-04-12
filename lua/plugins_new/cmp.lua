-- require("plugin-settings.cmp")
return {
	{
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup()
		end,
	},
	"hrsh7th/cmp-nvim-lsp", -- { name = nvim_lsp }
	"hrsh7th/cmp-buffer", -- { name = 'buffer' },
	-- use("hrsh7th/cmp-path") -- { name = 'path' }
	"FelipeLema/cmp-async-path", -- { name = 'async_path' }
	"hrsh7th/cmp-cmdline", -- { name = 'cmdline' }
	-- vsnip
	-- use("hrsh7th/cmp-vsnip") -- { name = 'vsnip' }
	-- use("hrsh7th/vim-vsnip")
	-- Luasnip
	{
		"L3MON4D3/LuaSnip",
		-- follow latest release.
		-- version = "v<CurrentMajor>.*",
		version = "v1.*",
		-- install jsregexp (optional!:).
		build = "make install_jsregexp",
	},
	"saadparwaiz1/cmp_luasnip",
	"rafamadriz/friendly-snippets",
	-- lspkind
	"onsails/lspkind-nvim",
	{
		"hrsh7th/nvim-cmp",
		config = function()
			local lspkind = require("lspkind")
			local cmp = require("cmp")

			-- The directories will have to be structured like eg. <https://github.com/rafamadriz/friendly-snippets> (include
			-- a similar `package.json`)
			require("luasnip.loaders.from_vscode").load({ paths = { "./my_snippets" } }) -- Load snippets from my-snippets folder
			-- require("luasnip.loaders.from_vscode").lazy_load()

			vim.cmd([[
  " press <Tab> to expand or jump in a snippet. These can also be mapped separately
  " via <Plug>luasnip-expand-snippet and <Plug>luasnip-jump-next.
  " imap <silent><expr> <M-l> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>'
  " -1 for jumping backwards.
  inoremap <silent> <M-l> <cmd>lua require'luasnip'.jump(1)<CR>
  inoremap <silent> <M-h> <cmd>lua require'luasnip'.jump(-1)<CR>

  snoremap <silent> <M-l> <cmd>lua require('luasnip').jump(1)<CR>
  snoremap <silent> <M-h> <cmd>lua require('luasnip').jump(-1)<CR>

  " For changing choices in choiceNodes (not strictly necessary for a basic setup).
  imap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'
  smap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'
]])

			vim.api.nvim_create_user_command("SnippetList", require("luasnip.extras.snippet_list").open, {})

			cmp.setup({
				completion = {
					completeopt = "menu,menuone,noinsert",
				},

				-- 指定 snippet 引擎
				snippet = {
					expand = function(args)
						-- For `vsnip` users.
						-- vim.fn["vsnip#anonymous"](args.body)

						-- For `luasnip` users.
						require("luasnip").lsp_expand(args.body)

						-- For `ultisnips` users.
						-- vim.fn["UltiSnips#Anon"](args.body)

						-- For `snippy` users.
						-- require'snippy'.expand_snippet(args.body)
					end,
				},
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				-- 来源
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					-- For vsnip users.
					-- { name = 'vsnip' },
					-- For luasnip users.
					{ name = "luasnip" },
					--For ultisnips users.
					-- { name = 'ultisnips' },
					-- -- For snippy users.
					-- { name = 'snippy' },
				}, { { name = "buffer" }, { name = "async_path" } }),

				-- 快捷键
				-- mapping = require'keybindings'.cmp(cmp),
				mapping = {
					-- 上一个
					["<C-k>"] = cmp.mapping.select_prev_item(),
					["<S-TAB>"] = cmp.mapping.select_prev_item(),
					-- 下一个
					["<C-j>"] = cmp.mapping.select_next_item(),
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
					["<CR>"] = cmp.mapping.confirm({
						select = false,
						-- behavior = cmp.ConfirmBehavior.Replace,
					}),
					-- ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
					["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
					["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),

					["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
					["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
					["<S-CR>"] = cmp.mapping.confirm({
						behavior = cmp.ConfirmBehavior.Replace,
						select = true,
					}), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
				},

				-- 使用lspkind-nvim显示类型图标
				formatting = {
					format = lspkind.cmp_format({
						with_text = true, -- do not show text alongside icons
						-- mode = 'symbol', -- show only symbol annotations
						maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
						ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
						before = function(entry, vim_item)
							-- Source 显示提示来源
							-- vim_item.menu = "[" .. string.upper(entry.source.name) .. "]"
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
			})

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

			-- -- Set up lspconfig.
			-- local capabilities = require("cmp_nvim_lsp").default_capabilities()
			-- -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
			-- require("lspconfig")["<YOUR_LSP_SERVER>"].setup({
			-- 	capabilities = capabilities,
			-- })

			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			-- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
			-- require("lspconfig")["lua-ls"].setup({
			-- 	capabilities = capabilities,
			-- })

			-- If you want insert `(` after select function or method item
			local cmp_autopairs = require("nvim-autopairs.completion.cmp")
			cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
		end,
	},
}
