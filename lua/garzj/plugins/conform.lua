local confirm = require("garzj.dialogue").confirm

return {
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    lazy = false,
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      ensure_installed = {
        "stylua",
        -- "rustfmt", -- install via rustup
        "prettierd",
        "clang-format",
        "isort",
        "black",
        "taplo",
        "shfmt",
        "csharpier",
      },
      auto_update = true,
      run_on_start = true,
    },
  },

  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      {
        "<leader>ff",
        function()
          require("conform").format({ async = true })
        end,
        mode = "n",
      },
    },
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        rust = { "rustfmt" },
        javascript = { "prettierd" },
        typescript = { "prettierd" },
        tsx = { "prettierd" },
        c = { "clang-format" },
        python = { "isort", "black" },
        toml = { "taplo" },
        sh = { "shfmt" },
        zsh = { "shfmt" },
        markdown = { "prettierd" },
        csharp = { "csharpier" },
      },
      default_format_opts = {
        lsp_format = "fallback",
      },
      format_on_save = {
        timeout_ms = 500,
        lsp_format = "fallback",
      },
    },
    init = function()
      vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

      vim.api.nvim_create_user_command("FormatGitFiles", function()
        if not vim.fn.executable("git") == 1 then
          print("No git executable found!")
        end

        local handle = io.popen("git rev-parse --is-inside-work-tree")
        local result = handle:read("*a")
        handle:close()
        if result:gsub("%s+", "") ~= "true" then
          print("Not a git repository!")
        end

        local handle = io.popen("git ls-tree --full-tree -r HEAD --name-only")
        local result = handle:read("*a")
        handle:close()
        for file in result:gmatch("[^\r\n]+") do
          if vim.fn.filereadable(file) == 1 then
            vim.cmd("edit " .. vim.fn.fnameescape(file))
            vim.cmd('silent! lua require("conform").format()')
            vim.cmd("write")
            vim.cmd("bdelete")
          end
        end
      end, {})
    end,
  },
}
