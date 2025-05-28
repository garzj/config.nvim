-- rust_analyzer fix: https://github.com/neovim/neovim/issues/30985#issuecomment-2447329525
for _, method in ipairs({ "textDocument/diagnostic", "workspace/diagnostic" }) do
  local default_diagnostic_handler = vim.lsp.handlers[method]
  vim.lsp.handlers[method] = function(err, result, context, config)
    if err ~= nil and err.code == -32802 then
      return
    end
    return default_diagnostic_handler(err, result, context, config)
  end
end

return {
  {
    "williamboman/mason.nvim",
    lazy = false,
    config = true,
  },

  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      { "L3MON4D3/LuaSnip" },
    },
    config = function()
      local cmp = require("cmp")

      local cmp_select = { behavior = cmp.SelectBehavior.Select }
      local mappings = {
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-u>"] = cmp.mapping.scroll_docs(-4),
        ["<C-d>"] = cmp.mapping.scroll_docs(4),
        ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
        ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
        ["<Tab>"] = cmp.mapping.confirm({ select = true }),
      }

      cmp.setup({
        sources = {
          { name = "nvim_lsp" },
        },
        mapping = cmp.mapping.preset.insert(mappings),
        snippet = {
          expand = function(args)
            vim.snippet.expand(args.body)
          end,
        },
      })
    end,
  },

  {
    "neovim/nvim-lspconfig",
    cmd = { "LspInfo", "LspInstall", "LspStart" },
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "hrsh7th/cmp-nvim-lsp" },
      { "williamboman/mason.nvim" },
      { "williamboman/mason-lspconfig.nvim" },
      { "nvim-telescope/telescope.nvim" },
    },
    config = function()
      local on_attach = function(client, bufnr)
        local map = vim.keymap.set
        local opts = { buffer = bufnr }

        map("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
        map("n", "gd", function()
          require("telescope.builtin").lsp_definitions()
        end, opts)
        map("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
        map("n", "gi", function()
          require("telescope.builtin").lsp_implementations()
        end, opts)
        map("n", "go", function()
          require("telescope.builtin").lsp_type_definitions()
        end, opts)
        map("n", "gr", function()
          require("telescope.builtin").lsp_references()
        end, opts)
        map("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)
        map("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
        map({ "n", "x" }, "<F3>", "<cmd>lua vim.lsp.buf.format({ async = true })<cr>", opts)
        map("n", "<F4>", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
      end

      local severity = vim.diagnostic.severity
      vim.diagnostic.config({
        signs = {
          text = {
            [severity.ERROR] = "✘",
            [severity.WARN] = "▲",
            [severity.HINT] = "⚑",
            [severity.INFO] = "»",
          },
        },
      })

      local servers = {
        lua_ls = {
          settings = {
            Lua = {
              diagnostics = {
                globals = { "vim" },
              },
            },
          },
        },
        rust_analyzer = {},
        ts_ls = {},
        eslint = {},
        clangd = {},
        bashls = {},
        omnisharp = {},
        dockerls = {},
        docker_compose_language_service = {},
        yamlls = {},
        html = {},
        cssls = {},
        jdtls = {},
        astro = {},
        texlab = {
          settings = {
            texlab = {
              build = {
                onSave = false,
                forwardSearchAfter = true,
              },
              forwardSearch = {
                executable = "evince-synctex",
                args = { "-f", "%l", "%p", '"texlab -i %f -l %l"' },
              },
            },
          },
        },
        pyright = {},
        intelephense = {
          init_options = {
            globalStoragePath = os.getenv("HOME") .. "/.local/share/intelephense",
          },
        },
      }

      require("mason").setup()
      require("mason-lspconfig").setup({
        automatic_enable = false,
        ensure_installed = vim.tbl_keys(servers),
      })

      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      for server_name, opts in pairs(servers) do
        local default_opts = {
          capabilities = capabilities,
          on_attach = on_attach,
        }
        for k, v in pairs(default_opts) do
          opts[k] = v
        end
        lspconfig[server_name].setup(opts)
      end
    end,
  },
}
