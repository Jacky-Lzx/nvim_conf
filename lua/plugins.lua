-- Automatically install packer if not installed
local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
		vim.cmd([[packadd packer.nvim]])
		return true
	end
	return false
end
local packer_bootstrap = ensure_packer()

-- require('impatient')

require("packer").startup({
	function(use)
		-- Packer can manage itself
		use("wbthomason/packer.nvim")

		-- use 'easymotion/vim-easymotion'
		use({
			"phaazon/hop.nvim",
			branch = "v2", -- optional but strongly recommended
			config = function()
				-- you can configure Hop the way you like here; see :h hop-config
				require("hop").setup({ keys = "etovxqpdygfblzhckisuran" })
			end,
		})

		use({ "ellisonleao/gruvbox.nvim" })

		use({
			"nvim-tree/nvim-tree.lua",
			requires = {
				"nvim-tree/nvim-web-devicons", -- optional, for file icons
			},
			tag = "nightly", -- optional, updated every week. (see issue #1193)
		})

		use({
			"nvim-telescope/telescope.nvim",
			tag = "0.1.0",
			-- or                            , branch = '0.1.x',
			requires = { { "nvim-lua/plenary.nvim" } },
		})

		use({
			"numToStr/Comment.nvim",
			-- config = function()
			--     require('Comment').setup()
			-- end
		})

		use({
			"nvim-treesitter/nvim-treesitter",
			run = function()
				local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
				ts_update()
			end,
		})

		use("numToStr/FTerm.nvim")

		use({ "norcalli/nvim-colorizer.lua" })

		use({
			"nvim-lualine/lualine.nvim",
			requires = { "kyazdani42/nvim-web-devicons", opt = true },
		})

		use({
			"kdheepak/tabline.nvim",
			requires = { { "hoob3rt/lualine.nvim", opt = true }, { "kyazdani42/nvim-web-devicons", opt = true } },
		})

		use({
			"williamboman/mason.nvim",
			"neovim/nvim-lspconfig",
			"williamboman/mason-lspconfig.nvim",
		})

		use("hrsh7th/cmp-nvim-lsp") -- { name = nvim_lsp }
		use("hrsh7th/cmp-buffer") -- { name = 'buffer' },
		use("hrsh7th/cmp-path") -- { name = 'path' }
		use("hrsh7th/cmp-cmdline") -- { name = 'cmdline' }
		use("hrsh7th/nvim-cmp")
		-- vsnip
		use("hrsh7th/cmp-vsnip") -- { name = 'vsnip' }
		use("hrsh7th/vim-vsnip")
		use("rafamadriz/friendly-snippets")
		-- Luasnip
		use("L3MON4D3/LuaSnip")
		use("saadparwaiz1/cmp_luasnip")
		-- lspkind
		use("onsails/lspkind-nvim")

		use("cappyzawa/trim.nvim")

		use("mbbill/undotree")

		use("dstein64/vim-startuptime")

		use("lukas-reineke/indent-blankline.nvim")

		use({ "edluffy/specs.nvim" })

		use({
			"stevearc/aerial.nvim",
			config = function()
				require("aerial").setup()
			end,
		})

		use("lewis6991/impatient.nvim")

		use({
			"lewis6991/gitsigns.nvim",
			-- tag = 'release' -- To use the latest release (do not use this if you run Neovim nightly or dev builds!)
		})
		if packer_bootstrap then
			require("packer").sync()
		end

		use({
			"folke/which-key.nvim",
			config = function()
				require("which-key").setup({
					-- your configuration comes here
					-- or leave it empty to use the default settings
					-- refer to the configuration section below
				})
			end,
		})

		use("moll/vim-bbye")

		use("jose-elias-alvarez/null-ls.nvim")

		use("mhartington/formatter.nvim")

		use({
			"goolord/alpha-nvim",
			requires = { "nvim-tree/nvim-web-devicons" },
			config = function()
				require("alpha").setup(require("alpha.themes.startify").config)
			end,
		})

		-- use 'mg979/vim-visual-multi'
	end,
	config = {
		git = {
			clone_timeout = 600, -- Timeout, in seconds, for git clones
			-- default_url_format = "https://github.com/%s", -- Lua format string used for "aaa/bbb" style plugins
			default_url_format = "git@github.com:%s", -- Lua format string used for "aaa/bbb" style plugins
		},
	},
})

if vim.g.vscode then
	-- VSCode extension
else
	require("plugin-settings.gruvbox")
	require("plugin-settings.nvim-treesitter")
end
require("plugin-settings.nvim-tree")
require("plugin-settings.telescope")
require("plugin-settings.lualine")
require("plugin-settings.tabline")
require("plugin-settings.fterm")

require("which-key").setup({})

require("plugin-settings.mason")

require("indent_blankline").setup({
	-- for example, context is off by default, use this to turn it on
	show_current_context = true,
	show_current_context_start = false,
})

require("specs").setup({
	show_jumps = false,
	min_jump = 30,
	popup = {
		delay_ms = 0, -- delay before popup displays
		inc_ms = 10, -- time increments used for fade/resize effects
		blend = 10, -- starting blend, between 0-100 (fully transparent), see :h winblend
		width = 10,
		winhl = "PMenu",
		fader = require("specs").linear_fader,
		resizer = require("specs").shrink_resizer,
	},
	ignore_filetypes = {},
	ignore_buftypes = {
		nofile = true,
	},
})

require("aerial").setup()
require("gitsigns").setup()

require("trim").setup({
	-- if you want to ignore markdown file.
	-- you can specify filetypes.
	-- disable = {"markdown"},

	-- if you want to remove multiple blank lines
	-- patterns = {
	--   [[%s/\(\n\n\)\n\+/\1/]],   -- replace multiple blank lines with a single line
	-- },
	--
	trim_trailing = true,
	trim_last_line = true,
	trim_first_line = false,
})

require("plugin-settings.hop")
require("plugin-settings.comment")
require("plugin-settings.cmp")

require("plugin-settings.undotree")

require("plugin-settings.null-ls")

require("plugin-settings.luasnip")

require("plugin-settings.formatter")
