require("packer").startup(function(use)
	-- Packer can manage itself
	use("wbthomason/packer.nvim")

	use({
		"phaazon/hop.nvim",
		branch = "v2", -- optional but strongly recommended
		config = require("plugin-settings/hop"),
	})
	use({
		"ggandor/leap.nvim",
		requires = { "tpope/vim-repeat" },
		config = require("plugin-settings.leap"),
	})

	use({ "numToStr/Comment.nvim", config = require("plugin-settings.comment") })

	use({
		"cappyzawa/trim.nvim",
		config = require("trim").setup({
			trim_trailing = true,
			trim_last_line = true,
			trim_first_line = false,
		}),
	})

	use({
		"kylechui/nvim-surround",
		tag = "*", -- Use for stability; omit to use `main` branch for the latest features
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end,
	})
end)
