local confirm = require("garzj.dialogue").confirm

local map = vim.keymap.set

map("i", "<C-c>", "<Esc>")

map("x", "J", ":m '>+1<CR>gv=gv")
map("x", "K", ":m '>-2<CR>gv=gv")

map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

-- copy pasta (system clip and replace / delete into void buf)
map({ "n", "x" }, "<leader>p", '"+p')
map({ "n", "x" }, "<leader>P", '"+P')
map({ "n", "x" }, "<leader>y", '"+y')
map({ "n", "x" }, "<leader>d", '"+d')
map("n", "<leader>Y", '"+Y')
map("n", "<leader>D", '"+D')

map("n", "<leader>fx", function()
  if confirm("Make this file executable") then
    vim.api.nvim_command("!chmod +x %")
  end
end, { silent = true, desc = "make file executable" })
map("n", "<leader>fn", function()
  local cwd = vim.fn.getcwd()
  local cmd = "nautilus " .. cwd .. " > /dev/null 2>&1 & disown"
  os.execute(cmd)
end, { silent = true, desc = "open nautilus in file dir" })

map("i", "<C-BS>", "<C-W>")
map("i", "<C-H>", "<C-W>")

map("n", "gh", vim.diagnostic.open_float)
map("n", "[d", vim.diagnostic.goto_prev)
map("n", "]d", vim.diagnostic.goto_next)

map("n", "<leader>tn", function()
  os.execute("alacritty & disown")
end, { silent = true })
map("n", "<leader>tf", function()
  local file_path = vim.api.nvim_buf_get_name(0)
  local dir = vim.fn.fnamemodify(file_path, ":p:h")
  os.execute("alacritty --working-directory " .. dir .. " & disown")
end, { silent = true })

-- indent empty lines when A
map("n", "A", function()
  local line = vim.api.nvim_get_current_line()

  if #line == 0 then
    return '"_cc'
  else
    return "A"
  end
end, { expr = true, noremap = true })
