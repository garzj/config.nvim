return {
	"nvim-telescope/telescope.nvim",
	version = "*",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		require("telescope").setup({})

		local builtin = require("telescope.builtin")
		vim.keymap.set("n", "<leader>ps", builtin.live_grep)
		vim.keymap.set("n", "<leader>pg", builtin.git_files)
		vim.keymap.set("n", "<leader>pf", function()
			builtin.find_files({ hidden = true, no_ignore = true })
		end)
		vim.keymap.set("n", "<C-p>", builtin.find_files)
	end,
}
