return {

  ----------------------------------------------------------------
  -- Icons
  ----------------------------------------------------------------
  {
    "nvim-tree/nvim-web-devicons",
    lazy = true,
  },

  {
    "echasnovski/mini.icons",
    version = false,

    config = function()
      require("mini.icons").setup()
      MiniIcons.mock_nvim_web_devicons()
    end,
  },

  ----------------------------------------------------------------
  -- Colorscheme
  ----------------------------------------------------------------
  {
    "marko-cerovac/material.nvim",

    priority = 1000,

    config = function()
      vim.g.material_style = "oceanic"
      vim.cmd.colorscheme("material")
    end,
  },
}
