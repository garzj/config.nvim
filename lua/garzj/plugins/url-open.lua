return {
  "sontungexpt/url-open",
  branch = "mini",
  event = "VeryLazy",
  cmd = "URLOpenUnderCursor",
  keys = {
    { "gx", "<cmd>URLOpenUnderCursor<cr>", mode = "n" },
  },
  config = function()
    local status_ok, url_open = pcall(require, "url-open")
    if not status_ok then
      return
    end
    url_open.setup({})
  end,
}
