return {
	"nvim-telescope/telescope.nvim",
	version = "*",
	event = "VeryLazy",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		require("telescope").setup({})

		local builtin = require("telescope.builtin")
		vim.keymap.set("n", "<leader>pf", builtin.find_files)
		vim.keymap.set("n", "<leader>ps", builtin.live_grep)
		vim.keymap.set("n", "<leader>pg", builtin.git_files)
		vim.keymap.set("n", "<C-p>", builtin.git_files)
	end,
}
