return {
	"akinsho/bufferline.nvim",
	version = "*",
	event = "VeryLazy",
	dependencies = "nvim-tree/nvim-web-devicons",
	opts = {
		options = {
			close_command = "bdelete %d",
			right_mouse_command = false,
			left_mouse_command = "buffer %d",
			middle_mouse_command = "bdelete %d",
			indicator = {
				style = "none",
			},
			buffer_close_icon = false,
			diagrostics = "nvim_lsp",
			diagnostics_update_in_insert = false,
			diagnostics_update_on_event = true,
		},
	},
	keys = {
		{ "<leader>b,", "<cmd>BufferLineCyclePrev<cr>", mode = "n" },
		{ "<leader>b.", "<cmd>BufferLineCycleNext<cr>", mode = "n" },
		{ "<leader>bp", "<cmd>BufferLinePick<cr>", mode = "n" },
		{ "<leader>bc", "<cmd>bdelete<cr>", mode = "n" },
		{ "<leader>x", "<cmd>bdelete<cr>", mode = "n" },
		{ "<leader>bQ", "<cmd>bdelete!<cr>", mode = "n" },
		{ "<leader>bo", "<cmd>BufferLineCloseOthers<cr>", mode = "n" },
		{ "<leader>bs", "<cmd>noa w<cr>", mode = "n" },
	},
}
