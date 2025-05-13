-- Définir la touche leader
vim.g.mapleader = " "
vim.opt.termguicolors = true
vim.opt.cmdheight = 3
-- vim.opt.number = true
vim.opt.relativenumber = true
-- Chemin pour lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true

-- Installer lazy.nvim s'il n'est pas déjà installé
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- chrager l'ui
-- require("ui_colors")
-- require("colors")

vim.filetype.add({
  extension = {
    tpl = "html",
  },
})


-- Configuration des plugins avec lazy.nvim
require("lazy").setup({
  {
    "nickkadutskyi/jb.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
    config = function()
        require("jb").setup({transparent = true})
        vim.cmd("colorscheme jb")
    end,
  },
  {
		'navarasu/onedark.nvim',
	},
    -- Mason pour gérer les LSP
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
    {
    "github/copilot.vim",
  },
  {
    'ojroques/vim-oscyank',
  },
   {
    "neovim/nvim-lspconfig",
  },
  {
    "rcarriga/nvim-notify",
    config = function()
      vim.notify = require("notify")
    end,
  },
  -- mason-lspconfig pour une intégration facile avec lspconfig
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "neovim/nvim-lspconfig",
    },
    config = function()
      require("mason-lspconfig").setup()

     
      local enabled_lsp = {
          -- Serveurs déjà dans votre configuration
          intelephense = false,
          ts_ls = true,
          prettier = true,
          lua_ls = false,
          black = false,
          pyright = false,
          ["docker-compose-language-service"] = false,
          ["dockerfile-language-server"] = false,
          rust_analyzer = false,
          cobol_ls = false,

          -- Ajouter ou activer ces serveurs pour Node.js
          eslint = true,              -- Détection d'erreurs JavaScript
          jsonls = true,              -- Pour les fichiers JSON
          html = true,                -- Si vous travaillez avec HTML
          cssls = true,               -- Si vous travaillez avec CSS
          tailwindcss = false,        -- Activez si vous utilisez Tailwind CSS
          emmet_ls = false,           -- Activez si vous utilisez beaucoup de HTML/CSS
      }

      require("mason-lspconfig").setup_handlers({
        function(server_name)
          if enabled_lsp[server_name] then
            require("lspconfig")[server_name].setup({})
          end
        end,
      })
    end,
  },
 {
    "rebelot/kanagawa.nvim",
    config = function()
        require('kanagawa').setup({
        compile = false,             -- enable compiling the colorscheme
        undercurl = true,            -- enable undercurls
        commentStyle = { italic = true },
        functionStyle = {},
        keywordStyle = { italic = true},
        statementStyle = { bold = true },
        typeStyle = {},
        transparent = true,         -- do not set background color
        dimInactive = false,         -- dim inactive window `:h hl-NormalNC`
        terminalColors = true,       -- define vim.g.terminal_color_{0,17}
        colors = {                   -- add/modify theme and palette colors
            palette = {},
            theme = "wave",
            background = {
              dark = "wave",
          }
        },
        overrides = function(colors) -- add/modify highlights
            return {}
        end,
        theme = "wave",              -- Load "wave" theme when 'background' option is not set
        background = {               -- map the value of 'background' option to a theme
            dark = "dragon",           -- try "dragon" !
            light = "lotus"
        },
    })
    end,
  },
  {
    "neovim/nvim-lspconfig",
  },
  -- Affichage des indentations (version 2)
  {
    "lukas-reineke/indent-blankline.nvim",
    version = "v2", -- Spécifier la version 2
    config = function()
      require("indent_blankline").setup({
        show_current_context = true,
        show_current_context_start = true,
      })
    end,
  },
  -- Affichage des couleurs hexadécimales
  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup()
    end,
  },
  {
    'stevearc/conform.nvim',
    opts = {},
  },
  -- Navigation améliorée avec Harpoon
  {
    "ThePrimeagen/harpoon",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("harpoon").setup()
      -- Raccourcis pour Harpoon
      vim.keymap.set("n", "<leader>a", require("harpoon.mark").add_file)
      vim.keymap.set("n", "<leader>h", require("harpoon.ui").toggle_quick_menu)
    end,
  },
  -- Coloration syntaxique avancée avec Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate", -- Remplace 'run' par 'build' pour lazy.nvim
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "c", "lua", "python", "javascript" }, -- Ajoutez les langages que vous utilisez
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        indent = {
          enable = true,
        },
      })
    end,
  },
  -- Recherche de fichiers avec Telescope
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("telescope").setup({})
      -- Raccourcis pour Telescope
      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
      vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
      vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
    end,
  },
  -- Autocomplétion avec nvim-cmp
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",         -- Source pour LSP
      "hrsh7th/cmp-buffer",           -- Source pour buffer actuel
      "hrsh7th/cmp-path",             -- Source pour les chemins de fichiers
      "hrsh7th/cmp-cmdline",          -- Source pour la ligne de commande
      "L3MON4D3/LuaSnip",             -- Moteur de snippets
      "saadparwaiz1/cmp_luasnip",     -- Source pour LuaSnip
      "rafamadriz/friendly-snippets", -- Snippets prédéfinis
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      -- Charger les snippets prédéfinis
      require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        }),
      })

      -- Configuration pour la ligne de commande
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "path" },
          { name = "cmdline" },
        },
      })
    end,
  },
  -- Gestion des paires avec nvim-autopairs
  {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup({})
      -- Intégration avec nvim-cmp
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      local cmp = require("cmp")
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
  },
  -- Arborescence des fichiers avec nvim-tree
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      require("nvim-tree").setup({})
    end,
  },
  -- Barre des fichiers ouverts avec bufferline
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      require("bufferline").setup({})
    end,
  },
  -- Terminal intégré avec toggleterm
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("toggleterm").setup({})
    end,
  },
  -- Jeu pour s'entraîner aux commandes Vim
  {
    "ThePrimeagen/vim-be-good",
    cmd = { "VimBeGood" },
  },
})


