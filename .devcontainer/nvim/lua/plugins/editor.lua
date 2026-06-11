return {

  ----------------------------------------------------------------
  -- Which Key (keybinding hints)
  ----------------------------------------------------------------
  {
    "folke/which-key.nvim",

    event = "VeryLazy",

    config = function()
      require("which-key").setup({
        delay = 300,
      })
    end,
  },

  ----------------------------------------------------------------
  -- Auto Pairs
  ----------------------------------------------------------------
  {
    "windwp/nvim-autopairs",

    event = "InsertEnter",

    config = function()
      require("nvim-autopairs").setup({
        check_ts = true,
      })
    end,
  },

  ----------------------------------------------------------------
  -- Comment Toggle (Ctrl+/)
  ----------------------------------------------------------------
  {
    "numToStr/Comment.nvim",

    event = "BufReadPost",

    config = function()
      require("Comment").setup()
    end,
  },

  ----------------------------------------------------------------
  -- Treesitter Text Objects
  -- Provides af/if (function), ac/ic (class) motions
  ----------------------------------------------------------------
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
  },

  ----------------------------------------------------------------
  -- Illuminate (highlight word under cursor)
  ----------------------------------------------------------------
  {
    "RRethy/vim-illuminate",

    event = "BufReadPost",

    config = function()
      require("illuminate").configure({
        delay = 200,
        providers = { "lsp", "treesitter", "regex" },
      })
    end,
  },
}
