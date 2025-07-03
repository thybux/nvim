return {
  "zapling/mason-conform.nvim",
  dependencies = {
    "williamboman/mason.nvim",
    "stevearc/conform.nvim",
  },
  config = function()
    require("mason-conform").setup({
      -- Formatters à installer automatiquement
      ensure_installed = {
        -- Web
        "prettier",

        -- Python
        "black",
        "isort",

        -- Lua
        "stylua",

        -- Go
        "goimports",
        "gofmt",

        -- Rust (installé avec rustup généralement)
        -- "rustfmt",

        -- C/C++
        "clang-format",

        -- Java
        "google-java-format",

        -- Shell
        "shfmt",

        -- SQL
        "sqlformat",

        -- TOML
        "taplo",

        -- XML
        "xmlformat",
      },

      -- Installation automatique
      automatic_installation = true,
    })
  end,
}
