-- Définir la touche leader
vim.g.mapleader = ' '

-- Chemin pour lazy.nvim
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'

-- Installer lazy.nvim s'il n'est pas déjà installé
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- dernière version stable
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Configuration des plugins avec lazy.nvim
require('lazy').setup({
  -- Mason pour gérer les LSP
  {
    'williamboman/mason.nvim',
    config = function()
      require('mason').setup()
    end,
  },
  -- mason-lspconfig pour une intégration facile avec lspconfig
  {
    'williamboman/mason-lspconfig.nvim',
    dependencies = { 'williamboman/mason.nvim', 'neovim/nvim-lspconfig' },
    config = function()
      require('mason-lspconfig').setup()
      require('mason-lspconfig').setup_handlers {
        function (server_name)
          require('lspconfig')[server_name].setup {
            capabilities = require('cmp_nvim_lsp').default_capabilities(),
          }
        end,
      }
    end,
  },
  -- Configuration des LSP
  {
    'neovim/nvim-lspconfig',
  },
  -- Autocomplétion avec nvim-cmp
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
      'rafamadriz/friendly-snippets',
    },
    config = function()
      local cmp = require'cmp'
      cmp.setup {
        snippet = {
          expand = function(args)
            require'luasnip'.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-d>'] = cmp.mapping.scroll_docs(-4),
          ['<C-u>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
        }),
      }
    end,
  },
  -- Arborescence des fichiers avec nvim-tree
  {
    'nvim-tree/nvim-tree.lua',
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
      require('nvim-tree').setup {}
    end,
  },
  -- Barre des fichiers ouverts avec bufferline
  {
    'akinsho/bufferline.nvim',
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
      require('bufferline').setup{}
    end,
  },
  -- Terminal intégré avec toggleterm
  {
    'akinsho/toggleterm.nvim',
    config = function()
      require('toggleterm').setup{}
    end,
  },
})

-- Configurations supplémentaires (facultatif)
-- Vous pouvez ajouter des raccourcis clavier pour ouvrir nvim-tree et toggleterm

-- Ouvrir nvim-tree avec <leader>e
vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', { noremap = true, silent = true })

-- Ouvrir un terminal avec <leader>t
vim.keymap.set('n', '<leader>t', ':ToggleTerm<CR>', { noremap = true, silent = true })

