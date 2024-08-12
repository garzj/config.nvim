return {
  "https://github.com/laytan/cloak.nvim",
  lazy = false,
  opts = {
    enabled = true,
    cloak_character = "*",
    highlight_group = "Comment",
    cloak_length = 8,
    try_all_patterns = true,
    cloak_telescope = true,
    cloak_on_leave = false,
    patterns = {
      {
        file_pattern = ".env*",
        cloak_pattern = "=.+",
        replace = nil,
      },
    },
  },
  init = function()
    vim.keymap.set("n", "<leader>ct", "<cmd>CloakToggle<cr>")
    vim.keymap.set("n", "<leader>ce", "<cmd>CloakEnable<cr>")
    vim.keymap.set("n", "<leader>cd", "<cmd>CloakDisable<cr>")
  end,
}
