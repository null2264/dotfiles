return {
	{
		"nvim-treesitter/nvim-treesitter",
		opts = {
			ensure_installed = {
				"c",
				"fluent",
				"python",
				"go",
				"gsp",
				"json5",
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
			config.fluent = {
				install_info = {
					url = "https://github.com/projectfluent/tree-sitter-fluent", -- local path or git repo
					files = {"src/parser.c"}, -- note that some parsers also require src/scanner.c or src/scanner.cc
				},
				filetype = "fluent", -- if filetype does not match the parser name
			}
			require("nvim-treesitter.configs").setup(opts)
		end
	},
	{
		url = "https://git.sr.ht/~mango/tree-sitter-gsp",
		fp = "gsp",
	},
}
