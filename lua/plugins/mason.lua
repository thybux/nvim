return {
  "williamboman/mason.nvim",
  build = ":MasonUpdate",
  config = function()
    require("mason").setup()
    -- Installation manuelle des LSP
    vim.api.nvim_create_user_command("InstallLSP", function()
      vim.cmd("MasonInstall lua-language-server pyright")
    end, {})
  end,
}
