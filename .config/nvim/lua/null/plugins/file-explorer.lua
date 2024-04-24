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
		config = function ()
			require("neo-tree").setup({
				close_if_last_window = true,
			})
		end,
	},
	{
  		"stevearc/oil.nvim",
		lazy = false,
  		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function ()
			require("oil").setup({
				default_file_explorer = true,
				keymaps = {
					["q"] = "actions.close",
				},
			})
		end
	},
}
