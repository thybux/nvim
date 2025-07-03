-- Définir la touche leader
vim.g.mapleader = " "

-- Options de base
vim.opt.termguicolors = true
vim.opt.cmdheight = 3
vim.opt.relativenumber = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.smoothscroll = true

-- Filetype personnalisé
vim.filetype.add({ extension = { tpl = "html" } })

-- Lazy.nvim bootstrap
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", lazypath })
end
vim.opt.rtp:prepend(lazypath)


-- require('lsp-manager')


-- Plugins
require("lazy").setup({
  {
    "nickkadutskyi/jb.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("jb").setup({ transparent = true })
      vim.cmd("colorscheme jb")
    end
  },
  {
    "amitds1997/remote-nvim.nvim",
    version = "*",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      local status, remote_nvim = pcall(require, "remote-nvim")
      if status then
        print("remote_nvim loaded successfully")
        remote_nvim.setup()
      else
        print("remote_nvim failed to load", remote_nvim)
      end
    end,
  },
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



  -- Remplace toute ta section Mason/LSP par ceci (SANS mason-lspconfig) :

  {
    "williamboman/mason.nvim",
    lazy = false,
    config = function()
      require("mason").setup()
    end
  },

  { "neovim/nvim-lspconfig",    lazy = false },

  -- Configuration LSP directe (sans mason-lspconfig)
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")

      -- Rust
      lspconfig.rust_analyzer.setup({
        settings = {
          ['rust-analyzer'] = {
            cargo = { allFeatures = true },
            checkOnSave = { command = 'clippy' },
          }
        }
      })

      -- TypeScript
      lspconfig.ts_ls.setup({})

      -- Lua
      lspconfig.lua_ls.setup({
        settings = {
          Lua = {
            runtime = { version = 'LuaJIT' },
            diagnostics = { globals = { 'vim' } },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
              checkThirdParty = false,
            },
            telemetry = { enable = false },
          }
        }
      })

      -- HTML, CSS, JSON, etc.
      lspconfig.html.setup({})
      lspconfig.cssls.setup({})
      lspconfig.jsonls.setup({})
      lspconfig.pyright.setup({})
      lspconfig.eslint.setup({})
      lspconfig.emmet_ls.setup({
        filetypes = { "html", "css", "tpl" }
      })

      print("✅ LSP configurés directement")
    end
  },




  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
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
    end
  },

  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "lua", "javascript", "python", "html", "css" },
        highlight = { enable = true },
        indent = { enable = true },
      })
    end
  },

  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local telescope = require("telescope")
      local builtin = require("telescope.builtin")
      telescope.setup()
      vim.keymap.set("n", "<leader>ff", builtin.find_files)
      vim.keymap.set("n", "<leader>fg", builtin.live_grep)
      vim.keymap.set("n", "<leader>fb", builtin.buffers)
      vim.keymap.set("n", "<leader>fh", builtin.help_tags)
    end
  },

  {
    "nvim-tree/nvim-tree.lua",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      require("nvim-tree").setup()
    end
  },

  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("toggleterm").setup()
    end
  },

  { "ThePrimeagen/vim-be-good", cmd = { "VimBeGood" } },

  { "ojroques/vim-oscyank" },

  {
    "rcarriga/nvim-notify",
    config = function()
      vim.notify = require("notify")
    end
  },

  {
    "ThePrimeagen/harpoon",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("harpoon").setup()
      vim.keymap.set("n", "<leader>a", require("harpoon.mark").add_file)
      vim.keymap.set("n", "<leader>h", require("harpoon.ui").toggle_quick_menu)
    end
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    version = "v2",
    config = function()
      require("indent_blankline").setup({
        show_current_context = true,
        show_current_context_start = true,
      })
    end
  },
  {
    "github/copilot.vim",
  },

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


  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup()
    end
  },

  { "stevearc/conform.nvim", opts = {} },
})

require("conform").setup({
  format_on_save = {
    timeout_ms = 500,
    lsp_format = "fallback",
  },
})

-- Raccourcis pratiques
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>t", ":ToggleTerm<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>g", ":VimBeGood<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>c", "<Plug>OSCYankOperator")
vim.keymap.set("n", "<leader>cc", "<leader>c_", { remap = true })
vim.keymap.set("v", "<leader>c", "<Plug>OSCYankVisual")

vim.cmd([[
function! ClockwiseNavigation()
  let l:current_win = winnr()
  let l:max_win = winnr('$')
  if l:current_win == l:max_win
    execute "1wincmd w"
  else
    execute "wincmd w"
  endif
endfunction
]])

vim.api.nvim_set_keymap('n', '<Leader><Tab>', ':call ClockwiseNavigation()<CR>', { noremap = true, silent = true })
