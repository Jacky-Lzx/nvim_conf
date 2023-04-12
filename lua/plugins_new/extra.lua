return {
	{
		"folke/neoconf.nvim",
		cmd = "Neoconf",
	},
	{
		"folke/neodev.nvim",
		config = function()
			require("neodev").setup()
		end,
	},

	-- use({ "stevearc/aerial.nvim", config = require("aerial").setup() })
	{
		"lervag/vimtex",
		config = function()
			-- Viewer options: One may configure the viewer either by specifying a built-in
			-- viewer method:
			vim.g.vimtex_view_enabled = true
			vim.g.vimtex_view_method = "skim"

			-- Or with a generic interface:
			-- vim.g.vimtex_view_general_viewer = 'okular'
			-- vim.g.vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'

			-- VimTeX uses latexmk as the default compiler backend. If you use it, which is
			-- strongly recommended, you probably don't need to configure anything. If you
			-- want another compiler backend, you can change it as follows. The list of
			-- supported backends and further explanation is provided in the documentation,
			-- see ":help vimtex-compiler".
			vim.g.vimtex_compiler_method = "latexmk"

			-- Most VimTeX mappings rely on localleader and this can be changed with the
			-- following line. The default is usually fine and is the symbol "\".
			vim.cmd([[let maplocalleader = "\\"]])
		end,
	},
	"dstein64/vim-startuptime",

	{
		"ibhagwan/smartyank.nvim",
		config = function()
			require("smartyank").setup({
				highlight = {
					enabled = true, -- highlight yanked text
					higroup = "IncSearch", -- highlight group of yanked text
					timeout = 400, -- timeout for clearing the highlight
				},
				clipboard = {
					enabled = true,
				},
				tmux = {
					enabled = true,
					-- remove `-w` to disable copy to host client's clipboard
					cmd = { "tmux", "set-buffer", "-w" },
				},
				osc52 = {
					enabled = true,
					-- escseq = 'tmux',     -- use tmux escape sequence, only enable if
					-- you're using tmux and have issues (see #4)
					ssh_only = true, -- false to OSC52 yank also in local sessions
					silent = false, -- true to disable the "n chars copied" echo
					echo_hl = "Directory", -- highlight group of the OSC52 echo message
				},
			})
		end,
	},
	"folke/which-key.nvim",

	{
		"folke/neoconf.nvim",
		cmd = "Neoconf",
	},
	"folke/neodev.nvim",

	-- use 'easymotion/vim-easymotion'
	{
		"phaazon/hop.nvim",
		branch = "v2", -- optional but strongly recommended
		config = function()
			require("hop").setup()
			local hop = require("hop")

			-- local directions = require("hop.hint").HintDirection

			-- vim.keymap.set({ 'n', 'v' }, '<leader>f', function()
			--   hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
			-- end, { remap = true })

			-- vim.keymap.set({ 'n', 'v' }, '<leader>s', function()
			--   -- hop.hint_char2({current_line_only = false})
			--   hop.hint_char2()
			-- end, { remap = true })

			-- :HopLine
			-- vim.keymap.set({ "n", "v" }, "<leader>j", function()
			--   hop.hint_lines({ direction = directions.AFTER_CURSOR, current_line_only = false })
			-- end, { remap = true })

			-- vim.keymap.set({ "n", "v" }, "<leader>k", function()
			--   hop.hint_lines({ direction = directions.BEFORE_CURSOR, current_line_only = false })
			-- end, { remap = true })

			vim.keymap.set({ "n", "v" }, "<leader>j", function()
				hop.hint_lines({ current_line_only = false })
			end, { remap = true })

			vim.keymap.set({ "n", "v" }, "<leader>k", function()
				hop.hint_lines({ current_line_only = false })
			end, { remap = true })
		end,
	},
	{
		"ggandor/leap.nvim",
		dependencies = { "tpope/vim-repeat" },
		config = function()
			require("leap").add_default_mappings()

			vim.keymap.del({ "n", "x", "o" }, "s")
			vim.keymap.del({ "n", "x", "o" }, "S")
			vim.keymap.del({ "x", "o" }, "x")
			vim.keymap.del({ "x", "o" }, "X")

			vim.keymap.set({ "n", "x", "o" }, "<leader>s", "<Plug>(leap-forward-to)")
			vim.keymap.set({ "n", "x", "o" }, "<leader>S", "<Plug>(leap-backward-to)")

			-- vim.keymap.set({ "n", "x", "o" }, "<leader>x", "<Plug>(leap-forward-till)")
			-- vim.keymap.set({ "n", "x", "o" }, "<leader>X", "<Plug>(leap-backward-till)")

			vim.keymap.set({ "n", "x", "o" }, "<leader>gs", "<Plug>(leap-from-window)")
		end,
	},
	-- 	-- The command of Buffer delete
	{
		"moll/vim-bbye",
		config = function()
			vim.keymap.set("n", "<leader>x", "<CMD>Bdelete<CR>")
		end,
	},

	{
		"lukas-reineke/indent-blankline.nvim",
		config = function()
			require("indent_blankline").setup({
				space_char_blankline = " ",
				show_current_context = true,
				show_current_context_start = true,
			})
		end,
	},
}
