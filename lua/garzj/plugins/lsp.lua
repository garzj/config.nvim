return {
  {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v4.x",
    lazy = true,
    config = false,
  },
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
      local lsp_zero = require("lsp-zero")

      local lsp_attach = function(client, bufnr)
        local opts = { buffer = bufnr }

        local map = vim.keymap.set

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

      lsp_zero.extend_lspconfig({
        sign_text = {
          error = "✘",
          warn = "▲",
          hint = "⚑",
          info = "»",
        },
        lsp_attach = lsp_attach,
        capabilities = require("cmp_nvim_lsp").default_capabilities(),
      })

      lsp_zero.setup_servers({ "dartls", force = true })

      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "rust_analyzer",
          "ts_ls",
          "eslint",
          "clangd",
          "bashls",
          "omnisharp",
          "dockerls",
          "docker_compose_language_service",
          "yamlls",
          "html",
          "cssls",
        },
        handlers = {
          function(server_name)
            require("lspconfig")[server_name].setup({})
          end,
        },
      })
    end,
  },
}
