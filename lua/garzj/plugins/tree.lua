return {
	"nvim-tree/nvim-tree.lua",
	event = "VeryLazy",
	opts = {},
	init = function()
		vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeOpen<cr>")
		vim.keymap.set("n", "<leader>w", "<cmd>NvimTreeClose<cr>")
	end,
}
