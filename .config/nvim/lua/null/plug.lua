-- << Getting lazy.nvim for the first time
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
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
-- >>

require("lazy").setup({
	{
  		"stevearc/oil.nvim",
  		opts = {},
  		dependencies = { "nvim-tree/nvim-web-devicons" },
	},
	"tpope/vim-commentary", -- shortcut to comment a line
	{
		"dstein64/vim-startuptime",
		cmd = "StartupTime", -- Note to self: lazy load on command
		init = function()
			-- Note to self: init is called during startup. Configuration for vim plugins typically should be set in an init function
		end,
	},
})
