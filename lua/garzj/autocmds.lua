-- default commentstring
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = "*",
  callback = function()
    if vim.bo.syntax == "" then
      vim.bo.commentstring = "# %s"
    end
  end,
})
