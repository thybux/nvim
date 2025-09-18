return {
  "zapling/mason-conform.nvim",
  dependencies = {
    "williamboman/mason.nvim",
    "stevearc/conform.nvim",
  },
  config = function()
    require("mason-conform").setup({
      ensure_installed = {
        -- JavaScript/TypeScript (gros projets)
        "prettier",
        "prettierd", -- Plus rapide pour gros projets
        
        -- Rust
        "rustfmt",
        
        -- Python
        "black",
        "isort",
        
        -- Lua (pour config Neovim)
        "stylua",
        
        -- Utilitaires
        "shfmt", -- Shell scripts
      },

      -- Installation automatique pour performance
      automatic_installation = true,
    })
  end,
}