require("conform").setup({
  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 500,
    lsp_format = "fallback",
  },
})

-- Ouvrir nvim-tree avec <leader>e
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { noremap = true, silent = true })

-- Ouvrir un terminal avec <leader>t
vim.keymap.set("n", "<leader>t", ":ToggleTerm<CR>", { noremap = true, silent = true })

-- Lancer le jeu vim-be-good avec <leader>g
vim.keymap.set("n", "<leader>g", ":VimBeGood<CR>", { noremap = true, silent = true })

-- Configuration de LSP
local lspconfig = require("lspconfig")

-- Configuration HTML LSP pour les templates

-- Configuration Emmet pour l'écriture rapide
lspconfig.emmet_ls.setup({
  filetypes = { "html", "css", "tpl" },
})

-- vim.cmd("colorscheme oneDark")
-- vim.opt.guifont = "JetBrainsMono Nerd Font:h12"

-- raccourci pour faire le copier coller 
vim.keymap.set('n', '<leader>c', '<Plug>OSCYankOperator')
vim.keymap.set('n', '<leader>cc', '<leader>c_', {remap = true})
vim.keymap.set('v', '<leader>c', '<Plug>OSCYankVisual')


-- fonction pour passer d'un fenetre a une autre dans le sens horaire
vim.cmd([[
function! ClockwiseNavigation()
  let l:current_win = winnr()
  let l:max_win = winnr('$')
  
  if l:current_win == l:max_win
    " Si on est dans la dernière fenêtre, revenir à la première
    execute "1wincmd w"
  else
    " Sinon, aller à la fenêtre suivante
    execute "wincmd w"
  endif
endfunction
]])

-- Mappez leader + tab à la fonction
vim.api.nvim_set_keymap('n', '<Leader><Tab>', ':call ClockwiseNavigation()<CR>', { noremap = true, silent = true })
