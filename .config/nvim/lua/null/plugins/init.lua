return {
	{ "wakatime/vim-wakatime", lazy = false },
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
			local _progress = require("lualine.components.progress")
			local progress = function ()
				return "☰ " .. _progress()
			end
			local _location = require("lualine.components.location")
			local location = function ()
				return "" .. _location()
			end
			require("lualine").setup {
				options = {
					theme = "tokyonight", -- FIXME: Use my own colourscheme
					-- theme = "zi",
					section_separators = "",
					component_separators = "",
				},
				extensions = {"neo-tree", "oil", "lazy"},
				sections = {
					lualine_a = {"mode"},
					lualine_b = {"branch", "diff", "diagnostics"},
					lualine_c = {"filename"},
					lualine_x = {location},
					lualine_y = {progress},
					lualine_z = {"encoding", "fileformat", "filetype"},
				},
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
