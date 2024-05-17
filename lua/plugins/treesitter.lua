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
        disable = function(lang, buf)
            local max_filesize = 100 * 1024 -- 100 KB
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
                return true
            end
        end,
        -- Utiliser Treesitter pour la coloration syntaxique au lieu de Vim
        additional_vim_regex_highlighting = false,
    },
}

