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
		"nvim-neo-tree/neo-tree.nvim", -- I'll be using oil.nvim, but for better visual I'll keep this
		keys = {
			{ "<C-n>", "<cmd>Neotree toggle<cr>", desc = "NeoTree" },
		},
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
		config = function ()
			require("neo-tree").setup({
				close_if_last_window = true,
			})
		end,
	},
	{
  		"stevearc/oil.nvim",
		keys = {
			{ "-", "<cmd>Oil<cr>", desc = "Oil" },
		},
  		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function ()
			require("oil").setup()
		end
	},
	"tpope/vim-commentary", -- shortcut to comment a line
	{
		"dstein64/vim-startuptime",
		cmd = "StartupTime", -- Note to self: lazy load on command
		init = function ()
			-- Note to self: init is called during startup. Configuration for vim plugins typically should be set in an init function
		end,
	},

	-- Syntax Highlighting stuff
	{
		"nvim-treesitter/nvim-treesitter",
		opts = {
			ensure_installed = {
				"gsp",
			},

			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},
		},
		config = function (_, opts)
			local config = require("nvim-treesitter.parsers").get_parser_configs()
			config.gsp = {
				install_info = {
					url = "https://git.sr.ht/~mango/tree-sitter-gsp",
					files = {"src/parser.c"},
				},
				filetype = "gsp",
			}
			require("nvim-treesitter.configs").setup(opts)
		end
	},
	{
		url = "https://git.sr.ht/~mango/tree-sitter-gsp",
		fp = "gsp",
	},
}
