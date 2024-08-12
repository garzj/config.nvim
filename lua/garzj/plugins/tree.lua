return {
  "nvim-tree/nvim-tree.lua",
  dependencies = "nvim-tree/nvim-web-devicons",
  event = "VeryLazy",
  opts = {
    filesystem_watchers = { enable = true },
    disable_netrw = true,
    sync_root_with_cwd = true,
    respect_buf_cwd = true,
    git = {
      enable = true,
      ignore = false,
      timeout = 500,
    },
    filters = {
      dotfiles = false,
      custom = { "^.git$", "^node_modules$" },
    },
    actions = {
      open_file = {
        quit_on_open = true,
      },
    },
  },
  init = function()
    vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeOpen<cr>")
    vim.keymap.set("n", "<leader>w", "<cmd>NvimTreeClose<cr>")
  end,
}
