return {
    "nickkadutskyi/jb.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
    config = function()
        -- Configuration du thème JetBrains
        require("jb").setup({
            -- transparent = true, -- Décommentez pour transparence
            -- Autres options disponibles :
            -- italic_comments = true,
            -- bold_keywords = true,
            -- darker_sidebars = true,
        })
        vim.cmd("colorscheme jb")
    end,
}