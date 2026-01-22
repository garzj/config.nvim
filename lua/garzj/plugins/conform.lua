local confirm = require("garzj.dialogue").confirm

local prettier_config = vim.fn.expand("$HOME/.config/.prettierrc.json")
if vim.env.PRETTIERD_DEFAULT_CONFIG == nil and vim.fn.filereadable(prettier_config) == 1 then
  vim.env.PRETTIERD_DEFAULT_CONFIG = prettier_config
else
  vim.env.PRETTIERD_DEFAULT_CONFIG = nil
end

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
        "prettier",
        "clang-format",
        "isort",
        "black",
        "taplo",
        "shfmt",
        "csharpier",
        "php-cs-fixer",
        "joker",
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
        "<leader>f=",
        function()
          require("conform").format({ async = true })
        end,
        mode = "n",
        desc = "format file with conform",
      },
      -- https://github.com/stevearc/conform.nvim/issues/192#issuecomment-2573170631
      {
        "<leader>ft",
        function()
          if vim.b.disable_autoformat then
            vim.cmd("FormatEnable")
            vim.notify("Enabled autoformat for current buffer")
          else
            vim.cmd("FormatDisable!")
            vim.notify("Disabled autoformat for current buffer")
          end
        end,
        desc = "Toggle autoformat for current buffer",
      },
      {
        "<leader>fT",
        function()
          if vim.g.disable_autoformat then
            vim.cmd("FormatEnable")
            vim.notify("Enabled autoformat globally")
          else
            vim.cmd("FormatDisable")
            vim.notify("Disabled autoformat globally")
          end
        end,
        desc = "Toggle autoformat globally",
      },
    },
    opts = {
      format_on_save = function(bufnr)
        if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
          return
        end
        -- local disable_filetypes = { c = false, cpp = false }
        return {
          timeout_ms = 500,
          -- lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
          lsp_format = "fallback",
        }
      end,
      formatters_by_ft = {
        lua = { "stylua" },
        rust = { "rustfmt" },
        javascript = { "prettierd" },
        javascriptreact = { "prettierd" },
        typescript = { "prettierd" },
        typescriptreact = { "prettierd" },
        c = { "clang-format" },
        python = { "isort", "black" },
        toml = { "taplo" },
        sh = { "shfmt" },
        zsh = { "shfmt" },
        markdown = { "prettierd" },
        csharp = { "csharpier" },
        html = { "prettierd" },
        css = { "prettierd" },
        scss = { "prettierd" },
        json = { "prettierd" },
        jsonc = { "prettierd" },
        astro = { "prettierd" },
        php = { "php" },
        smt2 = { "joker" },
      },
      default_format_opts = {
        lsp_format = "fallback",
      },
      formatters = {
        php = {
          command = "php-cs-fixer",
          args = {
            "fix",
            "--config=" .. os.getenv("HOME") .. "/.config/php-cs-fixer.php",
            "$FILENAME",
          },
          stdin = false,
          env = {
            PHP_CS_FIXER_IGNORE_ENV = "1",
          },
        },
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

      -- https://github.com/stevearc/conform.nvim/issues/192#issuecomment-2573170631
      vim.api.nvim_create_user_command("FormatDisable", function(args)
        if args.bang then
          -- :FormatDisable! disables autoformat for this buffer only
          vim.b.disable_autoformat = true
        else
          -- :FormatDisable disables autoformat globally
          vim.g.disable_autoformat = true
        end
      end, {
        desc = "Disable autoformat-on-save",
        bang = true, -- allows the ! variant
      })
      vim.api.nvim_create_user_command("FormatEnable", function()
        vim.b.disable_autoformat = false
        vim.g.disable_autoformat = false
      end, {
        desc = "Re-enable autoformat-on-save",
      })
    end,
  },
}
