return {
	"tpope/vim-fugitive",
	event = "VeryLazy",
	config = function()
		vim.keymap.set("n", "<leader>gs", "<cmd>tab Git<cr>")
	end,
}
