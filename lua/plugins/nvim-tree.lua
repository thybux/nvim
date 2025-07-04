return {
  "nvim-tree/nvim-tree.lua",
  dependencies = {
    "nvim-tree/nvim-web-devicons", -- pour les icônes
  },
  config = function()
    -- Configuration de base
    require("nvim-tree").setup({
      sort_by = "case_sensitive",
      view = {
        width = 30,
        side = "left",
        preserve_window_proportions = true,
      },
      renderer = {
        group_empty = true,
        icons = {
          show = {
            file = true,
            folder = true,
            folder_arrow = true,
            git = true,
          },
        },
      },
      filters = {
        dotfiles = false,
        custom = { ".git", "node_modules", ".cache" },
      },
      update_focused_file = {
        enable = true,
        update_cwd = true,
      },
    })

    -- <leader>e pour toggle l'arbre
    vim.keymap.set("n", "<leader>e", function()
      require("nvim-tree.api").tree.toggle()
    end, { desc = "Ouvrir / Fermer NvimTree" })
  end,
}
