return {

  ----------------------------------------------------------------
  -- Statusline
  ----------------------------------------------------------------
  {
    "nvim-lualine/lualine.nvim",

    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },

    config = function()
      require("lualine").setup({
        options = {
          theme = "material",
          globalstatus = true,
          icons_enabled = true,
        },
      })
    end,
  },

  ----------------------------------------------------------------
  -- Bufferline (VSCode Tabs)
  ----------------------------------------------------------------
  {
    "akinsho/bufferline.nvim",

    version = "*",

    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },

    config = function()
      require("bufferline").setup({
        options = {
          mode = "buffers",
          separator_style = "slant",
          show_buffer_close_icons = true,
          show_close_icon = false,
          diagnostics = "nvim_lsp",
          offsets = {
            {
              filetype = "NvimTree",
              text = "Explorer",
              highlight = "Directory",
              separator = true,
            },
          },
        },
      })
    end,
  },

  ----------------------------------------------------------------
  -- Indent Guides
  ----------------------------------------------------------------
  {
    "lukas-reineke/indent-blankline.nvim",

    main = "ibl",

    config = function()
      require("ibl").setup()
    end,
  },

  ----------------------------------------------------------------
  -- Git Signs (gutter indicators)
  ----------------------------------------------------------------
  {
    "lewis6991/gitsigns.nvim",

    config = function()
      require("gitsigns").setup()
    end,
  },

  ----------------------------------------------------------------
  -- Trouble (Problems Panel)
  ----------------------------------------------------------------
  {
    "folke/trouble.nvim",

    dependencies = { "nvim-tree/nvim-web-devicons" },

    config = function()
      require("trouble").setup()
    end,
  },

  ----------------------------------------------------------------
  -- Fidget (LSP progress indicator)
  ----------------------------------------------------------------
  {
    "j-hui/fidget.nvim",

    config = function()
      require("fidget").setup()
    end,
  },

  ----------------------------------------------------------------
  -- Noice (better UI for messages/cmdline)
  ----------------------------------------------------------------
  {
    "folke/noice.nvim",

    event = "VeryLazy",

    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },

    config = function()
      require("noice").setup({
        lsp = {
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
          },
        },
        presets = {
          bottom_search = true,
          command_palette = true,
          long_message_to_split = true,
          lsp_doc_border = true,
        },
      })
    end,
  },
}
