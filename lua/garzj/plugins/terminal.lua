return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    opts = {
      shell = [[tmux new-session \; set-option destroy-unattached \; set-option status-style bg=black]],
      open_mapping = "<c-/>",
      shade_terminals = false,
      border = "curved",
    },
  },
}
