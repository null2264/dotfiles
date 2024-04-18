return {
	{
		-- FIXME: Use my own colourscheme
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		config = function ()
			-- load the colorscheme here
			vim.cmd([[colorscheme tokyonight]])
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function ()
			require("lualine").setup {
				options = {
					theme = "tokyonight" -- FIXME: Use my own colourscheme
				}
			}
		end,
	},
	{
		"tpope/vim-commentary", -- shortcut to comment a line
		keys = { "gc" },
	},
	{
		"dstein64/vim-startuptime",
		cmd = "StartupTime", -- Note to self: lazy load on command
		init = function ()
			-- Note to self: init is called during startup. Configuration for vim plugins typically should be set in an init function
		end,
	},
}
