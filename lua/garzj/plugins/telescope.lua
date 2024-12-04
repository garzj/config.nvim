return {
  "nvim-telescope/telescope.nvim",
  version = "*",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require("telescope").setup({
      pickers = {
        lsp_definitions = {
          file_ignore_patterns = { "@types/react" },
        },
      },
    })

    local builtin = require("telescope.builtin")
    vim.keymap.set("n", "<leader>fs", builtin.live_grep, { desc = "grep git files" })
    vim.keymap.set("n", "<leader>fg", builtin.git_files, { desc = "find git files" })
    vim.keymap.set("n", "<leader>ff", function()
      builtin.find_files({ hidden = true, no_ignore = true })
    end, { desc = "find all files" })
    vim.keymap.set("n", "<C-p>", builtin.find_files)
  end,
}
