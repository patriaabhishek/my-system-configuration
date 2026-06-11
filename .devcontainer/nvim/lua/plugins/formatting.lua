return {

  {
    "stevearc/conform.nvim",

    config = function()
      local env = require("core.env")

      require("conform").setup({

        formatters_by_ft = {
          python = { "ruff_format" },
          javascript = { "prettier" },
          typescript = { "prettier" },
          go = { "gofmt" },
        },

        formatters = {
          ruff_format = {
            command = env.ruff,
          },
          gofmt = {
            command = env.goroot .. "/bin/gofmt",
          },
        },

        format_on_save = {
          timeout_ms = 500,
          lsp_fallback = true,
        },
      })
    end,
  },
}
