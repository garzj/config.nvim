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
		end,
	},
}
