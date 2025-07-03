return {
  "folke/noice.nvim",
  dependencies = {
    "MunifTanjim/nui.nvim",
  },
  config = function()
    require("noice").setup({
      cmdline = {
        enabled = true,
        view = "cmdline_popup",
        opts = {
          position = { row = 5, col = "50%" },
          size = { width = 60, height = "auto" },
          border = { style = "rounded" },
        },
      },
      messages = { enabled = false },
      popupmenu = { enabled = false },
      notify = { enabled = false },
      lsp = { override = {} },
    })
  end,
}
