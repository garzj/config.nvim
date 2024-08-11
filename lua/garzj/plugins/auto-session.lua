return {
	"rmagatti/auto-session",
	lazy = false,
	dependencies = { "nvim-telescope/telescope.nvim" },
	keys = {
		{ "<leader>ss", "<cmd>SessionSave<cr>", mode = "n" },
		{ "<leader>sl", "<cmd>Telescope session-lens<cr>", mode = "n" },
	},
	opts = {
		auto_session_create_enabled = false,
		auto_session_suppress_dirs = { "~", "~/src" },
		silent_restore = true,
	},
}
