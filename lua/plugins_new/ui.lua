return {
	{
		"norcalli/nvim-colorizer.lua",
		config = function()
			-- require("colorizer").setup()
		end,
	},
	{
		"goolord/alpha-nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},

	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup()
		end,
	},
	{
		"kevinhwang91/nvim-hlslens",
		config = function()
			require("hlslens").setup({
				-- auto_enable = false,
				-- calm_down = true,
				nearest_only = true,
				-- nearest_float_when = "always",
				-- override_lens = function() end,
			})
		end,
	}, -- Conflicted with vscode_nvim, don't know way
	{
		"petertriho/nvim-scrollbar",
		config = function()
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
		end,
	},

	-- use({ "edluffy/specs.nvim", config = require("plugin-settings.specs") })

	"folke/which-key.nvim",
	{
		"goolord/alpha-nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("alpha").setup(require("alpha.themes.startify").config)
		end,
	},
	{
		"folke/which-key.nvim",
		config = function()
			require("which-key").setup()
		end,
	},
	{
		"ellisonleao/gruvbox.nvim",
		lazy = false,
		config = function()
			opts = {
				undercurl = true,
				underline = true,
				bold = true,
				italic = {
					strings = true,
					comments = false,
					operators = false,
					folds = true,
				},
				strikethrough = true,
				invert_selection = false,
				invert_signs = false,
				invert_tabline = false,
				invert_intend_guides = false,
				inverse = true, -- invert background for search, diffs, statuslines and errors
				contrast = "", -- can be "hard", "soft" or empty string
				palette_overrides = {},
				overrides = {},
				dim_inactive = false,
				-- transparent_mode = false,
				transparent_mode = true,
			}
			-- require("gruvbox").setup({italic = {comments = false}})
			require("gruvbox").setup(opts)

			vim.o.background = "dark" -- or "light" for light mode
			-- vim.cmd([[colorscheme gruvbox]])
			vim.cmd([[colorscheme gruvbox]])
			vim.cmd([[colorscheme gruvbox]])
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons", lazy = true },
		opts = {
			options = {
				icons_enabled = true,
				theme = "gruvbox",
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
				disabled_filetypes = {
					statusline = {},
					winbar = {},
				},
				ignore_focus = {},
				always_divide_middle = true,
				globalstatus = false,
				refresh = {
					statusline = 1000,
					tabline = 1000,
					winbar = 1000,
				},
			},
		},
	},
	{
		"kdheepak/tabline.nvim",
		dependencies = { { "nvim-lualine/lualine.nvim", lazy = true }, { "nvim-tree/nvim-web-devicons", lazy = true } },
		config = function()
			opts = {
				-- Defaults configuration options
				enable = true,
				options = {
					-- If lualine is installed tabline will use separators configured in lualine by default.
					-- These options can be used to override those settings.
					section_separators = { "", "" },
					component_separators = { "", "" },
					max_bufferline_percent = 66, -- set to nil by default, and it uses vim.o.columns * 2/3
					show_tabs_always = false, -- this shows tabs only when there are more than one tab or if the first tab is named
					show_devicons = true, -- this shows devicons in buffer section
					show_bufnr = false, -- this appends [bufnr] to buffer section,
					show_filename_only = false, -- shows base filename only instead of relative path in filename
					modified_icon = "+ ", -- change the default modified icon
					modified_italic = false, -- set to true by default; this determines whether the filename turns italic if modified
					show_tabs_only = false, -- this shows only tabs instead of tabs + buffers
				},
			}
			require("tabline").setup(opts)
			vim.cmd([[
        set guioptions-=e " Use showtabline in gui vim
        set sessionoptions+=tabpages,globals " store tabpages and globals in session
      ]])

			-- vim.keymap.set('n', '<TAB>', '<CMD>TablineBufferNext<CR>')
			-- vim.keymap.set('n', '<S-TAB>', '<CMD>TablineBufferPrevious<CR>')

			vim.keymap.set("n", "<leader>l", "<CMD>TablineBufferNext<CR>")
			vim.keymap.set("n", "<leader>h", "<CMD>TablineBufferPrevious<CR>")

			-- vim.keymap.set('n', '<C-L>', '<CMD>TablineBufferNext<CR>')
			-- vim.keymap.set('n', '<C-H>', '<CMD>TablineBufferPrevious<CR>')

			vim.keymap.set("n", "<leader>x", "<CMD>Bdelete<CR>")
		end,
	},

	{
		"nvim-tree/nvim-tree.lua",
		dependencies = {
			"nvim-tree/nvim-web-devicons", -- optional, for file icons
		},
		config = function()
			require("nvim-tree").setup()

			-- vim.keymap.set('n', '<C-n>', '<CMD> NvimTreeToggle <CR>')
			-- vim.keymap.set('n', '<leader>e', '<CMD> NvimTreeFocus <CR>')
			vim.keymap.set("n", "<leader>e", "<CMD> NvimTreeToggle <CR>")
		end,
	},
	{
		"numToStr/FTerm.nvim",
		config = function()
			require("FTerm").setup({
				border = "double",
				dimensions = {
					height = 0.9,
					width = 0.9,
				},
			})

			-- Example keybindings
			-- vim.keymap.set('n', '<C-i>', '<CMD>lua require("FTerm").toggle()<CR>')
			-- vim.keymap.set('t', '<C-i>', '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>')

			vim.api.nvim_create_user_command("FTermToggle", require("FTerm").toggle, { bang = true })

			vim.keymap.set("n", "<A-i>", '<CMD>lua require("FTerm").toggle()<CR>')
			vim.keymap.set("t", "<A-i>", '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>')

			local fterm = require("FTerm")
			local lg = fterm:new({
				ft = "lazygit", -- You can also override the default filetype, if you want
				cmd = "lazygit --use-config-file=$HOME/.config/lazygit/config.yml",
				dimensions = {
					height = 0.9,
					width = 0.9,
				},
			})

			-- Use this to toggle lazygit in a floating terminal
			vim.keymap.set("n", "<C-g>", function()
				lg:toggle()
			end)
		end,
	},
	{
		"cappyzawa/trim.nvim",
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
		config = function()
			-- This is your opts table
			require("telescope").setup({
				-- pickers = {
				-- 	find_files = {
				-- 		theme = "dropdown",
				-- 	},
				-- },
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_cursor(),
					},
				},
			})
			-- To get ui-select loaded and working with telescope, you need to call
			-- load_extension, somewhere after setup function:
			require("telescope").load_extension("ui-select")
			require("telescope").load_extension("fzf")

			local builtin = require("telescope.builtin")

			vim.keymap.set("n", "<leader>a", vim.lsp.buf.code_action, {})
			vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
			vim.keymap.set("n", "<leader>fd", builtin.lsp_definitions, {})
			vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
			vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
			vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
			vim.keymap.set("n", "<leader>fk", builtin.keymaps, {})
			vim.keymap.set("n", "<leader>fq", builtin.quickfix, {})
			vim.keymap.set("n", "<leader>fr", builtin.registers, {})
		end,
	},

	{
		"folke/noice.nvim",
		config = function()
			-- require("noice").setup({
			--   -- add any options here
			-- })
			require("notify").setup({
				background_colour = "#282828",
			})

			require("noice").setup({
				-- add any options here
				lsp = {
					progress = {
						enabled = true,
						-- Lsp Progress is formatted using the builtins for lsp_progress. See config.format.builtin
						-- See the section on formatting for more details on how to customize.
						--- @type NoiceFormat|string
						format = "lsp_progress",
						--- @type NoiceFormat|string
						format_done = "lsp_progress_done",
						throttle = 1000 / 30, -- frequency to update lsp progress message
						view = "mini",
					},
					-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
					override = {
						["vim.lsp.util.convert_input_to_markdown_lines"] = true,
						["vim.lsp.util.stylize_markdown"] = true,
						["cmp.entry.get_documentation"] = true,
					},
					message = {
						-- Messages shown by lsp servers
						enabled = true,
						view = "notify",
						opts = {},
					},
				},
				-- you can enable a preset for easier configuration
				presets = {
					bottom_search = true, -- use a classic bottom cmdline for search
					command_palette = true, -- position the cmdline and popupmenu together
					long_message_to_split = true, -- long messages will be sent to a split
					inc_rename = false, -- enables an input dialog for inc-rename.nvim
					lsp_doc_border = false, -- add a border to hover docs and signature help
				},
			})

			require("telescope").load_extension("noice")

			vim.keymap.set("n", "<leader>nl", function()
				require("noice").cmd("last")
			end)

			vim.keymap.set("n", "<leader>nh", function()
				require("noice").cmd("history")
			end)
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
}
