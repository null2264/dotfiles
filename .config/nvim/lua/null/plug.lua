local util = require("null.util")

util.getch_lazy_nvim().setup({
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
