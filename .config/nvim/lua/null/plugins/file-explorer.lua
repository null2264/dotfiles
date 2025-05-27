return {
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
        config = function()
            require("neo-tree").setup({
                close_if_last_window = true,
            })
        end,
    },
    {
        "stevearc/oil.nvim",
        lazy = false,
        keys = {
            { "-", "<cmd>Oil<cr>", desc = "Oil" },
        },
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("oil").setup({
                default_file_explorer = true,
                keymaps = {
                    ["q"] = "actions.close",
                    ["<A-CR>"] = {
                        desc = "Recursively Open directores",
                        callback = function()
                            local oil = require("oil")
                            local dir = oil.get_current_dir()
                            local cursor = oil.get_cursor_entry()

                            local function o()
                                oil.open(dir .. cursor.name)
                                vim.wait(50)

                                dir = oil.get_current_dir()
                                cursor = oil.get_cursor_entry()

                                local bn = vim.fn.bufnr()
                                local lines = vim.api.nvim_buf_line_count(bn)

                                if lines == 1 and cursor ~= nil and cursor.type == "directory" then
                                    o()
                                end
                            end

                            o()
                        end,
                    },
                },
            })
        end
    },
}
