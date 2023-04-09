local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system {
		'git',
		'clone',
		'--filter=blob:none',
		'https://github.com/folke/lazy.nvim.git',
		'--branch=stable', -- latest stable release
		lazypath,
	}
end
vim.opt.rtp:prepend(lazypath)

plugins = {}
opts = {
	git = {
		clone_timeout = 600,
		url_format = "git@github.com:%s.git",
	},
}

-- require("lazy").setup(plugins, opts)
require("lazy").setup({
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
		"kylechui/nvim-surround",
		-- version = "*", -- Use for stability; omit to use `main` branch for the latest features
	},
	{ "numToStr/Comment.nvim" },
	{
		"cappyzawa/trim.nvim",
	},
	{
		"ibhagwan/smartyank.nvim",
	},
}, opts)

require("plugin-settings/hop")
require("plugin-settings/leap")
require("plugin-settings/comment")

require("nvim-surround").setup({
	-- Configuration here, or leave empty to use defaults
})

require("smartyank").setup({
	highlight = {
		enabled = true,      -- highlight yanked text
		higroup = "IncSearch", -- highlight group of yanked text
		timeout = 400,       -- timeout for clearing the highlight
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
		ssh_only = true,     -- false to OSC52 yank also in local sessions
		silent = false,      -- true to disable the "n chars copied" echo
		echo_hl = "Directory", -- highlight group of the OSC52 echo message
	},
})

require("trim").setup()
