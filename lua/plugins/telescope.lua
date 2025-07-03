return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.4",
  dependencies = { 
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope-fzf-native.nvim", -- Performance
  },
  config = function()
    require("telescope").setup({
      defaults = {
        mappings = {
          i = {
            ["<C-u>"] = false,
            ["<C-d>"] = false,
          },
        },
      },
    })
    
    -- Raccourcis Telescope
     local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Rechercher fichiers" })
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Rechercher dans fichiers" })
      vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Rechercher buffers" })
      vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Rechercher aide" })
      vim.keymap.set("n", "<leader>fs", builtin.lsp_document_symbols, { desc = "Symboles document" })
      vim.keymap.set("n", "<leader>fw", builtin.lsp_workspace_symbols, { desc = "Symboles workspace" })
  end,
}
