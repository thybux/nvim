-- ~/.config/nvim/lua/plugins/lsp-minimal.lua
return {
  {
    "williamboman/mason.nvim",
    config = true,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("lspconfig").lua_ls.setup({
        settings = { Lua = { diagnostics = { globals = { "vim" } } } }
      })
    end,
  },
}
