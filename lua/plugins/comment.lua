return {
  "numToStr/Comment.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("Comment").setup({
      -- Raccourcis par défaut :
      -- gcc : commenter ligne
      -- gc : commenter sélection
      -- gbc : commenter bloc
    })
  end,
}
