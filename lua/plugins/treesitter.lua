-- lua/plugins/treesitter.lua

require'nvim-treesitter.configs'.setup {
    -- Installer les parsers pour ces langages
    ensure_installed = { "c", "lua", "python", "javascript", "typescript", "html", "css", "json" },
    -- Installer les parsers de manière asynchrone
    sync_install = false,
    -- Activer la coloration syntaxique
    highlight = {
        enable = true,
        -- Désactiver la coloration syntaxique pour les fichiers volumineux
        additional_vim_regex_highlighting = false,
    },
}

