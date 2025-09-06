return {
  "zapling/mason-conform.nvim",
  dependencies = {
    "williamboman/mason.nvim",
    "stevearc/conform.nvim",
  },
  config = function()
    require("mason-conform").setup({
      ensure_installed = {
        -- Web
        "prettier",

        -- Lua
        "stylua",

        -- SQL
        "sqlformat",

        -- XML
        "xmlformat",
      },

      -- Installation automatique
      automatic_installation = false,
    })
  end,
}
