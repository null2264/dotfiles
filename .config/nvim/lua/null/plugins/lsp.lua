require("null.util").lazy_file()

return {
	{
		"williamboman/mason.nvim",
		lazy = true,
		config = function(_, opts)
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		lazy = true,
		dependencies = {
			"williamboman/mason.nvim",
		},
		opts = {
			ensure_installed = {
				"pyright",
				-- "ruff",
				-- "ruff_lsp",
			},
			automatic_installation = { exclude = { "rust_analyzer" } },
		},
		config = function(_, opts)
			require("mason-lspconfig").setup(opts)
		end,
	},
	{
		"neovim/nvim-lspconfig",
		lazy = true,
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
		},
		opts = function()
			return {
				diagnostics = {
					underline = true,
					update_in_insert = false,
					virtual_text = {
						spacing = 4,
						source = "if_many",
						prefix = "•",
					},
					severity_sort = true,
					signs = {
						text = {
							[vim.diagnostic.severity.ERROR] = " ",
							[vim.diagnostic.severity.WARN] = " ",
							[vim.diagnostic.severity.HINT] = " ",
							[vim.diagnostic.severity.INFO] = " ",
						},
					},
				},
			}
		end,
		config = function(_, opts)
			vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

			-- Setup lspconfig
			local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
			local capabilities = vim.tbl_deep_extend(
				"force",
				{},
				vim.lsp.protocol.make_client_capabilities(),
				has_cmp and cmp_nvim_lsp.default_capabilities() or {},
				opts.capabilities or {}
			)
			local lsp = require("lspconfig")
			-- FIXME: Re enable once ruff is able to type check
			-- lsp.ruff_lsp.setup({
			-- 	capabilities = capabilities,
			-- })
			lsp.pyright.setup({
				capabilities = capabilities,
			})
			lsp.rust_analyzer.setup({
				capabilities = capabilities,
				settings = {
					["rust-analyzer"] = {
						assist = {
							importGranularity = "module",
							importPrefix = "by_self",
						},
						cargo = {
							loadOutDirsFromCheck = true
						},
						procMacro = {
							enable = true
						},
					}
				},
			})
		end,
	},
	{
		"mfussenegger/nvim-lint",
		event = { "LazyFile" },
		dependencies = {
			"williamboman/mason.nvim",
		},
		opts = function()
			return {
				ignored = { },
			}
		end,
		config = function(_, opts)
			require("lint").linters_by_ft = {
				bash = {
					"shellcheck",
				},
				cmake = {
					"cmakelint",
				},
			}
			vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave", "TextChanged" }, {
				callback = function(E)
					if E.event == "TextChanged" then
						return
					end
					require("lint").try_lint()
					-- FIXME: If filename in opts.ignored:
					-- vim.diagnostic.disable()
				end,
			})
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		event = { "LazyFile" },
		dependencies = {
			"neovim/nvim-lspconfig",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
		},
		config = function(_, opts)
			-- From vimrc, may need clean up
			local cmp = require("cmp")

			local has_words_before = function()
				local line, col = unpack(vim.api.nvim_win_get_cursor(0))
				return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
			end

			cmp.setup({
				auto_brackets = { "python" },
				snippet = {
					-- REQUIRED - you must specify a snippet engine
					expand = function(args)
					-- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
					-- require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
					-- require("snippy").expand_snippet(args.body) -- For `snippy` users.
					-- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
					end,
				},
				window = {
					-- completion = cmp.config.window.bordered(),
					-- documentation = cmp.config.window.bordered(),
				},
				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping(function(fallback)
						if cmp.visible() and not cmp.confirm() then
							cmp.abort()
						else
							fallback()
						end
					end, {"i", "s"}),
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
							-- elseif has_words_before() then
							--   cmp.complete()
						else
							fallback() -- The fallback function sends a already mapped key. In this case, it"s probably `<Tab>`.
						end
					end, { "i", "s" }),
					["<S-Tab>"] = cmp.mapping(function()
						if cmp.visible() then
							cmp.select_prev_item()
						end
					end, { "i", "s" }),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					-- { name = "vsnip" }, -- For vsnip users.
					-- { name = "luasnip" }, -- For luasnip users.
					-- { name = "ultisnips" }, -- For ultisnips users.
					-- { name = "snippy" }, -- For snippy users.
					}, {
					{ name = "buffer" },
				})
			})

			-- Set configuration for specific filetype.
			cmp.setup.filetype("gitcommit", {
				sources = cmp.config.sources({
					{ name = "cmp_git" }, -- You can specify the `cmp_git` source if you were installed it.
					}, {
					{ name = "buffer" },
				})
			})

			-- Use buffer source for `/` (if you enabled `native_menu`, this won"t work anymore).
			cmp.setup.cmdline("/", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = "buffer" }
				}
			})

			-- Use cmdline & path source for ":" (if you enabled `native_menu`, this won"t work anymore).
			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = "path" }
				}, {
					{ name = "cmdline" }
				})
			})
		end,
	},
}
