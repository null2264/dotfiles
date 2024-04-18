return {
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
