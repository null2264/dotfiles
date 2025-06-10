local map = require("null.util").map

require("null.util").lazy_file()

return {
    {
        "mason-org/mason.nvim",
        lazy = true,
        config = function(_, _opts)
            require("mason").setup()
        end,
    },
    {
        "mason-org/mason-lspconfig.nvim",
        lazy = true,
        dependencies = {
            "mason-org/mason.nvim",
        },
        opts = {
            ensure_installed = {
                "ast_grep",

                -- >> Kotlin
                -- "kotlin_language_server",
                -- << Kotlin

                -- >> Python
                "basedpyright",
                -- "ruff",
                -- "ruff_lsp",
                -- << Python

                -- >> Jinja
                "jinja_lsp",
                -- << Jinja

                -- >> Lua
                "emmylua_ls",
                "luau_lsp",
                -- << Lua
            },
            automatic_installation = { exclude = { "rust_analyzer" } },
        },
        config = function(_, opts)
            require("mason-lspconfig").setup(opts)
        end,
    },
    {
        "lopi-py/luau-lsp.nvim",
        lazy = true,
        opts = {
        },
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
    },
    {
        "neovim/nvim-lspconfig",
        lazy = true,
        dependencies = {
            "lopi-py/luau-lsp.nvim",
            "mason-org/mason-lspconfig.nvim",
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
                capabilities = {
                    workspace = {
                        didChangeWatchedFiles = {
                            dynamicRegistration = true,
                        },
                    },
                },
            }
        end,
        config = function(_, opts)
            vim.diagnostic.config(vim.deepcopy(opts.diagnostics))
            local on_attach = function(client, bufnr)
                map("n", "<Space><CR>", require("null.lsp-diagnostics").line_diagnostics, { buffer = bufnr })
            end

            -- Setup lspconfig
            local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
            local capabilities = vim.tbl_deep_extend(
                "force",
                {},
                vim.lsp.protocol.make_client_capabilities(),
                has_cmp and cmp_nvim_lsp.default_capabilities() or {},
                opts.capabilities or {}
            )
            -- FIXME: Re enable once ruff is able to type check
            -- vim.lsp.config["ruff_lsp"] = {
            --     capabilities = capabilities,
            -- }
            vim.lsp.config["basedpyright"] = {
                capabilities = capabilities,
            }
            vim.lsp.enable("basedpyright")
            -- FIXME: Causing memleak, probably not compatible with Oil / neotree
            -- vim.lsp.config["kotlin_language_server"] = {
            --     capabilities = capabilities,
            -- }
            vim.lsp.config["emmylua_ls"] = {
                capabilities = capabilities,
                root_markers = {
                    ".luarc.json",
                    "luarc.json",
                    ".git",
                    "lazy-lock.json",
                    ".emmyrc.json",
                },
                settings = {
                    workspace = {
                        library = vim.api.nvim_get_runtime_file("lua/*.lua", true),
                    },
                    Lua = {
                        runtime = {
                            version = 'LuaJIT',
                        },
                    },
                },
            }
            -- vim.lsp.enable("emmylua_ls")
            require("luau-lsp").setup {
                platform = {
                    type = "roblox",
                },
                types = {
                    roblox_security_level = "PluginSecurity",
                },
                sourcemap = {
                    enabled = true,
                    autogenerate = true, -- automatic generation when the server is attached
                    rojo_project_file = "default.project.json",
                    sourcemap_file = "sourcemap.json",
                },
                server = {
                    capabilities = capabilities,
                    on_attach = on_attach,
                    settings = {
                        -- https://github.com/folke/neoconf.nvim/blob/main/schemas/luau_lsp.json
                        ["luau-lsp"] = {
                            completion = {
                                imports = {
                                    enabled = true, -- enable auto imports
                                },
                            },
                        },
                    },
                },
            }
            -- vim.lsp.enable("luau_lsp")
            vim.lsp.config["rust_analyzer"] = {
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
            }
            vim.lsp.enable("rust_analyzer")
            -- REF: https://github.com/Kotlin/kotlin-lsp/blob/main/scripts/neovim.md
            vim.lsp.config["kotlin-lsp"] = {
                capabilities = capabilities,
                cmd = vim.lsp.rpc.connect('127.0.0.1', tonumber(9999)),
                single_file_support = false,
                filetypes = { "kotlin" },
                root_markers = { "build.gradle", "build.gradle.kts", "pom.xml" },
            }
            vim.lsp.enable("kotlin-lsp")
        end,
    },
    {
        "mfussenegger/nvim-lint",
        event = { "LazyFile" },
        dependencies = {
            "mason-org/mason.nvim",
        },
        opts = function()
            return {
                ignored = {},
            }
        end,
        config = function(_, _opts)
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
        config = function(_, _opts)
            -- From vimrc, may need clean up
            local cmp = require("cmp")

            -- local has_words_before = function()
            --     local line, col = unpack(vim.api.nvim_win_get_cursor(0))
            --     return col ~= 0 and vim.api.nvim_buf_get_lines(0, (line or 0) - 1, line, true)[1]:sub(col, col):match("%s") == nil
            -- end

            cmp.setup({
                auto_brackets = { "python" },
                snippet = {
                    -- REQUIRED - you must specify a snippet engine
                    expand = function(_args)
                        -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
                        -- require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
                        -- require("snippy").expand_snippet(args.body) -- For `snippy` users.
                        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
                    end,
                },
                window = {
                    completion = cmp.config.window.bordered(),
                    -- documentation = cmp.config.window.bordered(),
                },
                -- NOTE: fallback function (or the first parameter inside `cmp.mapping(function(fallback) ...)`) sends a already mapped key.
                mapping = cmp.mapping.preset.insert({
                    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<A-Space>"] = cmp.mapping.complete(), -- Alt instead of Ctrl because Ctrl+Space is used by IME to switch between input method
                    ["<C-e>"] = cmp.mapping.abort(),
                    ["<CR>"] = cmp.mapping(function(fallback)
                        if cmp.visible() and not cmp.confirm() then
                            cmp.abort()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                            -- elseif has_words_before() then
                            --   cmp.complete()
                        else
                            fallback()
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
