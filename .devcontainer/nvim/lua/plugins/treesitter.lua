return {
  {
    "nvim-treesitter/nvim-treesitter",

    build = ":TSUpdate",

    config = function()
      local ts = require("nvim-treesitter")

      ts.setup({})

      ts.install({
        "lua",
        "vim",
        "bash",
        "json",
        "yaml",
        "markdown",
        "python",
        "javascript",
        "typescript",
        "tsx",
        "go",
        "dockerfile",
      })
    end,
  },
}
