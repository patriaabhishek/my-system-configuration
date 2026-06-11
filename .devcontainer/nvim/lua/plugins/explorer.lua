return {
  {
    "nvim-tree/nvim-tree.lua",

    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },

    config = function()
      require("nvim-tree").setup({

        sort_by = "case_sensitive",

        view = {
          width = 35,
          side = "left",
        },

        renderer = {
          group_empty = true,

          icons = {
            show = {
              file = true,
              folder = true,
              folder_arrow = true,
              git = true,
            },

            glyphs = {
              folder = {
                arrow_closed = "▶",
                arrow_open = "▼",
              },
            },
          },
        },

        filters = {
          dotfiles = false,
        },

        git = {
          enable = true,
        },
      })
    end,
  },
}
