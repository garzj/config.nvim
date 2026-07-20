return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = ":TSUpdate",
    config = function()
      local parsers = {
        "lua",
        "vim",
        "vimdoc",
        "markdown",
        "markdown_inline",
        "rust",
        "javascript",
        "typescript",
        "tsx",
        "c",
        "cpp",
        "html",
        "css",
        "scss",
        "php",
        "astro",
        "python",
        "go",
        "java",
        "c_sharp",
        "bash",
        "yaml",
        "dockerfile",
        "json",
        "jsonc",
        "toml",
        "latex",
        "r",
        "dart",
        "glsl",
      }

      require("nvim-treesitter").install(parsers)

      -- Highlighting is no longer a module; start it per filetype via Neovim.
      vim.api.nvim_create_autocmd("FileType", {
        callback = function(ev)
          local max_filesize = 100 * 1024 -- 100 KB
          local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(ev.buf))
          if ok and stats and stats.size > max_filesize then
            return
          end

          pcall(vim.treesitter.start)

          if ev.match == "php" then
            vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end
        end,
      })
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("nvim-treesitter-textobjects").setup({
        select = {
          lookahead = true,
          selection_modes = {
            ["@function.inner"] = "v",
            ["@function.outer"] = "v",
            ["@class.inner"] = "v",
            ["@class.outer"] = "V",
          },
          include_surrounding_whitespace = true,
        },
      })

      local select = require("nvim-treesitter-textobjects.select")
      local function map(lhs, query)
        vim.keymap.set({ "x", "o" }, lhs, function()
          select.select_textobject(query, "textobjects")
        end)
      end

      map("if", "@function.inner")
      map("af", "@function.outer")
      map("ic", "@class.inner")
      map("ac", "@class.outer")
      map("ak", "@comment.outer")
    end,
  },
}
