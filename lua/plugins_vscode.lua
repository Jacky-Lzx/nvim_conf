require("packer").startup(function(use)
	-- Packer can manage itself
	use("wbthomason/packer.nvim")

	use({
		"phaazon/hop.nvim",
		branch = "v2", -- optional but strongly recommended
		config = function()
			-- you can configure Hop the way you like here; see :h hop-config
			require("hop").setup({ keys = "etovxqpdygfblzhckisuran" })
		end,
	})
	use({
		"ggandor/leap.nvim",
		requires = { "tpope/vim-repeat" },
	})

	use("numToStr/Comment.nvim")

	use("cappyzawa/trim.nvim")
end)

require("trim").setup({
	-- if you want to ignore markdown file.
	-- you can specify filetypes.
	-- disable = {"markdown"},

	-- if you want to remove multiple blank lines
	-- patterns = {
	--   [[%s/\(\n\n\)\n\+/\1/]],   -- replace multiple blank lines with a single line
	-- },

	trim_trailing = true,
	trim_last_line = true,
	trim_first_line = false,
})

require("plugin-settings.hop")
require("plugin-settings.comment")
require("plugin-settings.leap")
