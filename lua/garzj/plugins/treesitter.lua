return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = {
      ensure_installed = {
        "lua",
        "vim",
        "vimdoc",
        "markdown",
        "markdown_inline",
        "rust",
        "javascript",
        "typescript",
        "c",
      },

      auto_install = true,

      highlight = {
        enable = true,
        disable = function(lang, buf)
          local max_filesize = 100 * 1024 -- 100 KB
          local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
          if ok and stats and stats.size > max_filesize then
            return true
          end
        end,
      },
    },
  },

  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    dependencies = { "nvim-treesitter" },
    config = function()
      require("nvim-treesitter.configs").setup({
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ["if"] = "@function.inner",
              ["af"] = "@function.outer",
              ["ic"] = "@class.inner",
              ["ac"] = "@class.outer",
              ["ak"] = "@comment.outer",
            },
            selection_modes = {
              ["@function.inner"] = "v",
              ["@function.outer"] = "v",
              ["@class.inner"] = "v",
              ["@class.outer"] = "V",
            },
            include_surrounding_whitespace = true,
          },
        },
      })
    end,
  },
}
