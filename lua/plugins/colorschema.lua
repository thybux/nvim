-- ~/.config/nvim/lua/plugins/colorschema.lua

return {
  {
    "neanias/everforest-nvim",
    lazy = false,
    priority = 1000,
    opts = {
      background = "medium", -- Choisissez entre 'hard', 'medium', 'soft'
      transparent_background_level = 1,
      italics = true,
      disable_italic_comments = true,
    },
    config = function()
      require("everforest").setup({
        background = "medium", -- Choisissez entre 'hard', 'medium', 'soft'
        transparent_background_level = 1,
        italics = true,
        disable_italic_comments = true,
        on_highlights = function(highlight, colors)
          highlight.Normal = { bg = "NONE", fg = colors.fg }
          highlight.NormalNC = { bg = "NONE", fg = colors.fg }
          highlight.NeoTreeNormal = { bg = "NONE", fg = colors.fg }
          highlight.NeoTreeNormalNC = { bg = "NONE", fg = colors.fg }
        end,
      })
      vim.cmd([[
        highlight Normal guibg=NONE ctermbg=NONE
        highlight NormalNC guibg=NONE ctermbg=NONE
        highlight NeoTreeNormal guibg=NONE ctermbg=NONE
        highlight NeoTreeNormalNC guibg=NONE ctermbg=NONE
      ]])
    end,
  },
}
