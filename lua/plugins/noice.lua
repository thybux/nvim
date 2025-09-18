return {
  "folke/noice.nvim",
  event = "VeryLazy", -- Chargement retardé pour éviter les blocages
  dependencies = {
    "MunifTanjim/nui.nvim",
  },
  config = function()
    require("noice").setup({
      -- Configuration pour éviter les blocages au démarrage
      cmdline = {
        enabled = true,
        view = "cmdline", -- Vue plus simple
      },
      messages = {
        enabled = false, -- Désactive les messages qui peuvent bloquer
      },
      popupmenu = {
        enabled = false, -- Désactive le popup menu
      },
      notify = {
        enabled = false, -- Désactive les notifications
      },
      lsp = {
        progress = {
          enabled = false, -- Désactive la barre de progrès LSP
        },
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      presets = {
        bottom_search = false, -- Pas de barre de recherche en bas
        command_palette = false, -- Pas de palette de commandes
        long_message_to_split = true,
        inc_rename = false,
        lsp_doc_border = false,
      },
      -- Routes pour éviter les messages bloquants
      routes = {
        {
          filter = {
            event = "msg_show",
            any = {
              { find = "%d+L, %d+B" },
              { find = "; after #%d+" },
              { find = "; before #%d+" },
              { find = "%d fewer lines" },
              { find = "%d more lines" },
            },
          },
          opts = { skip = true },
        },
      },
    })
  end,
}
