return {
  "williamboman/mason.nvim",
  build = ":MasonUpdate",
  config = function()
    require("mason").setup()
    vim.api.nvim_create_user_command("InstallLSP", function()
      vim.cmd("MasonInstall lua-language-server pyright intelephense")
    end, {})
  end,
}
