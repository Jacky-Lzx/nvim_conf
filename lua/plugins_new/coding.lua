return {
	"mg979/vim-visual-multi",
	{
		"cappyzawa/trim.nvim",
		config = function()
			require("trim").setup()
		end,
	},
	{
		"kylechui/nvim-surround",
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end,
	},
	"folke/which-key.nvim",
	{
		"mbbill/undotree",
		config = function()
			vim.keymap.set("n", "<leader>ut", "<CMD>UndotreeToggle<CR>")

			vim.cmd([[
      if has("persistent_undo")
         let target_path = expand('~/.undodir')

          " create the directory and any parent directories
          " if the location does not exist.
          if !isdirectory(target_path)
              call mkdir(target_path, "p", 0700)
          endif

          let &undodir=target_path
          set undofile
      endif
      ]])
		end,
	},
	{
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()

			vim.keymap.set("n", "<leader>/", function()
				require("Comment.api").toggle.linewise.current()
			end)
			vim.keymap.set(
				"v",
				"<leader>/",
				'<ESC><CMD>lua require("Comment.api").toggle.linewise(vim.fn.visualmode())<CR>'
			)
		end,
	},

	{
		"mhartington/formatter.nvim",
		config = function()
			-- Utilities for creating configurations
			local util = require("formatter.util")

			-- Provides the Format, FormatWrite, FormatLock, and FormatWriteLock commands
			require("formatter").setup({
				-- Enable or disable logging
				logging = true,
				-- Set the log level
				log_level = vim.log.levels.WARN,
				-- All formatter configurations are opt-in
				filetype = {
					-- Formatter configurations for filetype "lua" go here
					-- and will be executed in order
					cpp = {
						-- prettier
						function()
							return {
								exe = "clang-format",
								args = {},
								stdin = true,
							}
						end,
					},

					python = {
						function()
							return {
								exe = "yapf",
								args = {},
								stdin = true,
							}
						end,
					},

					lua = {
						-- "formatter.filetypes.lua" defines default configurations for the
						-- "lua" filetype
						require("formatter.filetypes.lua").stylua,

						-- You can also define your own configuration
						function()
							-- Supports conditional formatting
							if util.get_current_buffer_file_name() == "special.lua" then
								return nil
							end

							-- Full specification of configurations is down below and in Vim help
							-- files
							return {
								exe = "stylua",
								args = {
									"--search-parent-directories",
									"--stdin-filepath",
									util.escape_path(util.get_current_buffer_file_path()),
									"--",
									"-",
								},
								stdin = true,
							}
						end,
					},

					-- Use the special "*" filetype for defining formatter configurations on
					-- any filetype
					["*"] = {
						-- "formatter.filetypes.any" defines default configurations for any
						-- filetype
						require("formatter.filetypes.any").remove_trailing_whitespace,
					},
				},
			})

			vim.keymap.set("n", "<leader>gf", "<CMD>Format<CR>", {})
		end,
	},
}
