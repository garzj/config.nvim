return {
  "jedrzejboczar/possession.nvim",
  lazy = false,
  requires = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
  opts = {
    autoload = "last_cwd",
    autosave = {
      current = true,
    },
    plugins = {
      delete_hidden_buffers = false,
      delete_buffers = true,
    },
  },
  init = function()
    require("telescope").load_extension("possession")
  end,
  keys = {
    { "<leader>ss", "<cmd>SessionSave<cr>", mode = "n" },
    { "<leader>sl", "<cmd>Telescope possession list<cr>", mode = "n" },
  },
}
