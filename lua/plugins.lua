local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- local plugins = {}
local opts = {
	git = {
		clone_timeout = 600,
		url_format = "git@github.com:%s.git",
	},
}

-- require("lazy").setup(plugins, opts)
require("lazy").setup({
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
	},
	{
		"ggandor/leap.nvim",
		dependencies = { "tpope/vim-repeat" },
	},
	{
		"folke/noice.nvim",
		config = function()
			-- require("noice").setup({
			--   -- add any options here
			-- })
		end,
		dependencies = {
			-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
			"MunifTanjim/nui.nvim",
			-- OPTIONAL:
			--   `nvim-notify` is only needed, if you want to use the notification view.
			--   If not available, we use `mini` as the fallback
			"rcarriga/nvim-notify",
		},
	},
	{
		-- LSP Configuration & Plugins
		"neovim/nvim-lspconfig",
		dependencies = {
			-- Automatically install LSPs to stdpath for neovim
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",

			-- Useful status updates for LSP
			-- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
			{ "j-hui/fidget.nvim", opts = {} },

			-- Additional lua configuration, makes nvim stuff amazing!
			"folke/neodev.nvim",
		},
	},

	{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	"nvim-telescope/telescope-ui-select.nvim",
	{
		"nvim-telescope/telescope.nvim",
		version = "0.1.1",
		-- or                              , branch = '0.1.1',
		dependencies = { "nvim-lua/plenary.nvim" },
		extensions = {
			fzf = {
				fuzzy = true, -- false will only do exact matching
				override_generic_sorter = true, -- override the generic sorter
				override_file_sorter = true, -- override the file sorter
				case_mode = "smart_case", -- or "ignore_case" or "respect_case"
				-- the default case_mode is "smart_case"
			},
		},
	},
	-- use({
	--   "nvim-telescope/telescope.nvim",
	--   version = "0.1.1",
	--   requires = { { "nvim-lua/plenary.nvim" } },
	--   extensions = {
	--     fzf = {
	--       fuzzy = true,                   -- false will only do exact matching
	--       override_generic_sorter = true, -- override the generic sorter
	--       override_file_sorter = true,    -- override the file sorter
	--       case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
	--       -- the default case_mode is "smart_case"
	--     },
	--   },
	-- })
	-- The command of Buffer delete
	"moll/vim-bbye",
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons", lazy = true },
	},
	{
		"kdheepak/tabline.nvim",
		dependencies = { { "nvim-lualine/lualine.nvim", lazy = true }, { "nvim-tree/nvim-web-devicons", lazy = true } },
	},
	{ "numToStr/Comment.nvim" },
	{
		"nvim-tree/nvim-tree.lua",
		dependencies = {
			"nvim-tree/nvim-web-devicons", -- optional, for file icons
		},
	},
	{ "numToStr/FTerm.nvim" },
	{
		"cappyzawa/trim.nvim",
	},
	{ "norcalli/nvim-colorizer.lua" },
	{ "mbbill/undotree" },
	{
		"lukas-reineke/indent-blankline.nvim",
	},
	{
		"goolord/alpha-nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},
	{
		"nvim-treesitter/nvim-treesitter",
		"nvim-treesitter/nvim-treesitter-context",
		-- build = function()
		--   local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
		--   ts_update()
		-- end,
		build = ":TSUpdate",
		-- {{"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"}}
	},
	{
		"kylechui/nvim-surround",
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
	},
	"lewis6991/gitsigns.nvim",
	-- use("kevinhwang91/nvim-hlslens") -- Conflicted with vscode_nvim, don't know way
	"petertriho/nvim-scrollbar",

	-- use({ "edluffy/specs.nvim", config = require("plugin-settings.specs") })

	"windwp/nvim-autopairs",
	"hrsh7th/cmp-nvim-lsp", -- { name = nvim_lsp }
	"hrsh7th/cmp-buffer", -- { name = 'buffer' },
	-- use("hrsh7th/cmp-path") -- { name = 'path' }
	"FelipeLema/cmp-async-path", -- { name = 'async_path' }
	"hrsh7th/cmp-cmdline", -- { name = 'cmdline' }
	"hrsh7th/nvim-cmp",
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
	"dstein64/vim-startuptime",

	{
		"jose-elias-alvarez/null-ls.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	"mhartington/formatter.nvim",

	"mg979/vim-visual-multi",

	"lewis6991/hover.nvim",

	-- use({ "stevearc/aerial.nvim", config = require("aerial").setup() })
	"lervag/vimtex",

	"ibhagwan/smartyank.nvim",
	{ "ellisonleao/gruvbox.nvim", lazy = false },
}, opts)

require("neodev").setup()

require("plugin-settings.mason")

require("gitsigns").setup()
-- require("scrollbar.handlers.search").setup({ nearest_only = true })
require("scrollbar.handlers.gitsigns").setup()

require("scrollbar").setup({
	handle = {
		text = " ",
		blend = 60, -- Integer between 0 and 100. 0 for fully opaque and 100 to full transparent. Defaults to 30.
		color = nil,
		color_nr = nil, -- cterm
		-- highlight = "StatusLineNC",
		highlight = "CursorLine",
		hide_if_all_visible = true, -- Hides handle if all lines are visible
	},
})

-- require("hlslens").setup({
-- 	-- auto_enable = false,
-- 	-- calm_down = true,
-- 	nearest_only = true,
-- 	-- nearest_float_when = "always",
-- 	-- override_lens = function() end,
-- })

require("plugin-settings.cmp")
require("plugin-settings/hop")
require("plugin-settings/leap")
require("plugin-settings/comment")
require("plugin-settings.telescope")
require("plugin-settings/nvim-tree")
require("plugin-settings.fterm")

-- require("colorizer").setup()
require("plugin-settings.lualine")
require("plugin-settings.tabline")
require("plugin-settings/undotree")

require("which-key").setup()
require("plugin-settings/formatter")
require("plugin-settings/null-ls")
require("plugin-settings/nvim-treesitter")
require("nvim-autopairs").setup()
require("plugin-settings/luasnip")
require("plugin-settings/hover")
require("plugin-settings/vimtex")

require("nvim-surround").setup({
	-- Configuration here, or leave empty to use defaults
})
require("plugin-settings.noice")

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
require("alpha").setup(require("alpha.themes.startify").config)

require("trim").setup()

require("indent_blankline").setup({
	space_char_blankline = " ",
	show_current_context = true,
	show_current_context_start = true,
})

require("plugin-settings/gruvbox")
