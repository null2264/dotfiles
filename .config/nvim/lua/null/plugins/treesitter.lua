return {
	{
		"nvim-treesitter/nvim-treesitter",
		opts = {
			ensure_installed = {
				"c",
				"elixir",
				"fluent",
				"go",
				"gsp",
				"hyprlang",
				"json5",
				"julia",
				-- "latex",
				"python",
				"rust",
				"sxhkdrc",
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
			vim.filetype.add({
				extension = { rasi = "rasi" },
				pattern = {
					[".*/hypr/.*%.conf"] = "hyprlang",
				},
			})
			require("nvim-treesitter.configs").setup(opts)
		end
	},
	{
		url = "https://git.sr.ht/~mango/tree-sitter-gsp",
		fp = "gsp",
	},
}
