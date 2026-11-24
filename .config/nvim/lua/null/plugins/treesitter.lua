require("null.util").lazy_file()

return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",  -- NOTE: This requires tree-sitter-cli to be installed
        build = ":TSUpdate",
        event = { "LazyFile", "VeryLazy" },
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
                "latex",
                -- HTML template langs
                "javascript",
                "typescript",
                "html",
                "htmljinja",
                "jinja",
                "jinja_inline",
            },

            sync_install = false,  -- FIXME: Not used by nvim-treesitter main branch
            auto_install = true,

            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,  -- FIXME: Not used by nvim-treesitter main branch
            },
        },
        config = function(_, opts)
            local treesitter = require("nvim-treesitter")

            vim.api.nvim_create_autocmd("User", { pattern = "TSUpdate",
            callback = function()
                local parsers = require("nvim-treesitter.parsers")
                parsers.gsp = {
                    install_info = {
                        url = "https://git.sr.ht/~mango/tree-sitter-gsp",
                        revision = "ef29ac524f001a2e6a104bcb45e0bb8cc6f8c2b8",
                    },
                }
                parsers.fluent = {
                    install_info = {
                        url = "https://github.com/projectfluent/tree-sitter-fluent",
                        revision = "9f0d60a542f210ce9c03ae8872f93e73b5a31740",
                    },
                }
                parsers.htmljinja = {
                    install_info = {
                        url = "https://github.com/null2264/tree-sitter-htmldjango",
                        revision = "25e4212f593a59504682984720b9c0a8171f4585",
                    },
                }
            end})

            vim.filetype.add({
                extension = { rasi = "rasi" },
                pattern = {
                    [".*/hypr/.*%.conf"] = "hyprlang",
                },
            })
            vim.filetype.add({
                extension = {
                    mdx = "mdx"
                }
            })
            vim.treesitter.language.register("markdown", "mdx")

            local ensure_installed = opts.ensure_installed

            if #ensure_installed > 0 then
                local installed = treesitter.get_installed()
                local missing = vim.tbl_filter(function(lang)
                    return not vim.tbl_contains(installed, lang)
                end, ensure_installed)

                if #missing > 0 then
                    treesitter.install(missing)
                end
            end

            treesitter.setup(opts)

            vim.api.nvim_create_autocmd('FileType', {
                group = vim.api.nvim_create_augroup("Treesitter", { clear = true }),
                callback = function(args)
                    -- Re-introduce highlight enable and auto_install to nvim-treesitter
                    local installed = treesitter.get_installed()
                    local available = treesitter.get_available()
                    local isInstalled = vim.tbl_contains(installed, args.match)
                    local isAvailable = vim.tbl_contains(available, args.match)
                    if isInstalled or isAvailable then
                        if isAvailable and not isInstalled and opts.auto_install then
                            treesitter.install(args.match):await(function(error)
                                if not error and opts.highlight.enable then
                                    vim.treesitter.start()
                                else
                                    print("Parser for " .. args.match .. " is not installed")
                                end
                            end)
                        elseif isInstalled and opts.highlight.enable then
                            vim.treesitter.start()
                        end
                    end
                end,
            })
        end
    },
    {
        url = "https://git.sr.ht/~mango/tree-sitter-gsp",
        fp = "gsp",
    },
    {
        url = "https://github.com/null2264/tree-sitter-htmldjango",
        fp = "htmljinja",
    },
}
