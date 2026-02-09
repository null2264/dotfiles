return {
    { "wakatime/vim-wakatime", lazy = false },
    {
        -- FIXME: Use my own colourscheme
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require("tokyonight").setup({
                style = "moon",
                transparent = true,
                styles = {
                    sidebars = "transparent"
                },
                on_highlights = function(hl, c)
                    hl.CursorLineNr = { fg = c.yellow, bold = true }
                end,
            })
            vim.cmd([[colorscheme tokyonight-moon]])
        end,
    },
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            local _progress = require("lualine.components.progress")
            local progress = function()
                return "☰ " .. _progress()
            end
            local _location = require("lualine.components.location")
            local location = function()
                return "" .. _location()
            end
            require("lualine").setup {
                options = {
                    theme = "tokyonight", -- FIXME: Use my own colourscheme
                    -- theme = "zi",
                    section_separators = "",
                    component_separators = "",
                },
                extensions = { "neo-tree", "oil", "lazy" },
                sections = {
                    lualine_a = { "mode" },
                    lualine_b = { "branch", "diff", "diagnostics" },
                    lualine_c = { "filename" },
                    lualine_x = { location },
                    lualine_y = { progress },
                    lualine_z = { "encoding", "fileformat", "filetype" },
                },
            }
        end,
    },
    {
        "tpope/vim-commentary", -- shortcut to comment a line
        keys = {
            { "gc", mode = { "n", "v", "i" } },
        },
        init = function()
            vim.api.nvim_create_autocmd("FileType", {
                pattern = { "nix", "hyprlang" },
                callback = function()
                    vim.opt_local.commentstring = "#%s"
                end,
                group = generalSettingsGroup,
            })
        end,
    },
    {
        "dstein64/vim-startuptime",
        cmd = "StartupTime", -- Note to self: lazy load on command
        init = function()
            -- Note to self: init is called during startup. Configuration for vim plugins typically should be set in an init function
        end,
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        config = function()
            require("ibl").setup()
        end
    },
    {
        "folke/todo-comments.nvim",
        cmd = { "TodoTrouble", "TodoTelescope" },
        event = "LazyFile",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = true,
    },
    {
        "akinsho/git-conflict.nvim",
        event = "LazyFile",
        version = "*",
        config = true,
    },
    {
        "HampusHauffman/block.nvim",
        event = "LazyFile",
        opts = {
            percent = 0.8,
            depth = 4,
            bg = "#0E1418",
            colors = nil,
            automatic = true,
        },
        config = function(_, opts)
            require("block").setup(opts)
        end
    },
}
