-- init.lua pour Neovim
vim.o.mouse = 'a'
vim.g.mapleader = ' '

-- Installer Packer si nécessaire
local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.fn.execute('!git clone --depth 1 https://github.com/wbthomason/packer.nvim ' .. install_path)
    vim.cmd 'packadd packer.nvim'
end

-- Utilisation de Packer pour gérer les plugins
require('packer').startup(function(use)
    use 'EdenEast/nightfox.nvim'
    use 'wbthomason/packer.nvim' -- Packer peut se mettre à jour tout seul
    use {
        'neovim/nvim-lspconfig', -- Configuration des LSPs
    }
    use {
        'williamboman/mason.nvim',
        config = function()
            require('mason').setup()
        end
    }
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    }
    use {
        'williamboman/mason-lspconfig.nvim',
        config = function()
            require('mason-lspconfig').setup({
                ensure_installed = { "pyright", "tsserver" }
            })
        end
    }
    use {
        'MunifTanjim/prettier.nvim',
        config = function()
            require('prettier').setup({
                bin = 'prettier',  -- Assurez-vous que prettier est installé globalement
                filetypes = {
                    'css',
                    'javascript',
                    'json',
                    'lua',
                    'markdown',
                    'php',
                    'typescript',
                    'yaml'
                }
            })
        end
    }
    use {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        requires = { 
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
        }
    }
    use "lukas-reineke/indent-blankline.nvim"
    use 'hrsh7th/nvim-cmp'        -- Moteur de complétion pour Neovim
    use 'hrsh7th/cmp-nvim-lsp'    -- Intégration de nvim-cmp avec les LSP
    use 'hrsh7th/cmp-buffer'      -- Complétion à partir du contenu du buffer
    use 'hrsh7th/cmp-path'        -- Complétion des chemins de fichiers
    use 'hrsh7th/cmp-cmdline'     -- Complétion en ligne de commande
    use 'L3MON4D3/LuaSnip'        -- Gestionnaire de snippets pour nvim-cmp
    use 'saadparwaiz1/cmp_luasnip' -- Intégration de LuaSnip avec nvim-cmp
    use {
        'windwp/nvim-autopairs',  -- Auto-pairing de brackets et autres
        config = function() require('nvim-autopairs').setup() end
    }
    use {
        'akinsho/nvim-bufferline.lua',
        requires = 'nvim-tree/nvim-web-devicons',
        config = function()
            require('bufferline').setup {
                options = {
                    diagnostics = "nvim_lsp",
                    offsets = {{filetype = "NvimTree", text = "", padding = 1}},
                    show_buffer_close_icons = false,
                    show_close_icon = false,
                    separator_style = "thin",
                    enforce_regular_tabs = true,
                    always_show_bufferline = true,
                }
            }
        end
    }

end)

-- Chargement des configurations de plugins depuis des fichiers séparés
require('plugins.autopairs')
require('plugins.cmp')
require('plugins.lspconfig')
require('plugins.treesitter')
require('plugins.ibl')
-- Configuration de Neo-tree et ajout d'un raccourci clavier pour l'ouvrir
vim.api.nvim_set_keymap('n', '<leader>e', ':Neotree toggle<CR>', { noremap = true, silent = true })


-- Configuration du thème gruvbox
-- vim.cmd [[colorscheme gruvbox]]
-- vim.cmd("colorscheme carbonfox")
--Activer les couleurs de terminalvim
-- vim.opt.termguicolors = true
--

-- pour les espace de tabulation
vim.opt.tabstop = 4     -- Nombre de colonnes de texte qu'une tabulation représente
vim.opt.shiftwidth = 4  -- Nombre de colonnes de texte à utiliser pour l'indentation automatique
vim.opt.expandtab = true -- Convertit les tabulations en espaces


-- le debug en cas de crash de nvim
vim.lsp.set_log_level("debug")
vim.g.gruvbox_contrast_dark = 'hard'


-- indentation 
vim.api.nvim_create_augroup("AutoIndent", { clear = true })
-- vim.api.nvim_create_autocmd("BufWritePre", {
--     group = "AutoIndent",
--     pattern = "*",
--     command = "normal gg=G"
-- })

-- pour les nombre de lignes
vim.opt.number = true
vim.opt.relativenumber = true

-- enregistrement san remonter en haut
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    callback = function()
        vim.w.save_cursor = vim.api.nvim_win_get_cursor(0)
    end
})

vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = "*",
    callback = function()
        vim.api.nvim_win_set_cursor(0, vim.w.save_cursor)
    end
})

