return {
  {
    "williamboman/mason.nvim",
    opts = {},
  },

  {
    "williamboman/mason-lspconfig.nvim",

    opts = {
      ensure_installed = {
        "pyright",
        "vtsls",
        "eslint",
        "gopls",
        "clangd",
        "html",
        "cssls",
        "dockerls",
      },
    },
  },

  {
    "neovim/nvim-lspconfig",

    config = function()
      vim.lsp.enable("pyright")
      vim.lsp.enable("vtsls")
      vim.lsp.enable("eslint")
      vim.lsp.enable("gopls")
      vim.lsp.enable("clangd")
      vim.lsp.enable("html")
      vim.lsp.enable("cssls")
      vim.lsp.enable("dockerls")
    end,
  },
}
