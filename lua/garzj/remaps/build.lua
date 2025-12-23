local map = vim.keymap.set

local function buildDoc()
  local params = {
    textDocument = vim.lsp.util.make_text_document_params(),
  }

  vim.lsp.buf_request(0, "textDocument/build", params, function(err, result, ctx, config)
    if err then
      vim.notify("build error: " .. err.message, vim.log.levels.ERROR)
    else
      vim.notify("build success", vim.log.levels.INFO)
    end
  end)
end

map("n", "<leader>bb", buildDoc)

local autobuild_by_ft = {}
map("n", "<leader>ba", function()
  local ft = vim.bo.filetype
  autobuild_by_ft[ft] = not autobuild_by_ft[ft]

  local active_state = "on"
  if not autobuild_by_ft[ft] then
    active_state = "off"
  end

  local ft_autobuild = "autobuild for " .. ft
  if ft == "" then
    ft_autobuild = "default autobuild"
  end

  print(ft_autobuild .. ": " .. active_state)

  if autobuild_by_ft[ft] then
    buildDoc()
  end
end)
vim.api.nvim_create_autocmd("BufWritePost", {
  callback = function()
    local ft = vim.bo.filetype
    if autobuild_by_ft[ft] then
      buildDoc()
    end
  end,
})
