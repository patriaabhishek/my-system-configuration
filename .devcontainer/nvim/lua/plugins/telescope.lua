return {
  {
    "nvim-telescope/telescope.nvim",

    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
    },

    config = function()
      local telescope = require("telescope")

      telescope.setup({
        extensions = {
          ["ui-select"] = {},
        },
      })

      telescope.load_extension("ui-select")
    end,
  },

  {
    "ahmedkhalf/project.nvim",

    config = function()
      require("project_nvim").setup({
        detection_methods = {
          "lsp",
          "pattern",
        },
      })
    end,
  },
}
