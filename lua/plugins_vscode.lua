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

	use({
		"ibhagwan/smartyank.nvim",
		config = {
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
			}),
		},
	})
end)
