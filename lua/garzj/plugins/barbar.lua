return {
	{
		"romgrk/barbar.nvim",
		version = "*",
		event = "VeryLazy",
		dependencies = {
			"lewis6991/gitsigns.nvim",
			"nvim-tree/nvim-web-devicons",
		},
		opts = {
			animation = false,
		},
		keys = {
			{ "<leader>b,", "<cmd>BufferPrevious<cr>", mode = "n" },
			{ "<leader>b.", "<cmd>BufferNext<cr>", mode = "n" },
			{ "<leader>bs", "<cmd>noa w<cr>", mode = "n" },
			{ "<leader>x", "<cmd>BufferClose<cr>", mode = "n" },
			{ "<leader>bt", "<cmd>BufferRestore<cr>", mode = "n" },
		},
	},
}
