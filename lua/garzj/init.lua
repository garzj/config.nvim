require("garzj.opt")
require("garzj.remap")
require("garzj.mouse")
require("garzj.filetypes")
require("garzj.autocmds")
require("garzj.diagnostics")
if vim.g.vscode == nil then
  require("garzj.lazy")
end
