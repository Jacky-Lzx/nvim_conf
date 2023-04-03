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

require("packer").startup({
	function(use)
		-- Packer can manage itself
		use("wbthomason/packer.nvim")

		use("lewis6991/impatient.nvim")

		-- use 'easymotion/vim-easymotion'
		use({
			"phaazon/hop.nvim",
			branch = "v2", -- optional but strongly recommended
		})
		use({
			"ggandor/leap.nvim",
			requires = { "tpope/vim-repeat" },
		})

		use({ "ellisonleao/gruvbox.nvim" })

		use({ "numToStr/Comment.nvim" })

		use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
		use("nvim-telescope/telescope-ui-select.nvim")
		use({
			"nvim-telescope/telescope.nvim",
			tag = "0.1.1",
			requires = { { "nvim-lua/plenary.nvim" } },
			extensions = {
				fzf = {
					fuzzy = true, -- false will only do exact matching
					override_generic_sorter = true, -- override the generic sorter
					override_file_sorter = true, -- override the file sorter
					case_mode = "smart_case", -- or "ignore_case" or "respect_case"
					-- the default case_mode is "smart_case"
				},
			},
		})

		use({
			"nvim-tree/nvim-tree.lua",
			requires = {
				"nvim-tree/nvim-web-devicons", -- optional, for file icons
			},
			tag = "nightly", -- optional, updated every week. (see issue #1193)
		})

		use({ "numToStr/FTerm.nvim" })

		use({
			"cappyzawa/trim.nvim",
		})

		use({ "norcalli/nvim-colorizer.lua" })

		-- The command of Buffer delete
		use("moll/vim-bbye")
		use({
			"nvim-lualine/lualine.nvim",
			requires = { "kyazdani42/nvim-web-devicons", opt = true },
		})
		use({
			"kdheepak/tabline.nvim",
			requires = { { "hoob3rt/lualine.nvim", opt = true }, { "kyazdani42/nvim-web-devicons", opt = true } },
		})

		use({ "mbbill/undotree" })

		use("dstein64/vim-startuptime")

		use({
			"lukas-reineke/indent-blankline.nvim",
		})

		use({ "folke/which-key.nvim" })

		use({
			"goolord/alpha-nvim",
			requires = { "nvim-tree/nvim-web-devicons" },
		})

		use("lewis6991/gitsigns.nvim")
		-- use("kevinhwang91/nvim-hlslens") -- Conflicted with vscode_nvim, don't know way
		use("petertriho/nvim-scrollbar")

		-- use({ "edluffy/specs.nvim", config = require("plugin-settings.specs") })

		use({ "mhartington/formatter.nvim" })

		use("mg979/vim-visual-multi")

		use({
			"jose-elias-alvarez/null-ls.nvim",
			requires = { "nvim-lua/plenary.nvim" },
		})

		use({
			"nvim-treesitter/nvim-treesitter",
			"nvim-treesitter/nvim-treesitter-context",
			run = function()
				local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
				ts_update()
			end,
		})

		use({
			"williamboman/mason.nvim",
			"neovim/nvim-lspconfig",
			"williamboman/mason-lspconfig.nvim",
		})

		use({ "windwp/nvim-autopairs" })
		use("hrsh7th/cmp-nvim-lsp") -- { name = nvim_lsp }
		use("hrsh7th/cmp-buffer") -- { name = 'buffer' },
		-- use("hrsh7th/cmp-path") -- { name = 'path' }
		use("FelipeLema/cmp-async-path") -- { name = 'async_path' }
		use("hrsh7th/cmp-cmdline") -- { name = 'cmdline' }
		use("hrsh7th/nvim-cmp")
		-- vsnip
		-- use("hrsh7th/cmp-vsnip") -- { name = 'vsnip' }
		-- use("hrsh7th/vim-vsnip")
		-- Luasnip
		use({
			"L3MON4D3/LuaSnip",
			-- follow latest release.
			-- tag = "v<CurrentMajor>.*",
			tag = "v1.*",
			-- install jsregexp (optional!:).
			run = "make install_jsregexp",
		})
		use("saadparwaiz1/cmp_luasnip")
		use("rafamadriz/friendly-snippets")
		-- lspkind
		use("onsails/lspkind-nvim")

		use({ "lewis6991/hover.nvim" })

		-- use({ "stevearc/aerial.nvim", config = require("aerial").setup() })
		use({ "lervag/vimtex" })

		use({
			"kylechui/nvim-surround",
			tag = "*", -- Use for stability; omit to use `main` branch for the latest features
		})

		use({
			"folke/noice.nvim",
			requires = {
				-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
				"MunifTanjim/nui.nvim",
				-- OPTIONAL:
				--   `nvim-notify` is only needed, if you want to use the notification view.
				--   If not available, we use `mini` as the fallback
				"rcarriga/nvim-notify",
			},
		})

		use({
			"ibhagwan/smartyank.nvim",
		})

		if packer_bootstrap then
			require("packer").sync()
		end
	end,
	config = {
		display = {
			open_fn = require("packer.util").float,
		},
		git = {
			clone_timeout = 600, -- Timeout, in seconds, for git clones
			default_url_format = "git@github.com:%s", -- Lua format string used for "aaa/bbb" style plugins
		},
	},
})

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
		highlight = "StatusLineNC",
		-- highlight = "CursorLine",
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
require("plugin-settings/gruvbox")
require("plugin-settings/comment")
require("plugin-settings.telescope")
require("plugin-settings/nvim-tree")
require("plugin-settings.fterm")

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
require("colorizer").setup()
require("plugin-settings.lualine")
require("plugin-settings.tabline")
require("plugin-settings/undotree")

require("indent_blankline").setup({
	space_char_blankline = " ",
	show_current_context = true,
	show_current_context_start = true,
})
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
